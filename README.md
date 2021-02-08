# Git Sync

A GitHub Action for mirroring between two independent repositories using **force push**.

## Features
- Mirror branches/refs between two repositories
- GitHub action can be triggered on a timer or on push
- Repository types supported include GitHub, AWS CodeCommit and BitBucket
- To Mirror with current repository, please checkout [Github Repo Sync](https://github.com/marketplace/actions/github-repo-sync)

## Pre-requsite
- It is assumed the target repository URL is the SSH format

## Usage

> Always make a full backup of your repo (`git clone --mirror`) before using this action.

### GitHub Actions

```yml
# .github/workflows/git-mirror.yml

on: push
jobs:  
  git-sync:
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
      # Mirror to CodeCommit
      - name: mirror to codecommit
        uses: 2pisoftware/git-mirror-action@main
        with:                                       
          github_token: ${{ secrets.GITHUB_TOKEN }}
          repository_owner: ${{ github.repository_owner }}
          repository: ${{ github.repository }}
          target_repo: "<CODECOMMIT_SSH_URL>"          
          target_ssh_private_key: ${{ secrets.AWS_CODECOMMIT_SSH_PRIVATE_KEY }}
          target_ssh_username: ${{ secrets.AWS_CODECOMMIT_SSH_USERNAME }}
      # Mirror to GitHub
      - name: mirror to github
        uses: 2pisoftware/git-mirror-action@main
        with:                                       
          github_token: ${{ secrets.GITHUB_TOKEN }}
          repository_owner: ${{ github.repository_owner }}
          repository: ${{ github.repository }}
          target_repo: "<GITHUB_SSH_URL>"
          target_ssh_private_key: ${{ secrets.GH_MIRROR_SSH_PRIVATE_KEY }}
      # Mirror to BitBucket
      - name: mirror to bitbucket
        uses: 2pisoftware/git-mirror-action@main
        with:                                       
          github_token: ${{ secrets.GITHUB_TOKEN }}
          repository_owner: ${{ github.repository_owner }}
          repository: ${{ github.repository }}
          target_repo: "<BITBUCKET_SSH_URL>"
          target_ssh_private_key: ${{ secrets.BB_MIRROR_SSH_PRIVATE_KEY }}

```