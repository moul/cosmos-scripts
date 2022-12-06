#!/bin/sh
#
# Usage:   ./interesting-repos-forks.sh REPO
# Example: ./interesting-repos-forks.sh cosmos/cosmos-sdk
# Requirements: 'hub'
#
# This script lookups existing forks of a repo and create a CSV file.

REPO=$1

echo "full_name,size,created_at,updated_at,pushed_at,open_issues,stars,watchers"
hub api "repos/${REPO}/forks" --paginate | \
    jq -r '.[] | [
       .full_name,
       (.size|tostring),
       .created_at,
       .updated_at,
       .pushed_at,
       (.open_issues_count|tostring),
       (.forks_count|tostring),
       (.stargazers_count|tostring),
       (.watchers_count|tostring)
     ] | join(",")'
