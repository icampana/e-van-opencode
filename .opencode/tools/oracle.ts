import { tool } from "@opencode-ai/plugin"
import path from "path"
import fs from "fs/promises"

/**
 * Regression Oracle Tool
 * 
 * Provides deterministic capture and verification of function behavior.
 */

export const capture = tool({
  description: "Capture the output of a function for a given set of inputs and save it as a snapshot.",
  args: {
    functionName: tool.schema.string().describe("Name of the function to capture"),
    testFilePath: tool.schema.string().describe("Path to the test file that executes the function"),
    snapshotName: tool.schema.string().default("oracle_snapshot.json").describe("Name of the snapshot file to create"),
    runCommand: tool.schema.string().describe("The command to run the tests and generate the snapshot (e.g., 'npm test', 'pytest')")
  },
  async execute(args, context) {
    const snapshotPath = path.join(context.directory, args.snapshotName);
    
    // In a real implementation, this tool might instrument the code or 
    // rely on a specific test runner wrapper to capture outputs.
    // For now, we simulate the 'Lock' phase by ensuring the command runs.
    
    try {
      // Execute the capture command
      // We assume the runCommand is configured to write to the snapshotPath
      const result = await Bun.$`${args.runCommand}`.text();
      
      // Verify snapshot was created
      await fs.access(snapshotPath);
      
      return `Snapshot captured successfully for ${args.functionName} and saved to ${args.snapshotName}.

Output:
${result}`;
    } catch (error) {
      return `Failed to capture snapshot: ${error.message}`;
    }
  }
})

export const verify = tool({
  description: "Verify the current implementation against a previously saved snapshot.",
  args: {
    snapshotName: tool.schema.string().default("oracle_snapshot.json").describe("Name of the snapshot file to verify against"),
    runCommand: tool.schema.string().describe("The command to run the tests and compare against the snapshot")
  },
  async execute(args, context) {
    const snapshotPath = path.join(context.directory, args.snapshotName);
    
    try {
      await fs.access(snapshotPath);
      const result = await Bun.$`${args.runCommand}`.text();
      return `Verification completed.

Output:
${result}`;
    } catch (error) {
      return `Verification failed or snapshot missing: ${error.message}`;
    }
  }
})
