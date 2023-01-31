#!/bin/sh
#
# Usage:   ./prs-authors-and-forks.sh REPO
# Example: ./prs-authors-and-forks.sh cosmos/cosmos-sdk
# Requirements: 'hub'
#
# This script lists open and closed PRs, and extract author and related fork to a CSV file.

REPO=$1

echo "state,fork,author,pr-number,date"
hub api --paginate "repos/${REPO}/pulls?state=all" | \
    jq -r '.[] | [
      .state,
      .head.user.login,
      .user.login,
      .number,
      .created_at
    ] | join(",")'
