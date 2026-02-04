# Code Quality Check Command

Run linters, formatters, and quality checks for various languages.

## Purpose

Ensure code quality with automated linting, formatting, and static analysis.

## JavaScript/TypeScript

### ESLint
```bash
# Run ESLint
npx eslint .
npx eslint src/

# Fix auto-fixable issues
npx eslint . --fix

# Check specific file
npx eslint src/utils.ts

# With specific config
npx eslint . --config .eslintrc.json
```

### Prettier
```bash
# Check formatting
npx prettier --check .

# Fix formatting
npx prettier --write .

# Check specific files
npx prettier --check "src/**/*.{js,ts,jsx,tsx}"

# Write specific files
npx prettier --write "src/**/*.{js,ts,jsx,tsx}"
```

### TypeScript
```bash
# Type check
npx tsc --noEmit

# Type check with watch
npx tsc --noEmit --watch

# Type check specific file
npx tsc --noEmit src/utils.ts
```

### Combined Check
```bash
# Check everything
npm run lint        # ESLint
npm run format      # Prettier check
npm run type-check  # TypeScript

# Or create a script in package.json:
# "check": "npm run lint && npm run format && npm run type-check"
npm run check
```

## Python

### Black (Formatter)
```bash
# Check formatting
black --check .

# Format code
black .

# Format specific file
black src/utils.py

# Diff mode
black --diff .
```

### Pylint (Linter)
```bash
# Run pylint
pylint src/

# With specific config
pylint --rcfile=.pylintrc src/

# Check specific file
pylint src/utils.py

# Generate config
pylint --generate-rcfile > .pylintrc
```

### Flake8 (Style Guide)
```bash
# Run flake8
flake8 .

# With config
flake8 --config=.flake8

# Check specific directory
flake8 src/

# Ignore specific errors
flake8 --ignore=E203,W503 .
```

### mypy (Type Checker)
```bash
# Type check
mypy src/

# Strict mode
mypy --strict src/

# Check specific file
mypy src/utils.py

# With config
mypy --config-file mypy.ini src/
```

### isort (Import Sorter)
```bash
# Check import order
isort --check-only .

# Fix imports
isort .

# Diff mode
isort --diff .
```

### Combined Check
```bash
# Run all checks
black --check . && \
pylint src/ && \
flake8 . && \
mypy src/ && \
isort --check-only .

# Or create a script
# check.sh
```

## Go

### gofmt (Formatter)
```bash
# Check formatting
gofmt -l .

# Format code
gofmt -w .

# Show diff
gofmt -d .
```

### go vet (Static Analysis)
```bash
# Run go vet
go vet ./...

# Check specific package
go vet ./pkg/utils
```

### golint
```bash
# Install
go install golang.org/x/lint/golint@latest

# Run golint
golint ./...

# Check specific package
golint ./pkg/utils
```

### golangci-lint (Comprehensive)
```bash
# Install
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Run all linters
golangci-lint run

# Run with config
golangci-lint run --config .golangci.yml

# Auto-fix issues
golangci-lint run --fix
```

### Combined Check
```bash
# Run all checks
gofmt -l . && \
go vet ./... && \
golangci-lint run
```

## Java

### Checkstyle
```bash
# Maven
mvn checkstyle:check

# Gradle
gradle checkstyleMain
gradle checkstyleTest
```

### SpotBugs
```bash
# Maven
mvn spotbugs:check

# Gradle
gradle spotbugsMain
```

### PMD
```bash
# Maven
mvn pmd:check

# Gradle
gradle pmdMain
```

### Combined Check (Maven)
```bash
mvn clean verify checkstyle:check spotbugs:check pmd:check
```

## Ruby

### RuboCop
```bash
# Run RuboCop
rubocop

# Auto-fix
rubocop -a

# Safe auto-fix only
rubocop -A

# Check specific files
rubocop app/ spec/
```

## Rust

### rustfmt (Formatter)
```bash
# Check formatting
cargo fmt -- --check

# Format code
cargo fmt
```

### Clippy (Linter)
```bash
# Run clippy
cargo clippy

# Strict mode
cargo clippy -- -D warnings

# Fix suggestions
cargo clippy --fix
```

### Combined Check
```bash
cargo fmt -- --check && \
cargo clippy -- -D warnings && \
cargo test
```

## .NET

### dotnet format
```bash
# Check formatting
dotnet format --verify-no-changes

# Format code
dotnet format

# Analyze code
dotnet build /p:TreatWarningsAsErrors=true
```

## Shell Scripts

### shellcheck
```bash
# Install
apt-get install shellcheck  # Debian/Ubuntu
brew install shellcheck     # macOS

# Check script
shellcheck script.sh

# Check all scripts
find . -name "*.sh" -exec shellcheck {} \;
```

### shfmt (Shell Formatter)
```bash
# Install
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# Check formatting
shfmt -d .

# Format scripts
shfmt -w .
```

## Markdown

### markdownlint
```bash
# Install
npm install -g markdownlint-cli

# Check markdown
markdownlint '**/*.md'

# Fix auto-fixable issues
markdownlint '**/*.md' --fix

# With config
markdownlint -c .markdownlint.json '**/*.md'
```

## YAML

### yamllint
```bash
# Install
pip install yamllint

# Check YAML files
yamllint .

# With config
yamllint -c .yamllint .
```

## Pre-commit Hooks

### Setup pre-commit
```bash
# Install pre-commit
pip install pre-commit

# Create .pre-commit-config.yaml
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/psf/black
    rev: 23.1.0
    hooks:
      - id: black

  - repo: https://github.com/PyCQA/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
EOF

# Install hooks
pre-commit install

# Run manually
pre-commit run --all-files
```

## CI Configuration

### GitHub Actions Example
```yaml
name: Code Quality

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run ESLint
        run: npm run lint
      
      - name: Check formatting
        run: npm run format:check
      
      - name: Type check
        run: npm run type-check
```

## Quick Check Script

Create a universal check script:

```bash
#!/bin/bash
# save as: check-code.sh

echo "Running code quality checks..."

# JavaScript/TypeScript
if [ -f "package.json" ]; then
    echo "Checking JavaScript/TypeScript..."
    npm run lint || exit 1
    npx prettier --check . || exit 1
    npx tsc --noEmit || exit 1
fi

# Python
if [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
    echo "Checking Python..."
    black --check . || exit 1
    pylint src/ || exit 1
    mypy src/ || exit 1
fi

# Go
if [ -f "go.mod" ]; then
    echo "Checking Go..."
    gofmt -l . || exit 1
    go vet ./... || exit 1
fi

echo "All checks passed!"
```

## Usage

### Before Committing
```bash
# Run checks
npm run lint
npm run format
npm run type-check

# Or use pre-commit hooks
git commit  # Hooks run automatically
```

### In CI/CD
```bash
# Run as part of build
npm run check && npm test && npm run build
```

### Daily Development
```bash
# Set up watch mode
npm run lint:watch
npx tsc --noEmit --watch
```

## Tips

- Run linters before committing
- Use pre-commit hooks for automation
- Configure IDE for auto-formatting
- Set up CI to enforce checks
- Keep configuration minimal
- Fix issues, don't disable rules
- Share configuration across team
