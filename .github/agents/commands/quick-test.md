# Quick Test Command

Run tests quickly for common frameworks.

## Purpose

Provide quick shortcuts for running tests across different languages and frameworks.

## Commands by Language/Framework

### JavaScript/TypeScript

#### Jest
```bash
# Run all tests
npm test

# Run tests in watch mode
npm test -- --watch

# Run tests with coverage
npm test -- --coverage

# Run specific test file
npm test -- path/to/test.spec.js

# Run tests matching pattern
npm test -- -t "test name pattern"

# Update snapshots
npm test -- -u
```

#### Vitest
```bash
# Run all tests
npm run test

# Watch mode
npm run test:watch

# Coverage
npm run test:coverage

# UI mode
npm run test:ui

# Run specific file
npm run test path/to/test.spec.ts
```

#### Mocha
```bash
# Run all tests
npm test
mocha

# Run specific file
mocha test/mytest.spec.js

# Watch mode
mocha --watch

# With coverage (using nyc)
nyc mocha
```

### Python

#### pytest
```bash
# Run all tests
pytest

# Verbose output
pytest -v

# Run specific file
pytest tests/test_module.py

# Run specific test
pytest tests/test_module.py::test_function

# Run with coverage
pytest --cov=src tests/

# Show coverage report
pytest --cov=src --cov-report=html tests/

# Run tests matching pattern
pytest -k "test_pattern"

# Stop on first failure
pytest -x

# Run last failed tests
pytest --lf
```

#### unittest
```bash
# Run all tests
python -m unittest discover

# Run specific test
python -m unittest tests.test_module.TestClass.test_method

# Verbose output
python -m unittest discover -v
```

### Java

#### Maven
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=TestClassName

# Run specific test method
mvn test -Dtest=TestClassName#testMethod

# Skip tests
mvn install -DskipTests
```

#### Gradle
```bash
# Run all tests
gradle test

# Run specific test class
gradle test --tests TestClassName

# Run tests matching pattern
gradle test --tests "*Pattern*"

# Run with info logging
gradle test --info
```

### Go
```bash
# Run all tests
go test ./...

# Verbose output
go test -v ./...

# Run specific test
go test -run TestFunctionName

# Run with coverage
go test -cover ./...

# Generate coverage report
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
```

### Ruby

#### RSpec
```bash
# Run all tests
rspec

# Run specific file
rspec spec/models/user_spec.rb

# Run specific test
rspec spec/models/user_spec.rb:42

# Run with documentation format
rspec --format documentation

# Run failed tests
rspec --only-failures
```

### .NET

#### dotnet test
```bash
# Run all tests
dotnet test

# Run with verbose output
dotnet test --logger "console;verbosity=detailed"

# Run specific test
dotnet test --filter FullyQualifiedName~TestMethod

# Run with coverage
dotnet test /p:CollectCoverage=true
```

## Quick Aliases

Add these to your shell profile for even faster testing:

### Bash/Zsh
```bash
# Add to ~/.bashrc or ~/.zshrc

# Quick test aliases
alias t='npm test'
alias tw='npm test -- --watch'
alias tc='npm test -- --coverage'

# Python
alias pt='pytest'
alias ptv='pytest -v'
alias ptc='pytest --cov=src tests/'

# Go
alias gt='go test ./...'
alias gtv='go test -v ./...'
```

### Fish Shell
```fish
# Add to ~/.config/fish/config.fish

# Quick test aliases
alias t 'npm test'
alias tw 'npm test -- --watch'
alias tc 'npm test -- --coverage'
```

## Framework Detection Script

Create a script to auto-detect and run tests:

```bash
#!/bin/bash
# Save as: run-tests.sh

# Auto-detect test framework and run tests

if [ -f "package.json" ]; then
    echo "Detected Node.js project"
    npm test
elif [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
    echo "Detected Python project"
    pytest
elif [ -f "pom.xml" ]; then
    echo "Detected Maven project"
    mvn test
elif [ -f "build.gradle" ]; then
    echo "Detected Gradle project"
    gradle test
elif [ -f "go.mod" ]; then
    echo "Detected Go project"
    go test ./...
elif [ -f "Gemfile" ]; then
    echo "Detected Ruby project"
    rspec
elif [ -f "*.csproj" ]; then
    echo "Detected .NET project"
    dotnet test
else
    echo "Could not detect project type"
    exit 1
fi
```

## Usage Examples

### Quick test during development
```bash
# Run tests
npm test

# Keep tests running while you code
npm test -- --watch
```

### Before committing
```bash
# Run all tests with coverage
npm test -- --coverage

# Check if coverage meets threshold
```

### Continuous Integration
```bash
# Run tests with verbose output and coverage
npm test -- --coverage --verbose --ci
```

## Tips

### Speed up tests
- Run only changed tests during development
- Use watch mode for instant feedback
- Parallelize tests when possible
- Mock slow dependencies

### Organize tests
- Group related tests in describe blocks
- Use descriptive test names
- Keep tests independent
- Use setup/teardown appropriately

### Debug failing tests
- Run single test in isolation
- Use verbose output
- Add console.log or print statements
- Use debugger

## Common Issues

### Tests failing randomly
- Check for race conditions
- Ensure tests are independent
- Mock time-dependent code
- Check for shared state

### Tests too slow
- Mock external services
- Use test databases in memory
- Parallelize test execution
- Profile to find slow tests

### Coverage not accurate
- Check ignore patterns
- Ensure all code paths tested
- Look for untested edge cases
- Review coverage reports
