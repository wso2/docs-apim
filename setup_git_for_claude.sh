#!/bin/bash

# This script sets up the Git environment for Claude to work with
# It handles authentication, repository setup, and branch preparation

# Function to log messages with timestamp
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Function to handle errors
handle_error() {
    log_message "ERROR: $1"
    exit 1
}

# Make sure we have the required environment variables
if [ -z "$GITHUB_TOKEN" ]; then
    handle_error "GITHUB_TOKEN environment variable is not set."
fi

if [ -z "$REPO_OWNER" ] || [ -z "$REPO_NAME" ]; then
    handle_error "REPO_OWNER or REPO_NAME environment variables are not set."
fi

if [ -z "$1" ]; then
    handle_error "Usage: $0 <issue-number>"
fi

ISSUE_NUMBER=$1
REPO_FULLNAME="${REPO_OWNER}/${REPO_NAME}"
ORIGINAL_REPO="${ORIGINAL_REPO:-$REPO_FULLNAME}"

log_message "Setting up Git environment for issue #${ISSUE_NUMBER}"
log_message "Repository: ${REPO_FULLNAME}"
log_message "Original repository: ${ORIGINAL_REPO}"

# Configure Git with token-based authentication
git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"
log_message "Configured Git to use token-based authentication"

# Set Git identity
git config --global user.name "Claude AI Agent"
git config --global user.email "noreply@claude.ai"
log_message "Configured Git identity"

# Create a temp directory for the repository
WORK_DIR=$(mktemp -d)
log_message "Working in temporary directory: ${WORK_DIR}"

# Clone the repository
log_message "Cloning repository..."
git clone "https://github.com/${ORIGINAL_REPO}.git" "${WORK_DIR}/repo" || handle_error "Failed to clone repository"

# Navigate to the repository
cd "${WORK_DIR}/repo" || handle_error "Failed to navigate to repository directory"

# Add fork remote
log_message "Adding fork remote..."
git remote add fork "https://github.com/${REPO_FULLNAME}.git" || handle_error "Failed to add fork remote"

# Fetch all branches
log_message "Fetching branches..."
git fetch --all || handle_error "Failed to fetch branches"

# Create a new branch for the issue
BRANCH_NAME="fix-issue-${ISSUE_NUMBER}"
log_message "Creating branch: ${BRANCH_NAME}"
git checkout -b "${BRANCH_NAME}" || handle_error "Failed to create branch"

log_message "Git environment set up successfully"
echo "REPO_DIR=${WORK_DIR}/repo"
echo "BRANCH_NAME=${BRANCH_NAME}"
