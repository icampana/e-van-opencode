# OpenCode Shared Configuration

A shared OpenCode configuration repository for team-wide consistency, following OpenCode's best practices. This repository provides centralized agent definitions and configuration files that allow teams to share and sync OpenCode agent configurations across multiple projects.

## 🌟 Overview

OpenCode enables AI-powered development through configurable agents that understand your project's context, architecture, and coding standards. This repository serves as a shared configuration source that ensures all team members and projects follow consistent patterns and best practices.

**Key Benefits:**
- **Team Consistency:** All projects use the same agent definitions and coding standards
- **One-Command Setup:** Sync configuration to your local OpenCode config directory instantly
- **Flexible Deployment:** Choose between copying files or using symlinks for automatic updates
- **Safe Updates:** Automatic backup of existing configurations before syncing
- **Customizable:** Fork and adapt to your team's specific needs

## ⚡ GSD Integration (New!)

This repository is optimized for use with **Get Shit Done (GSD)** (`npx get-shit-done-cc`), a powerful meta-prompting system for planning and executing complex tasks.

- **Unified Workflow:** Use GSD to plan and track tasks, while OpenCode experts execute the code.
- **Context-Aware:** Agents are trained to respect GSD's atomic plans (`PLAN.md`).
- **Safe Syncing:** The updated `sync-config.sh` ensures your GSD installation is preserved.

[👉 **Read the GSD + OpenCode Workflow Guide**](docs/GSD_WORKFLOW.md)

## 📋 Project Structure

