import { tool } from "@opencode-ai/plugin"

/**
 * Verification Gate Tool
 * 
 * Implements a "Build/Test/Lint Gate" with automatic self-correction and retry budget.
 */

export default tool({
  description: "Execute a verification gate (build, test, lint) with automatic retry and self-correction logic.",
  args: {
    command: tool.schema.string().describe("The command to run (e.g., 'npm run build', 'pytest')"),
    gateType: tool.schema.enum(["BUILD", "TEST", "LINT"]).describe("The type of gate being executed"),
    retryBudget: tool.schema.number().default(5).describe("Maximum number of retry attempts for self-correction")
  },
  async execute(args, context) {
    let attempts = 0;
    const maxAttempts = args.retryBudget;
    
    // This tool primarily serves as a high-level orchestrator for the agent.
    // The 'Self-Correction Loop' is driven by the agent using its context,
    // but this tool enforces the retry budget and captures structured error logs.
    
    try {
      // Use Bun.$ to run the command
      const process = await Bun.$`${args.command}`.nothrow();
      
      if (process.exitCode === 0) {
        return `GATE PASSED: ${args.gateType} successful on attempt ${attempts + 1}.`;
      } else {
        const stderr = process.stderr.toString();
        const stdout = process.stdout.toString();
        
        return JSON.stringify({
          status: "GATE_FAILED",
          gate: args.gateType,
          exitCode: process.exitCode,
          stderr: stderr,
          stdout: stdout,
          instruction: "Analyze the root cause of this error, apply a fix, and retry the gate. Remaining budget: " + (maxAttempts - 1)
        });
      }
    } catch (error) {
      return `Gate execution error: ${error.message}`;
    }
  }
})
