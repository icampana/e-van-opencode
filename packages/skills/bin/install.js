#!/usr/bin/env node

/**
 * @e-van/skills — CLI installer
 *
 * Copies skill directories into the target project's skills folder.
 * Supports OpenCode, Claude Code, and the cross-agent .agents/ standard.
 * Skills become project-owned and customizable after install.
 *
 * Usage:
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --client claude
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --client agents
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --force
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --list
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --path ./my-project
 *   npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git --core-only
 *
 * Flags:
 *   --client <c>  Target client: opencode, claude, or agents (default: auto-detect)
 *   --force       Overwrite existing skill directories
 *   --list        List available skills without installing
 *   --path <dir>  Target project root (default: current working directory)
 *   --core-only   Skip the optional project-onboarding skill
 */

import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// --- Constants ---

const SKILLS_SOURCE = path.resolve(__dirname, '..', 'skills');

const CORE_SKILLS = [
  'building-domain-context',
  'architecture-scan',
  'running-the-gauntlet',
];

const OPTIONAL_SKILLS = [
  'project-onboarding',
];

const ALL_SKILLS = [...CORE_SKILLS, ...OPTIONAL_SKILLS];

// Client → skills directory path (relative to project root)
const CLIENT_PATHS = {
  opencode: path.join('.opencode', 'skills'),
  claude:   path.join('.claude', 'skills'),
  agents:   path.join('.agents', 'skills'),
};

const CLIENT_LABELS = {
  opencode: 'OpenCode',
  claude:   'Claude Code',
  agents:   'Cross-agent (.agents/)',
};

// --- Helpers ---

const COLORS = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  cyan: '\x1b[36m',
  gray: '\x1b[90m',
  bold: '\x1b[1m',
};

const colorize = (color, msg) => `${COLORS[color]}${msg}${COLORS.reset}`;

function printHelp() {
  console.log(`
${colorize('bold', '@e-van/skills')} — Install workflow skills for OpenCode, Claude Code & Superpowers

${colorize('cyan', 'Usage:')}
  npx @e-van/skills@git+https://github.com/icampana/e-van-opencode.git [options]

${colorize('cyan', 'Options:')}
  --client <c>  Target client: opencode, claude, or agents (default: auto-detect)
  --force       Overwrite existing skill directories
  --list        List available skills without installing
  --path <dir>  Target project root (default: cwd)
  --core-only   Skip the optional project-onboarding skill
  -h, --help    Show this help message

${colorize('cyan', 'Client paths:')}
  opencode  → .opencode/skills/
  claude    → .claude/skills/
  agents    → .agents/skills/  (cross-agent standard, works with Claude Code, Cursor, etc.)
`);
}

function detectClient(targetRoot) {
  // Check which client config directories exist in the target project
  if (fs.existsSync(path.join(targetRoot, '.opencode'))) return 'opencode';
  if (fs.existsSync(path.join(targetRoot, '.claude'))) return 'claude';
  if (fs.existsSync(path.join(targetRoot, '.agents'))) return 'agents';
  // Default to opencode (the package's native client)
  return 'opencode';
}

function parseArgs(argv) {
  const args = { force: false, list: false, coreOnly: false, path: null, client: null };
  for (let i = 2; i < argv.length; i++) {
    const arg = argv[i];
    switch (arg) {
      case '--force':
        args.force = true;
        break;
      case '--list':
        args.list = true;
        break;
      case '--core-only':
        args.coreOnly = true;
        break;
      case '--path':
        args.path = argv[++i];
        break;
      case '--client':
        args.client = argv[++i];
        break;
      case '-h':
      case '--help':
        printHelp();
        process.exit(0);
        break;
      default:
        console.error(colorize('red', `Unknown option: ${arg}`));
        process.exit(1);
    }
  }
  // Validate client if specified
  if (args.client && !CLIENT_PATHS[args.client]) {
    console.error(colorize('red', `Unknown client: ${args.client}`));
    console.error(colorize('gray', `Valid clients: ${Object.keys(CLIENT_PATHS).join(', ')}`));
    process.exit(1);
  }
  return args;
}

