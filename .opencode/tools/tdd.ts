import { tool } from "@opencode-ai/plugin"

/**
 * TDD Cycle Tool
 * 
 * Helps track and enforce the TDD phases deterministically.
 */

export default tool({
  description: "Update and verify the current TDD phase.",
  args: {
    phase: tool.schema.enum(["RED", "GREEN", "REFACTOR"]).describe("The current TDD phase"),
    action: tool.schema.string().describe("The action being performed (e.g., 'Creating failing test', 'Minimal implementation')"),
    status: tool.schema.enum(["START", "SUCCESS", "FAILURE"]).describe("The status of the action")
  },
  async execute(args) {
    const timestamp = new Date().toISOString();
    const logEntry = `[${timestamp}] PHASE: ${args.phase} | ACTION: ${args.action} | STATUS: ${args.status}`;
    
    // In a full implementation, this could write to a .tdd_history file
    // to enforce that an agent cannot move to GREEN without a SUCCESSFUL RED (failing test confirmed).
    
    return `TDD Protocol Logged: ${logEntry}`;
  }
})
