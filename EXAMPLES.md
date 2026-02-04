# Example Usage Scenarios

This document provides real-world examples of using the OpenCode settings from this repository.

## 📋 Table of Contents

- [Scenario 1: Starting a New React Project](#scenario-1-starting-a-new-react-project)
- [Scenario 2: Fixing a Production Bug](#scenario-2-fixing-a-production-bug)
- [Scenario 3: Adding Tests to Existing Code](#scenario-3-adding-tests-to-existing-code)
- [Scenario 4: Refactoring Legacy Code](#scenario-4-refactoring-legacy-code)
- [Scenario 5: Code Review Process](#scenario-5-code-review-process)
- [Scenario 6: Setting Up Python API](#scenario-6-setting-up-python-api)
- [Scenario 7: Debugging Intermittent Test Failures](#scenario-7-debugging-intermittent-test-failures)
- [Scenario 8: Team Onboarding](#scenario-8-team-onboarding)

---

## Scenario 1: Starting a New React Project

**Context:** You need to create a new React application with TypeScript.

**References:**
- [Project Setup Command](.github/agents/commands/project-setup.md)
- [JavaScript Expert](.github/agents/javascript-expert.md)
- [Code Quality Check](.github/agents/commands/code-quality-check.md)

**Steps:**

### 1. Bootstrap the Project
```bash
# Create new React app with TypeScript
npm create vite@latest my-app -- --template react-ts
cd my-app
npm install
```

### 2. Set Up Code Quality Tools
```bash
# Install ESLint and Prettier
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier

# Initialize ESLint
npx eslint --init

# Create Prettier config
echo '{"semi": true, "singleQuote": true, "trailingComma": "es5"}' > .prettierrc

# Add scripts to package.json
npm pkg set scripts.lint="eslint src/"
npm pkg set scripts.lint:fix="eslint src/ --fix"
npm pkg set scripts.format="prettier --check src/"
npm pkg set scripts.format:fix="prettier --write src/"
```

### 3. Set Up Testing
```bash
# Install Vitest and React Testing Library
npm install --save-dev vitest @vitest/ui jsdom
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event

# Add test script
npm pkg set scripts.test="vitest"
npm pkg set scripts.test:ui="vitest --ui"
```

### 4. Add OpenCode Configuration
```bash
# Copy OpenCode settings
mkdir -p .github/agents
cp -r /path/to/e-van-opencode/.github/agents/* .github/agents/
```

### 5. Verify Setup
```bash
# Run checks
npm run lint
npm run format
npm run test
npm run build
```

**Result:** A fully configured React + TypeScript project with linting, formatting, and testing ready to go.

---

## Scenario 2: Fixing a Production Bug

**Context:** Users report that the login form crashes when submitting with empty fields.

**References:**
- [Bug Hunter](.github/agents/sub-agents/bug-hunter.md)
- [Debugging Skill](.github/agents/skills/debugging.md)
- [Test Writer](.github/agents/sub-agents/test-writer.md)

**Steps:**

### 1. Reproduce the Issue
```bash
# Check out main branch
git checkout main
git pull origin main

# Run the application
npm run dev

# Try to reproduce:
# 1. Go to login form
# 2. Leave fields empty
# 3. Click submit
# → Observe: TypeError: Cannot read property 'trim' of undefined
```

### 2. Investigate
```bash
# Check recent changes to login form
git log --oneline -- src/components/LoginForm.tsx

# Look at the code
cat src/components/LoginForm.tsx
```

```typescript
// Found the issue in LoginForm.tsx:
const handleSubmit = (e: FormEvent) => {
  e.preventDefault();
  // Problem: username and password might be undefined
  const cleanUsername = username.trim();  // ❌ No null check
  const cleanPassword = password.trim();  // ❌ No null check
  login(cleanUsername, cleanPassword);
};
```

### 3. Create a Fix Branch
```bash
git checkout -b fix/login-form-null-handling
```

### 4. Fix the Issue
```typescript
// src/components/LoginForm.tsx
const handleSubmit = (e: FormEvent) => {
  e.preventDefault();
  
  // ✅ Add validation
  if (!username?.trim() || !password?.trim()) {
    setError('Username and password are required');
    return;
  }
  
  const cleanUsername = username.trim();
  const cleanPassword = password.trim();
  login(cleanUsername, cleanPassword);
};
```

### 5. Add Regression Test
```typescript
// src/components/LoginForm.test.tsx
describe('LoginForm', () => {
  it('should show error when submitting empty username', async () => {
    const { getByRole, getByText } = render(<LoginForm />);
    
    const submitButton = getByRole('button', { name: /submit/i });
    await userEvent.click(submitButton);
    
    expect(getByText('Username and password are required')).toBeInTheDocument();
  });
  
  it('should show error when submitting empty password', async () => {
    const { getByRole, getByLabelText, getByText } = render(<LoginForm />);
    
    const usernameInput = getByLabelText(/username/i);
    await userEvent.type(usernameInput, 'testuser');
    
    const submitButton = getByRole('button', { name: /submit/i });
    await userEvent.click(submitButton);
    
    expect(getByText('Username and password are required')).toBeInTheDocument();
  });
});
```

### 6. Verify Fix
```bash
# Run tests
npm test

# Run linting
npm run lint

# Test manually
npm run dev
# Try empty submission → Should show error message
```

### 7. Commit and Push
```bash
git add .
git commit -m "fix: Handle empty username/password in login form

- Add validation for empty fields
- Show error message to user
- Add regression tests
- Fixes #123"

git push origin fix/login-form-null-handling
```

**Result:** Bug fixed with proper validation, error handling, and tests to prevent regression.

---

## Scenario 3: Adding Tests to Existing Code

**Context:** Legacy authentication module has no tests. Need to add comprehensive test coverage.

**References:**
- [Test Writer](.github/agents/sub-agents/test-writer.md)
- [Python Expert](.github/agents/python-expert.md) (or your language)
- [Quick Test](.github/agents/commands/quick-test.md)

**Steps:**

### 1. Analyze the Code
```python
# src/auth.py
def authenticate_user(username: str, password: str) -> User:
    """Authenticate user with username and password."""
    user = User.query.filter_by(username=username).first()
    if not user:
        raise AuthenticationError("User not found")
    
    if not user.check_password(password):
        raise AuthenticationError("Invalid password")
    
    if not user.is_active:
        raise AuthenticationError("Account disabled")
    
    user.last_login = datetime.utcnow()
    db.session.commit()
    
    return user
```

### 2. Identify Test Cases
From [Test Writer](.github/agents/sub-agents/test-writer.md):
- Happy path (valid credentials)
- Edge cases (empty username, empty password)
- Error conditions (user not found, wrong password, disabled account)
- Side effects (last_login updated)

### 3. Create Test File
```python
# tests/test_auth.py
import pytest
from datetime import datetime
from src.auth import authenticate_user, AuthenticationError
from src.models import User

@pytest.fixture
def active_user(db):
    """Create an active test user."""
    user = User(
        username='testuser',
        email='test@example.com',
        is_active=True
    )
    user.set_password('correct_password')
    db.session.add(user)
    db.session.commit()
    return user

@pytest.fixture
def inactive_user(db):
    """Create an inactive test user."""
    user = User(
        username='inactive',
        email='inactive@example.com',
        is_active=False
    )
    user.set_password('password')
    db.session.add(user)
    db.session.commit()
    return user

class TestAuthenticateUser:
    """Tests for authenticate_user function."""
    
    def test_successful_authentication(self, db, active_user):
        """Should authenticate user with valid credentials."""
        result = authenticate_user('testuser', 'correct_password')
        
        assert result.id == active_user.id
        assert result.username == 'testuser'
    
    def test_updates_last_login(self, db, active_user):
        """Should update last_login timestamp."""
        old_login = active_user.last_login
        
        authenticate_user('testuser', 'correct_password')
        
        db.session.refresh(active_user)
        assert active_user.last_login > old_login
    
    def test_user_not_found(self, db):
        """Should raise error when user doesn't exist."""
        with pytest.raises(AuthenticationError, match="User not found"):
            authenticate_user('nonexistent', 'password')
    
    def test_invalid_password(self, db, active_user):
        """Should raise error with wrong password."""
        with pytest.raises(AuthenticationError, match="Invalid password"):
            authenticate_user('testuser', 'wrong_password')
    
    def test_inactive_user(self, db, inactive_user):
        """Should raise error for disabled account."""
        with pytest.raises(AuthenticationError, match="Account disabled"):
            authenticate_user('inactive', 'password')
    
    @pytest.mark.parametrize("username,password", [
        ('', 'password'),
        ('username', ''),
        ('', ''),
    ])
    def test_empty_credentials(self, db, username, password):
        """Should handle empty username or password."""
        with pytest.raises(AuthenticationError):
            authenticate_user(username, password)
```

### 4. Run Tests
```bash
# Run the new tests
pytest tests/test_auth.py -v

# Check coverage
pytest tests/test_auth.py --cov=src.auth --cov-report=html

# View coverage report
open htmlcov/index.html
```

### 5. Commit
```bash
git add tests/test_auth.py
git commit -m "test: Add comprehensive tests for authentication module

- Add tests for successful authentication
- Test error conditions (not found, wrong password, disabled)
- Test side effects (last_login update)
- Test edge cases (empty credentials)
- Coverage: 100%"
```

**Result:** Comprehensive test coverage for authentication module with all edge cases covered.

---

## Scenario 4: Refactoring Legacy Code

**Context:** A 300-line function needs refactoring for maintainability.

**References:**
- [Refactoring Specialist](.github/agents/sub-agents/refactoring-specialist.md)
- [Test Writer](.github/agents/sub-agents/test-writer.md)

**Steps:**

### 1. Ensure Tests Exist
```bash
# Check if tests exist
npm test -- src/legacy/processOrder.test.ts

# If no tests, add them first!
# Reference: Test Writer sub-agent
```

### 2. Identify Code Smells
```javascript
// Original: processOrder.js (300 lines!)
function processOrder(order) {
  // Validation (50 lines)
  if (!order.items || order.items.length === 0) throw new Error('No items');
  if (!order.customer) throw new Error('No customer');
  // ... 48 more lines of validation
  
  // Calculate totals (60 lines)
  let subtotal = 0;
  for (let item of order.items) {
    subtotal += item.price * item.quantity;
  }
  // ... 57 more lines of calculations
  
  // Apply discounts (50 lines)
  let discount = 0;
  if (order.customer.type === 'premium') {
    discount = subtotal * 0.1;
  }
  // ... 47 more lines of discount logic
  
  // Process payment (70 lines)
  // ... payment processing code
  
  // Send notifications (70 lines)
  // ... notification code
}
```

### 3. Extract Functions (Small Steps)
```javascript
// Step 1: Extract validation
function validateOrder(order) {
  if (!order.items || order.items.length === 0) {
    throw new Error('No items');
  }
  if (!order.customer) {
    throw new Error('No customer');
  }
  // ... rest of validation
}

// Step 2: Extract calculations
function calculateSubtotal(items) {
  return items.reduce((sum, item) => {
    return sum + (item.price * item.quantity);
  }, 0);
}

function calculateTax(subtotal, taxRate) {
  return subtotal * taxRate;
}

// Step 3: Extract discount logic
function calculateDiscount(subtotal, customer) {
  const discountRates = {
    premium: 0.10,
    gold: 0.05,
    standard: 0
  };
  
  const rate = discountRates[customer.type] || 0;
  return subtotal * rate;
}

// Step 4: Refactored main function (much cleaner!)
function processOrder(order) {
  validateOrder(order);
  
  const subtotal = calculateSubtotal(order.items);
  const discount = calculateDiscount(subtotal, order.customer);
  const tax = calculateTax(subtotal - discount, order.taxRate);
  const total = subtotal - discount + tax;
  
  const payment = processPayment(order.customer, total);
  sendNotifications(order, payment);
  
  return { ...order, subtotal, discount, tax, total, payment };
}
```

### 4. Test After Each Change
```bash
# After each extraction, run tests
npm test -- processOrder.test.ts

# Ensure all tests still pass
npm test
```

### 5. Commit Incrementally
```bash
# Commit after each successful refactoring step
git add src/legacy/processOrder.js
git commit -m "refactor: Extract order validation into separate function"

git add src/legacy/processOrder.js
git commit -m "refactor: Extract calculation functions"

git add src/legacy/processOrder.js
git commit -m "refactor: Simplify discount logic with lookup table"
```

**Result:** 300-line function reduced to ~20 lines with clear, tested helper functions.

---

## Scenario 5: Code Review Process

**Context:** Reviewing a pull request for a new feature.

**References:**
- [Code Review Skill](.github/agents/skills/code-review.md)
- [Git Workflow](.github/agents/skills/git-workflow.md)

**Steps:**

### 1. Check Out PR
```bash
# Fetch and checkout PR branch
git fetch origin pull/123/head:pr-123
git checkout pr-123
```

### 2. Understand Changes
```bash
# See what changed
git diff main..pr-123

# See commit history
git log main..pr-123 --oneline

# Check specific files
git diff main..pr-123 -- src/components/
```

### 3. Run Automated Checks
```bash
# Install dependencies
npm install

# Run linting
npm run lint

# Run tests
npm test

# Check types
npm run type-check

# Run build
npm run build
```

### 4. Review Code (Using Checklist)

From [Code Review Skill](.github/agents/skills/code-review.md):

**Functionality:**
- ✅ Feature works as intended
- ✅ Edge cases handled
- ⚠️ Error handling could be improved

**Code Quality:**
- ✅ Clear variable names
- ❌ Function too long (line 45-120)
- ✅ Good structure

**Testing:**
- ✅ Unit tests added
- ❌ Missing integration test
- ✅ Tests pass

**Security:**
- ⚠️ Input validation needed (line 67)
- ✅ No SQL injection risks
- ✅ Auth checks present

### 5. Provide Feedback
```markdown
## Review Comments

### Critical Issues

**Line 67: Missing input validation**
```javascript
// Current
const result = await api.getData(userInput);

// Suggested
if (!userInput || typeof userInput !== 'string') {
  throw new ValidationError('Invalid input');
}
const sanitized = sanitizeInput(userInput);
const result = await api.getData(sanitized);
```

### Major Issues

**Lines 45-120: Function too long**
Consider extracting:
- Data fetching (lines 45-70)
- Data transformation (lines 71-95)
- Result formatting (lines 96-120)

### Minor Suggestions

- Line 23: Consider using `const` instead of `let`
- Line 89: This could use the existing `formatDate()` utility

### What I Like

✅ Great test coverage for the happy path
✅ Clear commit messages
✅ Good documentation

### Verdict

**Request Changes** - Please address the critical input validation issue and consider refactoring the long function.
```

### 6. Follow Up
```bash
# After changes are made, review again
git pull origin pr-123
npm test
# Check if issues are addressed
```

**Result:** Thorough, constructive code review that improves code quality.

---

## Scenario 6: Setting Up Python API

**Context:** Create a new Python FastAPI project from scratch.

**References:**
- [Project Setup](.github/agents/commands/project-setup.md)
- [Python Expert](.github/agents/python-expert.md)

**Steps:**

### 1. Initialize Project
```bash
# Create project directory
mkdir my-api && cd my-api

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Create project structure
mkdir -p app/api/routes app/core app/models app/schemas tests
touch app/__init__.py app/api/__init__.py app/api/routes/__init__.py
```

### 2. Install Dependencies
```bash
# Install FastAPI and dependencies
pip install fastapi uvicorn[standard] pydantic sqlalchemy

# Install development dependencies
pip install pytest pytest-cov black pylint mypy httpx

# Save dependencies
pip freeze > requirements.txt
```

### 3. Create Basic Application
```python
# app/main.py
from fastapi import FastAPI
from app.api.routes import users

app = FastAPI(
    title="My API",
    description="API built with FastAPI",
    version="1.0.0"
)

app.include_router(users.router, prefix="/api/users", tags=["users"])

@app.get("/")
async def root():
    return {"message": "Welcome to My API"}

@app.get("/health")
async def health():
    return {"status": "healthy"}
```

```python
# app/api/routes/users.py
from fastapi import APIRouter, HTTPException
from app.schemas.user import User, UserCreate
from typing import List

router = APIRouter()

# Temporary in-memory storage
users_db = {}

@router.get("/", response_model=List[User])
async def get_users():
    return list(users_db.values())

@router.post("/", response_model=User)
async def create_user(user: UserCreate):
    user_id = len(users_db) + 1
    new_user = User(id=user_id, **user.dict())
    users_db[user_id] = new_user
    return new_user
```

### 4. Add Tests
```python
# tests/test_main.py
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to My API"}

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}
```

### 5. Configure Code Quality
```bash
# Create pyproject.toml for black
cat > pyproject.toml << 'EOF'
[tool.black]
line-length = 88
target-version = ['py39']

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"
EOF

# Create .pylintrc
pylint --generate-rcfile > .pylintrc
```

### 6. Run Everything
```bash
# Format code
black .

# Lint
pylint app/

# Type check
mypy app/

# Run tests
pytest

# Start server
uvicorn app.main:app --reload
```

**Result:** Fully functional FastAPI project with proper structure, tests, and code quality tools.

---

## Scenario 7: Debugging Intermittent Test Failures

**Context:** Tests fail randomly in CI but pass locally.

**References:**
- [Debugging Skill](.github/agents/skills/debugging.md)
- [Bug Hunter](.github/agents/sub-agents/bug-hunter.md)

**Steps:**

### 1. Gather Information
```bash
# Check CI logs
# Look for patterns in failures

# Run tests multiple times locally
for i in {1..20}; do npm test && echo "Run $i: PASS" || echo "Run $i: FAIL"; done
```

### 2. Identify Pattern
```
Run 1: PASS
Run 2: PASS
Run 3: FAIL - "Expected 3 items, got 2"
Run 4: PASS
Run 5: FAIL - "Expected 3 items, got 2"
```

Hypothesis: Race condition or timing issue.

### 3. Investigate Failing Test
```javascript
// tests/api.test.ts
it('should fetch all items', async () => {
  // Problem: Not waiting for async operations
  createItem({ name: 'Item 1' });  // ❌ Not awaited
  createItem({ name: 'Item 2' });  // ❌ Not awaited
  createItem({ name: 'Item 3' });  // ❌ Not awaited
  
  const items = await getItems();
  expect(items).toHaveLength(3);  // Sometimes fails!
});
```

### 4. Fix the Issue
```javascript
// tests/api.test.ts
it('should fetch all items', async () => {
  // ✅ Wait for all operations
  await Promise.all([
    createItem({ name: 'Item 1' }),
    createItem({ name: 'Item 2' }),
    createItem({ name: 'Item 3' })
  ]);
  
  const items = await getItems();
  expect(items).toHaveLength(3);
});
```

### 5. Verify Fix
```bash
# Run tests many times
for i in {1..50}; do 
  npm test || exit 1
done
echo "All 50 runs passed!"
```

**Result:** Race condition fixed, tests are now reliable.

---

## Scenario 8: Team Onboarding

**Context:** New developer joins the team.

**References:**
- [GETTING_STARTED.md](GETTING_STARTED.md)
- [AGENTS.md](.github/agents/AGENTS.md)
- [INDEX.md](.github/agents/INDEX.md)

**Steps:**

### Week 1: Setup and Basics

**Day 1-2: Environment Setup**
```bash
# Clone team's OpenCode settings
git clone https://github.com/team/opencode-settings.git
cd opencode-settings

# Read main documentation
cat README.md
cat GETTING_STARTED.md
cat .github/agents/AGENTS.md

# Bookmark INDEX.md for reference
```

**Day 3-4: Project Setup**
```bash
# Clone main project
git clone https://github.com/team/main-project.git
cd main-project

# Install dependencies
npm install

# Run tests
npm test

# Start development server
npm run dev
```

**Day 5: First Contribution**
```bash
# Create branch for documentation improvement
git checkout -b docs/update-readme

# Make small change
# Update README with setup notes

# Follow the workflow
npm run lint
npm test
git add .
git commit -m "docs: Add setup troubleshooting notes"
git push origin docs/update-readme

# Create PR
```

### Week 2: Learning Resources

**Study Materials:**
- [Git Workflow](.github/agents/skills/git-workflow.md)
- Language-specific agent (Python/JavaScript)
- [Code Review](.github/agents/skills/code-review.md)
- [Testing](.github/agents/sub-agents/test-writer.md)

**Practice:**
- Review 2-3 PRs
- Fix a "good first issue"
- Pair program with team member

### Week 3: Full Speed

- Take on regular tasks
- Reference agents as needed
- Participate in code reviews
- Share learnings with team

**Result:** New team member is productive and follows team conventions.

---

## 🎯 Key Takeaways

### Common Patterns

1. **Always refer to relevant agents/skills** before starting work
2. **Test frequently** during development
3. **Commit incrementally** with clear messages
4. **Use checklists** from skills documentation
5. **Share knowledge** with team members

### Quick Reference

- Starting new work → [Project Setup](.github/agents/commands/project-setup.md)
- Writing code → Language-specific agent
- Adding tests → [Test Writer](.github/agents/sub-agents/test-writer.md)
- Fixing bugs → [Bug Hunter](.github/agents/sub-agents/bug-hunter.md)
- Refactoring → [Refactoring Specialist](.github/agents/sub-agents/refactoring-specialist.md)
- Before committing → [Code Quality](.github/agents/commands/code-quality-check.md)
- Reviewing code → [Code Review](.github/agents/skills/code-review.md)

---

[← Back to README](README.md) | [Getting Started](GETTING_STARTED.md) | [Index](.github/agents/INDEX.md)
