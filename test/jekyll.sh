#!/usr/bin/env bash

# Developer:
# ---------
# Name:      Maik Ellerbrock
# GitHub:    https://github.com/ellerbrock
# Twitter:   https://twitter.com/frapsoft
# Docker:    https://hub.docker.com/u/ellerbrock
# Quay:      https://quay.io/user/ellerbrock
#
# Description:
# -----------
# Travis Test for Jekyll Sites

set -e

# CONFIGURATION
SITE_ROOT="./"

cd ${SITE_ROOT}

bundle install
bundle exec jekyll build
bundle exec htmlproofer --checks-to-ignore vendor/* ./_site