```
e-van-opencode/
├── .opencode/
│   ├── agents/             # Agent definition files (Markdown)
│   │   ├── ui-engineer.md
│   │   ├── python-backend-engineer.md
│   │   ├── devops-engineer.md
│   │   ├── principal-engineer.md
│   │   ├── postgresql-expert.md
│   │   ├── security-reviewer.md
│   │   ├── docker-expert.md
│   │   ├── github-actions-expert.md
│   │   ├── nextjs-expert.md
│   │   ├── astro-expert.md
│   │   ├── senior-code-reviewer.md
│   │   ├── python-expert.md
│   │   ├── javascript-expert.md
│   │   ├── refactoring-specialist.md
│   │   ├── test-writer.md
│   │   ├── bug-hunter.md
│   │   └── documentation-expert.md
│   └── commands/           # Custom slash commands
│       └── analyze-context.md
├── docs/
│   └── AGENTS.md           # Main agent rules file
├── opencode.json           # OpenCode configuration
├── sync-config.sh          # Sync script for ~/.config/opencode/
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- **OpenCode:** Ensure OpenCode is installed on your machine
- **Git:** Required for cloning and updating the repository
- **Bash:** The sync script requires a bash-compatible shell

### Recommended Skills

Install these two skills for fast local documentation lookup:

```bash
npx skills add https://github.com/icampana/dsearch
npx skills add https://github.com/firecrawl/cli --skill firecrawl
```

### Installation

#### 1. Clone the Repository

```bash
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode
```

#### 2. Sync to OpenCode Config

Run the sync script to copy configuration files to your OpenCode config directory:

```bash
# Copy configuration to ~/.config/opencode/
./sync-config.sh
```

This syncs the following files:
- `opencode.json` → `~/.config/opencode/opencode.json`
- `docs/AGENTS.md` → `~/.config/opencode/AGENTS.md`
- `.opencode/agents/*.md` → `~/.config/opencode/agents/`

#### 3. Verify Installation

Check that the files were synced successfully:

```bash
ls -la ~/.config/opencode/
ls -la ~/.config/opencode/agents/
```

### Updating Configuration

When updates are available, pull the latest changes and re-sync:

```bash
# Pull latest changes
git pull

# Re-sync configuration
./sync-config.sh
```

### Commands Reference

#### sync-config.sh

The main command for syncing repository configuration to your local OpenCode config directory (`~/.config/opencode/`).

**What it does:** Copies or creates symlinks for configuration files from this repository to your local OpenCode config directory, including:
- `opencode.json` → `~/.config/opencode/opencode.json`
- `docs/AGENTS.md` → `~/.config/opencode/AGENTS.md`
- `.opencode/agents/*.md` → `~/.config/opencode/agents/`

**When to use it:**
- After cloning this repository for the first time
- After pulling latest changes from the remote repository
- After making customizations to agent definitions or configuration files

**Available options:**
| Option | Description |
|--------|-------------|
| `--symlink` | Use symlinks instead of copying. Automatically keeps OpenCode config in sync with the repository (ideal for active development) |
| `--no-backup` | Skip creating a backup of existing configuration. Use with caution |
| `--help` | Display help information and usage examples |

## ⚙️ Configuration Options

The `sync-config.sh` script supports several options to customize the sync behavior.

### Symlink Mode (Recommended for Active Development)

Use symlinks instead of copying files. This keeps your OpenCode configuration automatically in sync with the repository:

```bash
./sync-config.sh --symlink
```

**Benefits:**
- Changes in the repository are immediately reflected
- No need to re-run sync after git pulls
- Ideal for developers actively contributing to the config

**Note:** Symlink mode removes any existing copied configurations and replaces them with symlinks.

### Skip Backup

By default, the script creates a timestamped backup of your existing configuration before syncing. To skip this step:

```bash
./sync-config.sh --no-backup
```

**Warning:** Use with caution. This will overwrite your existing configuration without creating a backup.

### Combined Options

You can combine multiple options:

```bash
# Use symlinks without creating a backup
./sync-config.sh --symlink --no-backup
```

### Help

Display help information:

```bash
./sync-config.sh --help
```

## 🤖 Available Agents

This repository includes 18 specialized agents, each designed for specific development tasks. Agents are categorized as **primary** (main decision-makers) or **subagent** (specialized assistants).

| Agent | Mode | Description | Use Case |
|-------|------|-------------|----------|
| `principal-engineer` | primary | Complex engineering, deep refactoring, system architecture, and strict TDD | High-level architecture decisions, cross-domain coordination |
| `ui-engineer` | primary | Frontend, UI/UX, CSS architecture, and Accessibility (A11y) | Building user interfaces, styling, ensuring accessibility |
| `python-backend-engineer` | primary | Python backend development, FastAPI/Django, modern tooling, and type safety | Python APIs, services, backend architecture |
| `devops-engineer` | primary | CI/CD, infrastructure automation (Terraform/Ansible), and cloud operations | Infrastructure as code, deployment pipelines |
| `nextjs-expert` | primary | Next.js, React, Server Components, and App Router architecture | Next.js applications, React Server Components |
| `astro-expert` | primary | Astro, component architecture, content collections, and static site optimization | Static sites, content-focused web applications |
| `postgresql-expert` | subagent | PostgreSQL, SQL optimization, schema design, and database performance | Database design, query optimization, migrations |
| `security-reviewer` | subagent | OWASP-focused security audit. Identifies, rates, and provides fixes for vulnerabilities | Security reviews, vulnerability scanning |
| `docker-expert` | subagent | Docker containerization, Dockerfiles, Compose, and orchestration | Containerizing applications, Docker configuration |
| `github-actions-expert` | subagent | GitHub Actions, CI/CD workflows, automation, and YAML syntax | GitHub Actions workflow configuration |
| `senior-code-reviewer` | subagent | Code review and gatekeeping. Ensures code quality, security, and best practices | Pull request reviews, quality assurance |
| `python-expert` | subagent | Python development following PEP 8 and modern best practices | Python code, linting, type hints, modern patterns |
| `javascript-expert` | subagent | JavaScript/TypeScript with modern web development and Node.js | JavaScript/TypeScript code, async patterns, React |
| `refactoring-specialist` | subagent | Improves code quality through careful refactoring while preserving functionality | Code cleanup, removing duplication, simplifying logic |
| `test-writer` | subagent | Writes comprehensive, maintainable tests following TDD best practices | Writing tests, test coverage, test architecture |
| `bug-hunter` | subagent | Systematically identifies and fixes bugs through root cause analysis | Debugging, investigating issues, bug fixes |
| `documentation-expert` | subagent | Creates clear, comprehensive technical documentation following best practices | Writing docs, API documentation, README files |

## 🎯 Custom Commands

In addition to agents, this repository provides custom slash commands for specialized tasks.

| Command | Description | Use Case |
|---------|-------------|----------|
| `@analyze-context` | Deep system analysis to generate `docs/AI_CONTEXT.md` | Understanding a new codebase, when context documentation is missing or outdated, before complex features |

### @analyze-context

Performs a comprehensive system architecture analysis and generates a detailed architectural map in `docs/AI_CONTEXT.md`.

**What it does:**
- Executes a 3-phase analysis protocol:
  - **Phase 1: Structural X-Ray** – Identifies modules, entry points, and config resolution
  - **Phase 2: Data Flow & Logic Mapping** – Analyzes data models, API surface, and key invariants
  - **Phase 3: Technical Debt & Risk Assessment** – Detects god objects, hidden dependencies, and test gaps
- Generates or overwrites `docs/AI_CONTEXT.md` with:
  - Tech stack & versions
  - High-level architecture pattern
  - Critical data flows
  - Key directory map
  - Developer guide / conventions
  - Known technical debt / watchlist

**When to use it:**
- When you need to understand a new codebase
- When `docs/AI_CONTEXT.md` is missing or outdated
- Before starting work on a complex feature
- When the `@refresh-context` command is invoked (this triggers `@analyze-context`)

## 📖 How It Works

OpenCode loads configuration in a priority order, allowing for flexibility at different scopes:

1. **Local Rules:** `AGENTS.md` in the current project directory (not used in this repo)
2. **Global Rules:** `~/.config/opencode/AGENTS.md`
3. **Agent Definitions:** `~/.config/opencode/agents/*.md`

This repository provides content for steps 2 and 3 through the `sync-config.sh` script. When OpenCode processes a file or request, it:

1. Reads the global `AGENTS.md` to understand the default behavior and workflow
2. Loads individual agent definitions from the `agents/` directory
3. Matches the request to the most appropriate agent based on the task type
4. Applies the agent's instructions and context to generate assistance

### Agent Mode

- **Primary agents:** Serve as the main decision-maker for broad domains. They can delegate to subagents when specialized expertise is needed.
- **Subagent agents:** Provide specialized assistance in specific areas and are typically invoked by primary agents or directly for focused tasks.

### Temperature

All agents use a low temperature setting (0.1), ensuring consistent, deterministic responses that follow established patterns and best practices.

## 🛠️ Customization

This repository is designed to be forked and customized for your team's specific needs.

### Forking for Your Team

1. **Fork the Repository:**
   ```bash
   # Fork this repo on GitHub, then clone your fork
   git clone https://github.com/your-username/e-van-opencode.git
   cd e-van-opencode
   ```

2. **Modify Agent Definitions:**
   - Edit `.opencode/agents/*.md` to align with your team's standards
   - Add new agents specific to your technology stack
   - Remove agents you don't use

3. **Update Global Rules:**
   - Modify `docs/AGENTS.md` with your team's workflow preferences
   - Adjust the CLI tools and execution protocols
   - Customize agent delegation rules

4. **Share with Your Team:**
   ```bash
   git add .
   git commit -m "feat: customize agents for team standards"
   git push origin main
   ```

   Team members can then clone your fork and sync the configuration.

### Best Practices for Customization

- **Start Small:** Make incremental changes and test them with your team
- **Document Changes:** Add comments or a `TEAM_CUSTOMIZATIONS.md` file explaining your modifications
- **Version Control:** Commit changes with clear messages describing what was customized and why
- **Backward Compatibility:** Consider maintaining compatibility with upstream changes if you plan to merge updates

## 🔍 Troubleshooting

### Common Issues

#### Issue: Permission Denied on sync-config.sh

The script doesn't have execute permissions:

```bash
chmod +x sync-config.sh
./sync-config.sh
```

#### Issue: Configuration Not Recognized by OpenCode

After syncing, OpenCode doesn't seem to use the new configuration:

1. Verify the files are in the correct location:
   ```bash
   ls -la ~/.config/opencode/
   ls -la ~/.config/opencode/agents/
   ```

2. Check that `opencode.json` has the correct structure:
   ```bash
   cat ~/.config/opencode/opencode.json
   ```

3. Restart OpenCode to ensure it reloads the configuration

#### Issue: Symlink Mode Fails

Symlink creation fails with an error:

1. Ensure the target directory exists and is empty:
   ```bash
   mkdir -p ~/.config/opencode
   rm -rf ~/.config/opencode/agents
   ```

2. Try using absolute paths by checking the script's output

#### Issue: Backup Directory Already Exists

The script fails because a backup directory with the same name exists:

```bash
# Remove or rename the old backup
rm -rf ~/.config.opencode.backup.*

# Or skip backup
./sync-config.sh --no-backup
```

#### Issue: Agents Not Listed or Not Working

Specific agents are missing or not functioning:

1. Verify the agent file exists:
   ```bash
   ls -la ~/.config/opencode/agents/agent-name.md
   ```

2. Check the agent file has the required frontmatter (description, mode, temperature, tools, permission)

3. Ensure the agent file is valid YAML at the top followed by markdown content

### Getting Help

If you encounter issues not covered here:

1. Check the [OpenCode Documentation](https://opencode.ai/docs/) for configuration details
2. Review the sync-config.sh script for detailed error messages
3. Open an issue on this repository's GitHub page

## 📚 Usage Examples

### Example 1: Initial Team Setup

Set up OpenCode configuration for a new team:

```bash
# Clone the repository
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode

# Customize for your team
# Edit .opencode/agents/ and docs/AGENTS.md as needed

# Sync to local config
./sync-config.sh

# Verify agents are available
ls ~/.config/opencode/agents/

# Start using OpenCode with your team's configuration
```

### Example 2: Active Development Workflow

Use symlink mode for development on the configuration itself:

```bash
# Clone the repository
git clone https://github.com/icampana/e-van-opencode.git
cd e-van-opencode

# Use symlinks for automatic sync
./sync-config.sh --symlink

# Now make changes to agent files
vim .opencode/agents/new-agent.md

# Changes are immediately available in ~/.config/opencode/
# No need to re-run sync script
```

### Example 3: Team Distribution

Share a customized configuration with your team:

```bash
# As team lead
git clone https://github.com/your-team/opencode-config.git
cd opencode-config

# Customize the configuration
# Edit agents and AGENTS.md

# Commit and push
git add .
git commit -m "feat: add company-specific coding standards"
git push origin main

# Team members then:
git clone https://github.com/your-team/opencode-config.git
cd opencode-config
./sync-config.sh
```

## 🔄 Version Compatibility

### OpenCode Version Compatibility

This repository is designed to work with current versions of OpenCode. The configuration format follows the schema defined at `https://opencode.ai/config.json`.

### Compatibility Notes

- **Agent Frontmatter:** Requires agents to have YAML frontmatter with `description`, `mode`, `temperature`, `tools`, and `permission` fields
- **Markdown Format:** Agent definitions use standard markdown with specific section headers
- **JSON Schema:** The `opencode.json` file follows the official OpenCode configuration schema

When upgrading OpenCode, ensure your agent definitions are compatible with the new version. Check the [OpenCode Release Notes](https://opencode.ai/docs/releases/) for breaking changes.

## 📖 Contributing

Contributions are welcome! If you'd like to improve this repository:

### Reporting Issues

Report bugs or suggest improvements by opening an issue on GitHub. Include:

- Clear description of the problem or suggestion
- Steps to reproduce the issue
- Expected behavior
- Environment details (OS, OpenCode version, etc.)

### Submitting Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Commit with a clear message: `git commit -m "feat: add new agent"`
5. Push to your fork: `git push origin feature/my-feature`
6. Open a pull request

### Contribution Guidelines

- **Agent Quality:** New agents should follow the existing pattern and include comprehensive instructions
- **Documentation:** Update the README if you add features or change behavior
- **Testing:** Test changes in your own OpenCode environment before submitting
- **Style:** Follow the markdown and formatting conventions used in existing files

## 🏆 Best Practices

### For Individual Developers

- **Regular Updates:** Run `git pull && ./sync-config.sh` regularly to get the latest agent improvements
- **Read Agent Docs:** Take time to understand what each agent specializes in
- **Use Appropriate Agents:** Let OpenCode select the right agent, or invoke specific agents when you know their expertise is needed

### For Teams

- **Centralized Management:** Maintain a single fork for your team and have everyone clone from it
- **Review Changes:** Review agent updates together before syncing to ensure they align with your standards
- **Document Customizations:** Keep track of why you made specific customizations in comments or a separate file
- **Version Control:** Tag releases of your team's configuration for stability

### For Configuration Maintainers

- **Clear Descriptions:** Ensure agent descriptions accurately reflect their capabilities
- **Consistent Style:** Maintain consistent formatting and structure across all agents
- **Minimal Changes:** Make small, focused changes to reduce risk
- **Test Thoroughly:** Test configuration changes before deploying to the team

## 📚 References

- [OpenCode Official Documentation](https://opencode.ai/docs/)
- [OpenCode Agent Configuration](https://opencode.ai/docs/agents/)
- [OpenCode Rules System](https://opencode.ai/docs/rules/)
- [Configuration JSON Schema](https://opencode.ai/config.json)

## 📄 License

This repository is shared as a template and configuration resource. Please refer to the LICENSE file in the repository for specific licensing terms.

## 🤝 Support

For support with this repository:
- Open an issue on GitHub
- Check existing issues and discussions
- Review the troubleshooting section above

For support with OpenCode itself:
- Visit the [OpenCode Documentation](https://opencode.ai/docs/)
- Contact OpenCode support through their official channels
