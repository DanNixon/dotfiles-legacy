package main

import (
	"fmt"
	"log"

	"github.com/google/go-github/github"
	"github.com/tucnak/climax"
	"golang.org/x/oauth2"
)

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

func main() {
	cli := climax.New("gh-list")
	cli.Brief = "List GitHub repos."

	listCmd := climax.Command{
		Name: "list",

		Flags: []climax.Flag{
			{
				Name:     "token",
				Short:    "t",
				Help:     `GitHub API token.`,
				Variable: true,
			},
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
			token, tokenSet := ctx.Get("token")
			if !tokenSet {
				fmt.Println("Must set API token.")
				return 1
			}

			ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
			tc := oauth2.NewClient(oauth2.NoContext, ts)
			client := github.NewClient(tc)

			var allRepos []*github.Repository

			visibility, visibilitySet := ctx.Get("visibility")
			if !visibilitySet {
				visibility = "all"
			}

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
	}

	cli.AddCommand(listCmd)
	cli.Run()
}
