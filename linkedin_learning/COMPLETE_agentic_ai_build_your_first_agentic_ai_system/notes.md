# Agentic AI: Build Your First Agentic AI System
Identify agentic AI opportunities:
- Repetitive and high-volume
- Multistep with clear logic
- Requires tool/system access
- Has measurable outcomes
- Tolerates some errors
- Currently slow or costly

Customer support, sales & marketing, finance & operations, HR & recruiting, research & analysis.

Action, planning & end-to-end autonomies. Example in customer support: action autonomy - route to the right human agent (low rsik - agent triages and directs); planning autonomy - plan resolution for human approval (medium risk - agent researches and recommends); end-to-end autonomy - handle the entire interaction (higher risk - agent resolves independently).
Match the autonomy level to the risk and complexity of the customer nteraction.

## Agentic AI lifecycle
Components: AI model (brain), Tools (the hands), External knowledge/memory, Planning (the strategy).

Continuous Calibration / Continuous Development (CC/CD) - a framework designed to 1) reduce non-determinism through design and monitoring and 2) to ensure agency is earned over time, not granted all at once. CD includes 1) scope capability and curate data, 2) set up application and 3) design evals. CC (hapend after deployment) includes 1) run evals, 2) analyze behavior and spot error patterns and 3) apply fixes.

CD - the iterative development phase. Start with high control. low agency and earn autonomy through iteration. Don't overengineer - buil donly what's needed for the current version, make the system measurable and iterable and log what the system sees and returns and how users interact. You design for control handoffs, humans mast be able to step in seamlessly when needed. Design evals - scoring mechanisms to assess if your AI is working. 

Deploymet is not the finish line, it's the transition to calibration.

CC - the iterative calibration phase. Observe real-world behavior, identify where the system breaks and make targeted improvemnets. Use smart sampling signals. 

## Building the baseline agentic system
## Enhancing your AI agent with Tools and Memory
## Production considerations and planning

Cost: token usage, compute, API calls, infrastructure
Complexity: number of components, agents, reasoning steps
Reliability: predictability, explainability, consistency

Guardrails prevent harmful or unintended actions. Input, output and action guardrails.
Governance - policies, processes, and accountability structures for AI behavior. Access control. audit trails, escalation paths, review cadence.
Security - e.g. prompt injection, data leakage, tool misuse

Principle of least privilege - give AI systems only the minimum access they need for the current task.

Four phases of the roadmap:
1) Discovery ans scoping
2) Foundation and MVP
3) Iteration and scaling
4) Production and optimization
