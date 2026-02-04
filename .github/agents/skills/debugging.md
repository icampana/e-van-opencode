# Debugging Skill

This skill helps systematically debug issues in code.

## Purpose

Find and fix bugs efficiently using systematic debugging techniques and tools.

## Debugging Process

### 1. Understand the Problem
- Read error messages carefully
- Identify expected vs actual behavior
- Determine when the issue occurs
- Check if it's reproducible

### 2. Isolate the Issue
- Create minimal reproduction
- Identify which component fails
- Narrow down the problematic code
- Check recent changes

### 3. Form Hypothesis
- What could cause this behavior?
- What assumptions might be wrong?
- Are there related issues?
- Check edge cases

### 4. Test Hypothesis
- Add logging
- Use debugger
- Create test cases
- Verify assumptions

### 5. Fix and Verify
- Implement fix
- Test thoroughly
- Add regression test
- Document the issue

## Debugging Techniques

### Print Debugging
```javascript
// Basic logging
console.log('Variable value:', variable);

// Logging with context
console.log('Before API call:', { url, params });
console.log('After API call:', { response });

// Log function entry/exit
function processData(data) {
  console.log('processData called with:', data);
  const result = transform(data);
  console.log('processData returning:', result);
  return result;
}

// Python
print(f'Variable value: {variable}')
print(f'Debug info: {variable!r}')  # repr format
```

### Using Debuggers

#### JavaScript (Node.js)
```bash
# Start with debugger
node --inspect script.js
node --inspect-brk script.js  # Break at start

# In code
debugger;  // Breakpoint

# Chrome DevTools
# Open chrome://inspect
```

#### Python
```bash
# Use pdb
python -m pdb script.py

# In code
import pdb; pdb.set_trace()

# With IPython
from IPython import embed; embed()
```

#### Debugger Commands
```
# Common commands (pdb/gdb/etc)
n        # Next line
s        # Step into function
c        # Continue execution
p var    # Print variable
l        # List code
bt       # Backtrace (call stack)
q        # Quit debugger
```

### Binary Search Debugging
```bash
# Find when bug was introduced
git bisect start
git bisect bad HEAD
git bisect good v1.0.0

# Test each commit
# Mark as good or bad
git bisect good
git bisect bad

# Git will narrow down the problematic commit
```

### Rubber Duck Debugging
Explain the problem out loud (or in comments):
```javascript
// I'm trying to sort users by age
// Input: array of user objects
// Expected: sorted by age ascending
// Actual: not sorted

function sortUsers(users) {
  // Wait, I'm not returning the sorted array!
  users.sort((a, b) => a.age - b.age);
  return users;  // Added this!
}
```

## Common Issues and Solutions

### Null/Undefined Errors
```javascript
// Problem
const name = user.profile.name;  // TypeError: Cannot read property 'name' of undefined

// Debug
console.log('user:', user);
console.log('user.profile:', user.profile);

// Solutions
const name = user?.profile?.name ?? 'Unknown';
const name = (user && user.profile && user.profile.name) || 'Unknown';
```

### Async Issues
```javascript
// Problem
async function getData() {
  const result = fetch('/api/data');  // Missing await!
  console.log(result);  // [object Promise]
}

// Solution
async function getData() {
  const result = await fetch('/api/data');
  console.log(result);  // Actual data
}

// Problem: Unhandled rejection
fetch('/api/data');  // No error handling

// Solution
fetch('/api/data')
  .then(handleData)
  .catch(handleError);
```

### Race Conditions
```javascript
// Problem
let counter = 0;
async function increment() {
  const current = counter;
  await someAsyncOperation();
  counter = current + 1;  // May overwrite other increments
}

// Solution
let counter = 0;
const lock = new Mutex();
async function increment() {
  await lock.acquire();
  try {
    counter++;
  } finally {
    lock.release();
  }
}
```

### Off-by-One Errors
```javascript
// Problem
for (let i = 0; i <= array.length; i++) {  // <= instead of <
  console.log(array[i]);  // undefined on last iteration
}

// Solution
for (let i = 0; i < array.length; i++) {
  console.log(array[i]);
}

// Or better
for (const item of array) {
  console.log(item);
}
```

### Type Coercion Issues
```javascript
// Problem
const value = '5';
const result = value + 5;  // '55' not 10

// Debug
console.log(typeof value);  // 'string'

// Solutions
const result = Number(value) + 5;  // 10
const result = parseInt(value, 10) + 5;  // 10
const result = +value + 5;  // 10
```

## Debugging Tools

### Browser DevTools
- Console: Log messages and errors
- Sources: Set breakpoints, step through code
- Network: Inspect API calls
- Performance: Profile performance issues
- Memory: Find memory leaks

### Command Line Tools
```bash
# Check process status
ps aux | grep node

# Monitor resources
top
htop

# Network debugging
curl -v https://api.example.com
netstat -an | grep LISTEN

# Check logs
tail -f /var/log/app.log
grep ERROR /var/log/app.log
```

### Logging Tools
```javascript
// Structured logging
const logger = require('winston');
logger.error('Database connection failed', {
  error: err.message,
  host: dbConfig.host,
  timestamp: new Date()
});

// Python
import logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)
logger.debug('Debug message', extra={'user_id': 123})
```

## Best Practices

### Good Logging
```javascript
// Bad
console.log('error');

// Good
console.error('Failed to fetch user data', {
  userId: 123,
  error: error.message,
  stack: error.stack,
  timestamp: new Date().toISOString()
});
```

### Assertions
```javascript
// Add assertions for assumptions
function processOrder(order) {
  console.assert(order !== null, 'Order cannot be null');
  console.assert(order.items.length > 0, 'Order must have items');
  // Process order...
}
```

### Error Context
```javascript
// Include context in errors
try {
  await processPayment(order);
} catch (error) {
  throw new Error(
    `Payment processing failed for order ${order.id}: ${error.message}`
  );
}
```

## When to Use Each Technique

### Print Debugging
- Quick check of variable values
- Understanding program flow
- When debugger isn't available
- Simple issues

### Debugger
- Complex issues requiring step-through
- Need to inspect multiple variables
- Understanding execution flow
- Interactive exploration

### Binary Search
- Bug introduced recently
- Large codebase
- Finding regression source
- Many commits to check

### Logging
- Production issues
- Long-running processes
- Understanding patterns
- Post-mortem analysis

## Checklist

- [ ] Read and understand the error message
- [ ] Reproduce the issue consistently
- [ ] Create minimal reproduction case
- [ ] Check recent changes (git blame/log)
- [ ] Add logging to understand flow
- [ ] Use debugger to inspect state
- [ ] Form and test hypothesis
- [ ] Implement minimal fix
- [ ] Add test to prevent regression
- [ ] Clean up debug code
- [ ] Document the issue and fix

## Usage

Use this skill whenever you need to:
- Fix bugs
- Understand unexpected behavior
- Investigate errors
- Optimize performance
- Understand code flow
