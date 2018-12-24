package main

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/DanNixon/voile/db"
	"github.com/google/go-github/github"
	"golang.org/x/oauth2"
)

func getClient(token string) (client *github.Client, err error) {
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(oauth2.NoContext, ts)
	client = github.NewClient(tc)
	return
}

func getStarred(client *github.Client, bmks *db.BookmarkLibrary) {
	ctx := context.Background()
	opt := &github.ActivityListStarredOptions{ListOptions: github.ListOptions{PerPage: 10, Page: 1}}
	for {
		repos, resp, err := client.Activity.ListStarred(ctx, "", opt)
		if err != nil {
			log.Println(err)
		}

		for _, repo := range repos {
			bm := bmks.NewEntry()
			bm.Url.Parse(*repo.Repository.HTMLURL)
			bm.Name = fmt.Sprintf("%s/%s", *repo.Repository.Owner.Login, *repo.Repository.Name)
			if repo.Repository.Description != nil {
				bm.Description = *repo.Repository.Description
			}
			bm.WhenAdded = repo.GetStarredAt().Time
			bm.Tags.Tags = []string{"scm_repo", "github"}
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
	bookmarkFilename := os.Args[2]

	client, err := getClient(token)
	if err != nil {
		log.Fatal(err)
	}

	var bmks db.BookmarkLibrary

	raw, _ := ioutil.ReadFile(bookmarkFilename)
	json.Unmarshal(raw, &(bmks.Bookmarks))

	getStarred(client, &bmks)

	raw, _ = json.MarshalIndent(bmks.Bookmarks, "", "  ")
	ioutil.WriteFile(bookmarkFilename, []byte(raw), 00644)
}
