# Code Review Skill

This skill helps perform thorough, constructive code reviews.

## Purpose

Review code changes to catch issues, suggest improvements, and ensure code quality standards are met.

## Checklist

### Functionality
- [ ] Does the code do what it's supposed to do?
- [ ] Are edge cases handled?
- [ ] Is error handling comprehensive?
- [ ] Are there any logical errors?

### Code Quality
- [ ] Is the code easy to understand?
- [ ] Are variable and function names clear?
- [ ] Is the code properly structured?
- [ ] Are there any code smells?

### Best Practices
- [ ] Does it follow language conventions?
- [ ] Are design patterns used appropriately?
- [ ] Is there unnecessary code duplication?
- [ ] Are comments helpful and necessary?

### Testing
- [ ] Are there tests for new functionality?
- [ ] Do tests cover edge cases?
- [ ] Are tests clear and maintainable?
- [ ] Do all tests pass?

### Security
- [ ] Are inputs validated?
- [ ] Are there SQL injection risks?
- [ ] Is sensitive data properly handled?
- [ ] Are authentication/authorization correct?

### Performance
- [ ] Are there obvious performance issues?
- [ ] Are database queries optimized?
- [ ] Is memory usage reasonable?
- [ ] Are there unnecessary loops or operations?

### Documentation
- [ ] Is new functionality documented?
- [ ] Are API changes reflected in docs?
- [ ] Are complex algorithms explained?
- [ ] Is the README updated if needed?

## Review Guidelines

### Focus on Important Issues
- Critical: Security vulnerabilities, bugs, data loss
- Major: Performance issues, incorrect logic
- Minor: Code style, naming conventions
- Nitpick: Personal preferences

### Be Constructive
- Explain why something should change
- Suggest specific improvements
- Provide examples when helpful
- Acknowledge good code

### Ask Questions
- "Could you explain why...?"
- "Have you considered...?"
- "What happens if...?"

### Use Clear Language
- "This could cause..." instead of "This is wrong"
- "Consider..." instead of "You must..."
- "Suggestion:" instead of "Change this"

## Common Issues to Look For

### Security Issues
```javascript
// Bad: SQL injection risk
query = `SELECT * FROM users WHERE id = ${userId}`;

// Good: Parameterized query
query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

### Error Handling
```javascript
// Bad: Swallowing errors
try {
  riskyOperation();
} catch (e) {
  // Silent failure
}

// Good: Proper error handling
try {
  riskyOperation();
} catch (error) {
  logger.error('Operation failed:', error);
  throw new OperationError('Failed to complete operation', error);
}
```

### Resource Management
```javascript
// Bad: Resource leak
const file = fs.openSync('file.txt');
processFile(file);
// File never closed!

// Good: Ensure cleanup
const file = fs.openSync('file.txt');
try {
  processFile(file);
} finally {
  fs.closeSync(file);
}
```

### Null Safety
```javascript
// Bad: Potential null reference
const userName = user.profile.name;

// Good: Safe navigation
const userName = user?.profile?.name ?? 'Anonymous';
```

## Review Templates

### Approval
```
LGTM! The code looks good. I appreciate:
- Clear function names
- Comprehensive error handling
- Good test coverage

One minor suggestion: Consider extracting the validation logic 
into a separate function for reusability.
```

### Request Changes
```
This needs some changes before merging:

Critical:
- Line 42: SQL injection vulnerability - use parameterized queries

Major:
- Line 15-30: This function is doing too much - consider breaking it down
- Missing error handling for the API call

Minor:
- Consider using const instead of let where variables don't change
```

### Questions
```
I have a few questions before approving:

1. Line 23: What happens if the array is empty?
2. Line 45: Is this timeout value tested? Seems very short.
3. Have you considered using the existing utility function instead?
```

## Usage

1. Get the code changes (diff)
2. Review using the checklist
3. Categorize issues by severity
4. Provide constructive feedback
5. Suggest specific improvements
6. Acknowledge good practices

## Tools

### View Changes
```bash
# See what changed
git diff

# See diff for specific files
git diff path/to/file

# See staged changes
git diff --staged
```

### Run Checks
```bash
# Run linters
npm run lint
pylint src/

# Run tests
npm test
pytest

# Check types
npx tsc --noEmit
mypy src/
```
