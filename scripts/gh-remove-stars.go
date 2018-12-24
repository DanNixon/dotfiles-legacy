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

func removeStarred(client *github.Client) {
	ctx := context.Background()
	opt := &github.ActivityListStarredOptions{ListOptions: github.ListOptions{PerPage: 10, Page: 1}}
	for {
		repos, resp, err := client.Activity.ListStarred(ctx, "", opt)
		if err != nil {
			log.Println(err)
		}

		for _, repo := range repos {
			fmt.Printf("%s/%s...", *(repo.Repository.Owner.Login), *(repo.Repository.Name))
			resp, err := client.Activity.Unstar(ctx, *(repo.Repository.Owner.Login), *(repo.Repository.Name))
			fmt.Printf("\t\t%s (%s)\n", resp.Response.Status, err)
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

	removeStarred(client)
}
