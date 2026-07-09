#!/bin/bash

ALLOWED_PATTERNS=(
    "^en/docs/.*\.md$"                                      # Markdown documentation files
    "^en/docs/.*\.(yaml|yml)$"                              # API specifications (OpenAPI/Swagger), config files
    "^en/mkdocs\.yml$"                                      # Navigation config (only when adding new pages)
    "^en/docs/assets/img/.*\.(png|jpg|jpeg|gif|webp)$"      # Safe image formats (NO SVG - can contain JS)
)

# Get list of files staged for commit
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACMR)

if [ -z "$STAGED_FILES" ]; then
    exit 0
fi

echo "Pre-commit validation: Checking staged files against whitelist..."

# Check if all changes are within allowed patterns (whitelist enforcement)
INVALID_FOUND=false

for file in $STAGED_FILES; do
    ALLOWED=false

    for pattern in "${ALLOWED_PATTERNS[@]}"; do
        if echo "$file" | grep -qE "$pattern"; then
            ALLOWED=true
            break
        fi
    done

    if [ "$ALLOWED" = false ]; then
        echo "❌ COMMIT BLOCKED: File outside allowed paths: $file"
        INVALID_FOUND=true
    fi
done

if [ "$INVALID_FOUND" = true ]; then
    echo ""
    echo "========================================"
    echo "COMMIT REJECTED - WHITELIST VIOLATION"
    echo "========================================"
    echo "You attempted to commit files that are NOT on the whitelist."
    echo ""
    echo "ONLY these file patterns are allowed:"
    for pattern in "${ALLOWED_PATTERNS[@]}"; do
        echo "  - $pattern"
    done
    echo ""
    echo "Examples of FORBIDDEN files (not exhaustive):"
    echo "  - .github/workflows/* (workflow files)"
    echo "  - en/requirements.txt (dependencies)"
    echo "  - en/hooks.py (executable Python code)"
    echo "  - *.svg files (can contain JavaScript)"
    echo "  - Any configuration files not explicitly allowed above"
    echo ""
    echo "Please unstage unauthorized files before committing."
    exit 1
fi

# Check for secrets in staged changes
echo ""
echo "Scanning for secrets in staged changes..."
SECRETS_FOUND=false

# Get the diff of staged changes
STAGED_DIFF=$(git diff --cached)

# Check for common secret patterns
if echo "$STAGED_DIFF" | grep -qE '(ghp_[a-zA-Z0-9]{36}|ghs_[a-zA-Z0-9]{36}|sk-[a-zA-Z0-9]{32,}|xox[baprs]-[a-zA-Z0-9-]+|AKIA[0-9A-Z]{16}|[A-Za-z0-9+/]{40}=?$)' || \
   echo "$STAGED_DIFF" | grep -qiE '(password|secret|api[_-]?key|token)\s*[:=]\s*["\x27][^"\x27\s]{8,}["\x27]'; then
    echo "❌ COMMIT BLOCKED: Potential secrets detected in staged changes"
    echo ""
    echo "Detected patterns that may contain secrets:"
    echo "$STAGED_DIFF" | grep -E '(ghp_[a-zA-Z0-9]{36}|ghs_[a-zA-Z0-9]{36}|sk-[a-zA-Z0-9]{32,}|xox[baprs]-[a-zA-Z0-9-]+|AKIA[0-9A-Z]{16})' || true
    echo "$STAGED_DIFF" | grep -iE '(password|secret|api[_-]?key|token)\s*[:=]\s*["\x27][^"\x27\s]{8,}["\x27]' || true
    SECRETS_FOUND=true
fi

if [ "$SECRETS_FOUND" = true ]; then
    echo ""
    echo "========================================"
    echo "COMMIT REJECTED - SECRETS DETECTED"
    echo "========================================"
    echo "Your staged changes contain potential secrets or API keys."
    echo "Please remove sensitive data before committing."
    exit 1
fi

echo "✅ No secrets detected"
echo "✅ Pre-commit validation passed"
exit 0
