#!/bin/sh
#
# Usage:   ./active-commiters-for-repo.sh REPO
# Example: ./active-commiters-for-repo.sh cosmos/cosmos-sdk
# Requirements: 'hub'
#
# This script lists recent committers (last 100 commits) from a repo and create a CSV file.

REPO=$1

#echo ""
#hub api "repos/${REPO}/contributors" --paginate | \
    #    jq -r '.[] | [
#       .login,
#       (.contributions|tostring)
#     ] | join(",")'

echo "repo,login,email,commits,last_commit"
hub api "repos/${REPO}/commits?per_page=100" | \
    jq -r '.[] | [
      .commit.author.date,
      .author.login,
      .commit.author.email
    ] | join(",")' | \
        tr -s ',' ' ' | \
        sort -k2,2 | \
        uniq -c -f2 | \
        sort -k 2,2 | \
        awk '{print "'$REPO',"$3" "$4" "$1" "$2}' | \
        tr -s ' ' ','
