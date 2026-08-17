### Agentic AI Learning Path

## 1. How to Build an AI Agent
Agentic AI is a system that uses sophisticated reasoning and iterative planning to autonomously solve complex, multi-step problems.
Traditional apps built with generative AI models follow a basic “request-and-respond” pattern. Autonomous agents instead are goal-directed systems that coordinate one or more multimodal AI models with external tools to plan and execute multi-step tasks. In practice, agents may combine large language models (LLMs) with retrieval augmented generation (RAG) over vector databases, call APIs and internal services, and run logic in general purpose languages like Python or within agent frameworks to carry out end-to-end workflows.
These agents rely on secure infrastructure layers—sandboxes, identity controls, and policy engines—to manage tool access and protect sensitive data, running within clearly defined permissions and workflows so their actions remain transparent and reviewable by humans.
For example, an autonomous agent tasked with building a website could autonomously manage tasks like designing layout, writing HTML and CSS code, connecting backend processes, generating content, and debugging.

# Long-Running vs. Self-Evolving Agents
Long‑running and self‑evolving agents are simply different ways of implementing autonomous AI agents, shaping how they operate over time and improving with real‑world use.

Long‑running agents are always‑on AI coworkers that keep context across sessions and autonomously execute complex, multi‑step workflows using tools, APIs, and enterprise data—like an AIOps copilot monitoring systems and triggering fixes around the clock. 

Self‑evolving agents go further by continuously improving their own prompts, tools, memory, and workflows based on interaction data and feedback, so capabilities advance over time while safety and performance remain under control—much like a research assistant that steadily sharpens how it searches, synthesizes, and reports insights.

# What Are the Components of an AI Agent?
1. LLM: The “brain” of the agent, an LLM coordinates decision-making. It reasons through tasks, plans actions, selects appropriate tools, and manages access to necessary data to achieve objectives. The agent core is where the agent’s overall goals and objectives are defined and orchestrated. In enterprise settings, this core works within guardrails and policy constraints so the agent’s actions align with business and security requirements.
2. Harness: An agent harness is the scaffolding that gives the LLM the ability to act or do work. It connects long- and short-term memory, knows which tools are available to use, and can even create new skills, if allowed.
3. Secure Runtime: A secure runtime is a dedicated, policy-enforced environment where an agent executes its logic, runs generated code, and interacts with external tools. Every agent has its own sandbox to ensure that even if the agent "goes rogue" or is manipulated, it cannot compromise the underlying host system, exfiltrate sensitive data, or rack up costs.
4. Memory Modules: Autonomous agents rely on memory to maintain context and adapt to ongoing or historical tasks.
5. Planning Modules: Planning modules enable agents to break down complex tasks into actionable steps. Without Feedback: Uses structured techniques like “Chain of Thought” or “Tree of Thought” to decompose specific tasks into manageable steps. With Feedback: Incorporates iterative improvement methods like ReAct, Reflexion, or human-in-the-loop feedback for refined strategies and outcomes.
6. Tools and Skills: AI agents can serve as tools themselves, but they also extend their capabilities by integrating with external systems such as APIs, databases, and RAG pipelines. Skills: Each software tool, library, or even a sub-agent or specialized agent can have associated skills. These skills provide instructions for completing tasks using the tools. APIs: Access real-time data or execute actions programmatically. Databases and RAG pipelines: Retrieve relevant, new information from accurate knowledge bases.

Systems of Models: Open source models, like NVIDIA Nemotron™ and world foundation models such as NVIDIA Cosmos™, help developers customize models for their own use cases, while frontier models offer state-of-the-art performance across a wide range of tasks. Working together, these models enable agents to deliver high accuracy, controlled cost, and better management of data security and privacy.

# How Do AI Agents Work?
 