function copyDir(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  const entries = fs.readdirSync(src, { withFileTypes: true });
  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      copyDir(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// --- Main ---

const args = parseArgs(process.argv);

// List mode
if (args.list) {
  console.log(colorize('bold', '\n@e-van/skills — Available Skills\n'));
  console.log(colorize('cyan', 'Core Skills:'));
  for (const skill of CORE_SKILLS) {
    const skillPath = path.join(SKILLS_SOURCE, skill, 'SKILL.md');
    const content = fs.readFileSync(skillPath, 'utf8');
    const descMatch = content.match(/^description:\s*(.+)$/m);
    const desc = descMatch ? descMatch[1].trim() : '';
    console.log(`  ${colorize('green', skill)}  ${colorize('gray', desc)}`);
  }
  console.log(colorize('cyan', '\nOptional Skills:'));
  for (const skill of OPTIONAL_SKILLS) {
    const skillPath = path.join(SKILLS_SOURCE, skill, 'SKILL.md');
    const content = fs.readFileSync(skillPath, 'utf8');
    const descMatch = content.match(/^description:\s*(.+)$/m);
    const desc = descMatch ? descMatch[1].trim() : '';
    console.log(`  ${colorize('yellow', skill)}  ${colorize('gray', desc)}`);
  }
  console.log();
  process.exit(0);
}

// Determine target
const targetRoot = args.path ? path.resolve(args.path) : process.cwd();

// Determine client (explicit flag or auto-detect)
const client = args.client || detectClient(targetRoot);
const targetSkillsDir = path.join(targetRoot, CLIENT_PATHS[client]);

// Determine which skills to install
const skillsToInstall = args.coreOnly ? CORE_SKILLS : ALL_SKILLS;

console.log(colorize('bold', '\n@e-van/skills — Installer\n'));
console.log(`${colorize('blue', 'Source:')}  ${SKILLS_SOURCE}`);
console.log(`${colorize('blue', 'Target:')}  ${targetSkillsDir}`);
console.log(`${colorize('blue', 'Client:')}  ${CLIENT_LABELS[client]}${args.client ? '' : colorize('gray', ' (auto-detected)')}`);
console.log(`${colorize('blue', 'Mode:')}    ${args.force ? colorize('yellow', 'force (overwrite)') : 'preserve existing'}`);
console.log(`${colorize('blue', 'Skills:')}  ${skillsToInstall.join(', ')}\n`);

// Ensure target directory exists
fs.mkdirSync(targetSkillsDir, { recursive: true });

let installed = 0;
let skipped = 0;
let errors = 0;

for (const skill of skillsToInstall) {
  const src = path.join(SKILLS_SOURCE, skill);
  const dest = path.join(targetSkillsDir, skill);

  if (!fs.existsSync(src)) {
    console.log(`  ${colorize('red', 'ERROR')}   ${skill} — source not found`);
    errors++;
    continue;
  }

  if (fs.existsSync(dest) && !args.force) {
    console.log(`  ${colorize('yellow', 'SKIP')}    ${skill} — already exists (use --force to overwrite)`);
    skipped++;
    continue;
  }

  try {
    if (fs.existsSync(dest)) {
      fs.rmSync(dest, { recursive: true });
    }
    copyDir(src, dest);
    console.log(`  ${colorize('green', 'INSTALL')} ${skill}`);
    installed++;
  } catch (err) {
    console.log(`  ${colorize('red', 'ERROR')}   ${skill} — ${err.message}`);
    errors++;
  }
}

console.log();
console.log(colorize('bold', 'Summary:'));
console.log(`  ${colorize('green', 'Installed:')} ${installed}`);
console.log(`  ${colorize('yellow', 'Skipped:')}  ${skipped}`);
if (errors > 0) {
  console.log(`  ${colorize('red', 'Errors:')}    ${errors}`);
}

console.log();
if (installed > 0) {
  console.log(colorize('green', 'Skills installed successfully.'));
  const restartMsg = {
    opencode: 'Restart your opencode session to load the new skills.',
    claude:   'Restart Claude Code to load the new skills.',
    agents:   'Skills installed to .agents/skills/ — compatible with Claude Code, Cursor, and other agents.',
  };
  console.log(colorize('gray', restartMsg[client]));
  console.log();
  console.log(colorize('cyan', 'Prerequisites:'));
  console.log(colorize('gray', '  Required: superpowers plugin (https://github.com/obra/superpowers)'));
  console.log(colorize('gray', '  Recommended: CodeGraph, Engram, context-mode, mise'));
  console.log(colorize('gray', '  See packages/skills/docs/tools-reference.md for install commands'));
}

process.exit(errors > 0 ? 1 : 0);