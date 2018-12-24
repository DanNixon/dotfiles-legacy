package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/google/go-github/github"
	"golang.org/x/oauth2"
)

func getClient(token string) (client *github.Client, err error) {
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(oauth2.NoContext, ts)
	client = github.NewClient(tc)
	return
}

func getStarred(client *github.Client) {
	ctx := context.Background()
	opt := &github.ActivityListStarredOptions{ListOptions: github.ListOptions{PerPage: 10, Page: 1}}
	for {
		repos, resp, err := client.Activity.ListStarred(ctx, "", opt)
		if err != nil {
			log.Println(err)
		}

		for _, repo := range repos {
			desc := "No description"
			if repo.Repository.Description != nil {
				desc = *repo.Repository.Description
			}

			fmt.Printf("%s\t%s/%s\t%s\t%s\n", *repo.Repository.HTMLURL, *repo.Repository.Owner.Login, *repo.Repository.Name, desc, repo.GetStarredAt())
		}

		if resp.NextPage == 0 {
			break
		}
		opt.ListOptions.Page = resp.NextPage
	}
	return
}

func main() {
	token := os.Args[1]

	client, err := getClient(token)
	if err != nil {
		log.Fatal(err)
	}

	getStarred(client)
}
