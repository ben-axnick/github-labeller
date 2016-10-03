#!/usr/bin/env bash

# The purpose of this script is to remove the set of default labels on a
# project, replacing them with our own accepted standard. You can obtain
# a token by going into your account setttings and creating an API key
# with full private repo controls (that's as much as it can be narrowed down)
#
# Usage:
#
# Specify arguments via command line, GH_USER and GH_TOKEN for auth, and
# GH_OWNER and GH_REPO to target a repository.

set -u

if [ -z "${GH_USER-}" ]; then
	echo "Provide a \$GH_USER"
  exit 1;
fi

if [ -z "${GH_TOKEN-}" ]; then
	echo "Provide a \$GH_TOKEN"
  exit 1;
fi

if [ -z "${GH_REPO-}" ]; then
	echo "Provide a \$GH_REPO"
  exit 1;
fi

GH_OWNER=${OWNER-$GH_USER}

function gh_label_delete {
  URL="https://api.github.com/repos/${GH_OWNER}/${GH_REPO}/labels/$1"
  ENCODED_URL=`echo ${URL} | sed 's/ /%20/'` # hack to handle spaces

	curl \
    --silent \
    --include \
    --user "${GH_USER}:${GH_TOKEN}" \
    --request DELETE \
    ${ENCODED_URL} &
}

function gh_label_create {
	curl \
    --silent \
    --include \
    --user "${GH_USER}:${GH_TOKEN}" \
    --request POST --data "{\"name\":\"$1\",\"color\":\"$2\"}" \
    "https://api.github.com/repos/${GH_OWNER}/${GH_REPO}/labels" &
}


# Remove all the standard labels that GitHub places onto a repo by default

echo "Deleting default labels"

gh_label_delete "bug"
gh_label_delete "duplicate"
gh_label_delete "enhancement"
gh_label_delete "help wanted"
gh_label_delete "invalid"
gh_label_delete "question"
gh_label_delete "wontfix"

wait


# Create new set of labels, customize according to preference

echo "Creating new labels"

gh_label_create "blocked" "f7c6c7"
gh_label_create "bug fix" "e11d21"
gh_label_create "In QA" "006b75"
gh_label_create "discussion" "fbca04"
gh_label_create "performance" "c7def8"
gh_label_create "ready for review" "009800"
gh_label_create 'ship it!' "5319e7"
gh_label_create "tech debt" "bfe5bf"
gh_label_create "WIP" "fad8c7"
gh_label_create '¯\\_(ツ)_/¯' "0052cc"

wait
