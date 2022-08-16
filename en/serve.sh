#! /bin/sh
set -e
mdspell -r -n -a -t --en-us docs/**/*.md -d dictionary/en_US-large
mkdocs serve