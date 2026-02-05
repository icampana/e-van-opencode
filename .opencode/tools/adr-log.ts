import { tool } from "@opencode-ai/plugin"
import path from "path"
import fs from "fs/promises"

/**
 * ADR Log Tool
 * 
 * Automatically updates the ADR index file (docs/adr/README.md).
 */

export default tool({
  description: "Update the ADR index file with a new decision record.",
  args: {
    id: tool.schema.string().describe("The ADR ID (e.g., '0001')"),
    title: tool.schema.string().describe("The title of the ADR"),
    status: tool.schema.string().describe("The status of the ADR (e.g., 'Proposed', 'Accepted')"),
    fileName: tool.schema.string().describe("The filename of the ADR (e.g., '0001-use-fastapi.md')")
  },
  async execute(args, context) {
    const adrDirPath = path.join(context.worktree, "docs/adr");
    const indexPath = path.join(adrDirPath, "README.md");
    const entry = `| ${args.id} | [${args.title}](./${args.fileName}) | ${args.status} | ${new Date().toISOString().split('T')[0]} |`;

    try {
      let content = "";
      try {
        content = await fs.readFile(indexPath, "utf-8");
      } catch (e) {
        // Create initial index if it doesn't exist
        content = "# Architecture Decision Records\n\n| ID | Title | Status | Date |\n|---|---|---|---|\n";
      }

      if (!content.includes(entry)) {
        const lines = content.split("\n");
        lines.push(entry);
        await fs.writeFile(indexPath, lines.join("\n"), "utf-8");
        return `Updated ADR index at ${indexPath}`;
      }
      return "ADR entry already exists in index.";
    } catch (error) {
      return `Failed to update ADR index: ${error.message}`;
    }
  }
})