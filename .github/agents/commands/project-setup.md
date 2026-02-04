# Project Setup Command

Quick setup for new projects in various languages and frameworks.

## Purpose

Bootstrap new projects with best practices and common configurations.

## JavaScript/TypeScript Projects

### Node.js with npm
```bash
# Initialize project
npm init -y

# Add TypeScript
npm install --save-dev typescript @types/node
npx tsc --init

# Add testing
npm install --save-dev jest @types/jest ts-jest
npx ts-jest config:init

# Add linting
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npx eslint --init

# Add formatting
npm install --save-dev prettier
echo '{"semi": true, "singleQuote": true, "trailingComma": "es5"}' > .prettierrc
```

### React App
```bash
# Create React app with TypeScript
npx create-react-app my-app --template typescript
cd my-app

# Or with Vite (faster)
npm create vite@latest my-app -- --template react-ts
cd my-app
npm install
```

### Next.js App
```bash
# Create Next.js app with TypeScript
npx create-next-app@latest my-app --typescript --eslint
cd my-app
```

### Express API
```bash
# Initialize
mkdir my-api && cd my-api
npm init -y

# Install dependencies
npm install express
npm install --save-dev @types/express typescript ts-node nodemon

# Create tsconfig
npx tsc --init

# Create basic structure
mkdir src
cat > src/index.ts << 'EOF'
import express from 'express';

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Hello World!' });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
EOF

# Add scripts to package.json
npm pkg set scripts.dev="nodemon --exec ts-node src/index.ts"
npm pkg set scripts.build="tsc"
npm pkg set scripts.start="node dist/index.js"
```

## Python Projects

### Basic Python Project
```bash
# Create project structure
mkdir my-project && cd my-project
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Create basic files
touch README.md
touch requirements.txt
mkdir src tests

# Initialize git
git init
echo "venv/" > .gitignore
echo "__pycache__/" >> .gitignore
echo "*.pyc" >> .gitignore
echo ".pytest_cache/" >> .gitignore

# Install dev dependencies
pip install pytest black pylint mypy
pip freeze > requirements-dev.txt
```

### Flask API
```bash
# Create project
mkdir flask-api && cd flask-api
python -m venv venv
source venv/bin/activate

# Install Flask
pip install flask flask-cors

# Create app structure
mkdir app
cat > app/__init__.py << 'EOF'
from flask import Flask

def create_app():
    app = Flask(__name__)
    
    @app.route('/')
    def hello():
        return {'message': 'Hello World!'}
    
    return app
EOF

cat > run.py << 'EOF'
from app import create_app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True)
EOF

pip freeze > requirements.txt
```

### FastAPI Project
```bash
# Create project
mkdir fastapi-app && cd fastapi-app
python -m venv venv
source venv/bin/activate

# Install FastAPI
pip install fastapi uvicorn[standard]

# Create main.py
cat > main.py << 'EOF'
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
EOF

# Run with: uvicorn main:app --reload
pip freeze > requirements.txt
```

## Go Projects

### Go Module
```bash
# Initialize module
mkdir my-app && cd my-app
go mod init github.com/username/my-app

# Create main.go
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
EOF

# Create basic structure
mkdir -p cmd/myapp
mkdir pkg
mkdir internal
mkdir test

# Run
go run main.go
```

### Go Web API
```bash
# Initialize
mkdir go-api && cd go-api
go mod init github.com/username/go-api

# Install dependencies
go get github.com/gorilla/mux

# Create main.go
cat > main.go << 'EOF'
package main

import (
    "encoding/json"
    "net/http"
    "github.com/gorilla/mux"
)

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/", HomeHandler).Methods("GET")
    http.ListenAndServe(":8080", r)
}

func HomeHandler(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(map[string]string{"message": "Hello World"})
}
EOF
```

## Java Projects

### Maven Project
```bash
# Create Maven project
mvn archetype:generate \
    -DgroupId=com.example \
    -DartifactId=my-app \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false

cd my-app
```

### Spring Boot
```bash
# Use Spring Initializr
curl https://start.spring.io/starter.tgz \
    -d dependencies=web,data-jpa,h2 \
    -d type=maven-project \
    -d language=java \
    -d bootVersion=3.0.0 \
    -d groupId=com.example \
    -d artifactId=demo \
    | tar -xzf -

cd demo
```

## .NET Projects

### Console App
```bash
# Create console app
dotnet new console -n MyApp
cd MyApp
dotnet run
```

### Web API
```bash
# Create Web API
dotnet new webapi -n MyApi
cd MyApi
dotnet run
```

### Full Solution
```bash
# Create solution
mkdir MySolution
cd MySolution
dotnet new sln

# Add projects
dotnet new webapi -n MyApi
dotnet new classlib -n MyLib
dotnet new xunit -n MyApi.Tests

# Add to solution
dotnet sln add MyApi/MyApi.csproj
dotnet sln add MyLib/MyLib.csproj
dotnet sln add MyApi.Tests/MyApi.Tests.csproj

# Add project references
dotnet add MyApi/MyApi.csproj reference MyLib/MyLib.csproj
dotnet add MyApi.Tests/MyApi.Tests.csproj reference MyApi/MyApi.csproj
```

## Common Configuration Files

### .gitignore (General)
```bash
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
venv/
vendor/

# Build outputs
dist/
build/
*.exe
*.dll
*.so
*.dylib

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Env files
.env
.env.local

# Logs
*.log
npm-debug.log*

# Test coverage
coverage/
.coverage
htmlcov/
EOF
```

### .editorconfig
```bash
cat > .editorconfig << 'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.{py,java,go}]
indent_size = 4

[*.md]
trim_trailing_whitespace = false
EOF
```

### README.md Template
```bash
cat > README.md << 'EOF'
# Project Name

Brief description of the project

## Features

- Feature 1
- Feature 2

## Installation

```bash
# Installation steps
```

## Usage

```bash
# Usage examples
```

## Development

```bash
# Setup for development
```

## Testing

```bash
# Run tests
```

## License

MIT
EOF
```

## Docker Setup

### Dockerfile (Node.js)
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### Dockerfile (Python)
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "main.py"]
```

### docker-compose.yml
```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    volumes:
      - .:/app
      - /app/node_modules
```

## Usage

1. Choose your project type
2. Run the appropriate commands
3. Customize as needed
4. Start developing!

## Tips

- Use project generators when available
- Set up linting and formatting early
- Initialize git from the start
- Create comprehensive .gitignore
- Add README with basic info
- Set up CI/CD early
