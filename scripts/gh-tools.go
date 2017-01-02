package main

import (
	"fmt"
	"log"

	"github.com/google/go-github/github"
	"github.com/tucnak/climax"
	"golang.org/x/oauth2"
)

func getClient(ctx climax.Context) (client *github.Client, err error) {
	token, tokenSet := ctx.Get("token")
	if !tokenSet {
		err = fmt.Errorf("Must set API token")
		return
	}

	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(oauth2.NoContext, ts)
	client = github.NewClient(tc)
	return
}

func getStarred(client *github.Client, visibility string) (allRepos []*github.Repository) {
	opt := &github.ActivityListStarredOptions{ListOptions: github.ListOptions{PerPage: 10, Page: 1}}
	for {
		repos, resp, err := client.Activity.ListStarred("", opt)
		if err != nil {
			log.Println(err)
		}
		log.Printf("Starred repositories: page %d of %d\n", opt.ListOptions.Page, resp.LastPage)

		for _, repo := range repos {
			private := *repo.Repository.Private
			if visibility == "all" || (visibility == "public" && !private) || (visibility == "private" && private) {
				allRepos = append(allRepos, repo.Repository)
			}
		}

		if resp.NextPage == 0 {
			break
		}
		opt.ListOptions.Page = resp.NextPage
	}
	return
}

func getMine(client *github.Client, visibility string) (allRepos []*github.Repository) {
	opt := &github.RepositoryListOptions{ListOptions: github.ListOptions{PerPage: 10, Page: 1}, Visibility: visibility}
	for {
		repos, resp, err := client.Repositories.List("", opt)
		if err != nil {
			log.Println(err)
		}
		log.Printf("My repositories: page %d of %d\n", opt.ListOptions.Page, resp.LastPage)

		allRepos = append(allRepos, repos...)

		if resp.NextPage == 0 {
			break
		}

		opt.ListOptions.Page = resp.NextPage
	}
	return
}

func deleteAllRepoLabels(client *github.Client, repo *github.Repository) (err error) {
	opt := &github.ListOptions{PerPage: 10, Page: 0}
	labels, _, err := client.Issues.ListLabels(*repo.Owner.Login, *repo.Name, opt)
	if err != nil {
		return
	}

	for _, label := range labels {
		_, err := client.Issues.DeleteLabel(*repo.Owner.Login, *repo.Name, *label.Name)
		if err != nil {
			log.Printf("Failed to delete label \"%s\"\n", *label.Name)
		}
	}

	return
}

func main() {
	cli := climax.New("gh-tools")
	cli.Brief = "Tools for speeding up GitHUb related tasks."

	tokenFlag := climax.Flag{
		Name:     "token",
		Short:    "t",
		Help:     `GitHub API token.`,
		Variable: true,
	}

	cli.AddCommand(climax.Command{
		Name: "list",

		Flags: []climax.Flag{
			tokenFlag,
			{
				Name:     "visibility",
				Short:    "v",
				Help:     `Visibility (all, public, private).`,
				Variable: true,
			},
			{
				Name:     "mine",
				Short:    "m",
				Help:     `Include my personal and organisation repositories.`,
				Variable: false,
			},
			{
				Name:     "starred",
				Short:    "s",
				Help:     `Include my starred repositories.`,
				Variable: false,
			},
		},

		Handle: func(ctx climax.Context) int {
			client, err := getClient(ctx)
			if err != nil {
				log.Fatal(err)
				return 1
			}

			visibility, visibilitySet := ctx.Get("visibility")
			if !visibilitySet {
				visibility = "all"
			}

			var allRepos []*github.Repository
			if ctx.Is("starred") {
				repos := getStarred(client, visibility)
				allRepos = append(allRepos, repos...)
			}
			if ctx.Is("mine") {
				repos := getMine(client, visibility)
				allRepos = append(allRepos, repos...)
			}

			fmt.Printf("Num repos: %d\n", len(allRepos))
			for _, r := range allRepos {
				if *r.Private {
					fmt.Println(*r.SSHURL)
				} else {
					fmt.Println(*r.CloneURL)
				}
			}
			return 0
		},
	})

	cli.AddCommand(climax.Command{
		Name: "new",

		Flags: []climax.Flag{
			tokenFlag,
			{
				Name:     "private",
				Short:    "p",
				Help:     `Create this repository private.`,
				Variable: false,
			},
			{
				Name:     "description",
				Short:    "d",
				Help:     `Repository description.`,
				Variable: true,
			},
		},

		Handle: func(ctx climax.Context) int {
			client, err := getClient(ctx)
			if err != nil {
				log.Fatal(err)
				return 1
			}

			if len(ctx.Args) != 1 {
				log.Fatal("Incorrect number of arguments")
				return 1
			}

			description, _ := ctx.Get("description")

			// New repo
			newRepo := &github.Repository{
				Name:        &ctx.Args[0],
				Description: &description,
				Private:     new(bool),
				HasIssues:   new(bool),
				HasWiki:     new(bool),
			}
			*newRepo.Private = ctx.Is("private")
			*newRepo.HasIssues = true
			*newRepo.HasWiki = false

			// Create repo
			repo, _, err := client.Repositories.Create("", newRepo)
			if err != nil {
				log.Fatal(err)
				return 1
			}

			deleteAllRepoLabels(client, repo)

			fmt.Printf("New repository created: %s\n", *repo.HTMLURL)
			return 0
		},
	})

	cli.Run()
}
