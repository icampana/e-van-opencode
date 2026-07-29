/**
 * @e-van/skills — OpenCode plugin
 *
 * Auto-registers the skills directory via opencode's config hook.
 * Consumers add "@e-van/skills@git+https://..." to their opencode.json
 * plugin array and the skills are discovered with zero file copies.
 *
 * Pattern mirrors the superpowers plugin (obra/superpowers).
 */

import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const skillsDir = path.resolve(__dirname, 'skills');

export const EvanSkillsPlugin = async ({ client, directory }) => {
  return {
    // Inject skills path into live config so OpenCode discovers the skills
    // without requiring manual symlinks or config file edits.
    config: async (config) => {
      config.skills = config.skills || {};
      config.skills.paths = config.skills.paths || [];
      if (!config.skills.paths.includes(skillsDir)) {
        config.skills.paths.push(skillsDir);
      }
    },
  };
};

export default EvanSkillsPlugin;