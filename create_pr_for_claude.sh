#!/bin/bash

# This script helps Claude create pull requests by handling the Git operations
# It takes care of committing changes, pushing to the fork, and creating the PR

# Function to log messages with timestamp
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to handle errors
handle_error() {
    log_message "ERROR: $1"
    exit 1
}

# Check required parameters
if [ $# -lt 4 ]; then
    handle_error "Usage: $0 <repo-dir> <branch-name> <commit-message> <pr-title> [pr-body] [base-branch]"
fi

REPO_DIR=$1
BRANCH_NAME=$2
COMMIT_MESSAGE=$3
PR_TITLE=$4
PR_BODY=${5:-"This PR fixes the issue identified by Claude AI"}
BASE_BRANCH=${6:-"main"}

# Make sure the repository directory exists
if [ ! -d "$REPO_DIR" ]; then
    handle_error "Repository directory does not exist: $REPO_DIR"
fi

# Make sure we have the required environment variables
if [ -z "$GITHUB_TOKEN" ]; then
    handle_error "GITHUB_TOKEN environment variable is not set."
fi

if [ -z "$REPO_OWNER" ] || [ -z "$REPO_NAME" ]; then
    handle_error "REPO_OWNER or REPO_NAME environment variables are not set."
fi

REPO_FULLNAME="${REPO_OWNER}/${REPO_NAME}"
ORIGINAL_REPO="${ORIGINAL_REPO:-$REPO_FULLNAME}"

log_message "Creating PR for branch: ${BRANCH_NAME}"
log_message "Repository: ${REPO_FULLNAME}"
log_message "Original repository: ${ORIGINAL_REPO}"

# Navigate to the repository
cd "$REPO_DIR" || handle_error "Failed to navigate to repository directory"

# Check if there are changes to commit
if git diff --quiet && git diff --cached --quiet; then
    handle_error "No changes to commit"
fi

# Stage all changes
log_message "Staging changes..."
git add . || handle_error "Failed to stage changes"

# Commit changes
log_message "Committing changes..."
git commit -m "$COMMIT_MESSAGE" || handle_error "Failed to commit changes"

# Push to fork
log_message "Pushing to fork..."
git push fork "$BRANCH_NAME" || handle_error "Failed to push to fork"

# Create PR
log_message "Creating PR..."
PR_URL=$(gh pr create \
    --repo "$ORIGINAL_REPO" \
    --head "${REPO_OWNER}:${BRANCH_NAME}" \
    --base "$BASE_BRANCH" \
    --title "$PR_TITLE" \
    --body "$PR_BODY")

if [ $? -eq 0 ]; then
    log_message "PR created successfully"
    log_message "PR URL: $PR_URL"
    echo "$PR_URL"
else
    handle_error "Failed to create PR"
fi
