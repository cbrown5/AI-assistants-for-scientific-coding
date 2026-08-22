Currently working on the 'version2' branch

## Update agent optoins
Note that these are continually changing. I used to use Roo code, but they went to a commercial online only option. Chat with Claude:
hort answer: yes, but the landscape shifted — Roo Code is gone and Cline is now the main survivor.

Roo Code is dead. The team announced in March 2026 that it was shutting down the VS Code extension, Cloud, and Router services on May 15, pivoting to "Roomote," a cloud-based agent that runs tasks end-to-end across Slack, GitHub, and Linear — their reasoning being that IDEs aren't the future of coding. The GitHub repo is archived and the docs carry an "Extension Shutdown" warning, though the Marketplace listing is still up (v3.54.0, 1.7M+ installs), which trips people up. It'll still run with your own API keys for now, but it will drift as provider APIs change, and there are no more bug fixes or security patches. Don't start there. 
The New Stack + 2

Cline is fine and still the reference implementation. Apache 2.0, ~61–66k stars, shipping around v3.81, and as of 2026 it runs in VS Code, JetBrains, Cursor, Windsurf, Zed, Neovim, plus a CLI preview for macOS and Linux. The extension is free; you pay whichever provider you point it at, and it works fine against Ollama or LM Studio locally. Cline Teams/enterprise exists but is a separate optional layer — the extension isn't crippled without it. 
DeployHQ
ShadowGen

Two maintained Roo successors, if you liked Roo's mode system:

Zoo Code — a community fork with the same features, settings structure, and Apache 2.0 license; existing Roo configs carry over. Roo's own farewell notice points here, and the extension ID is ZooCodeOrganization.zoo-code; the .roo folder and custom rules/modes still work. The repo was updated within the last few days, so it's genuinely alive — but it's a young, small-team project, which is the main risk. 
Zoocode
Note

Kilo Code — forked from both Cline and Roo, ~27k stars, 3M+ users, and acquired by Anaconda in July 2026, continuing as open source. They've published an explicit open-source commitment ("features that are open source today stay open source tomorrow") and even opened their Gateway/Cloud backend source. Given Roo's exit, treat any commercial owner's promises as a soft guarantee, but the code is Apache 2.0 and forkable regardless. 
The AI Agent Index
Kilo

A couple of adjacent things worth knowing since you're evaluating longevity: Continue ended active development with its final 2.0 release in June 2026, and Void was archived read-only on June 2, 2026. If you'd tolerate a terminal agent instead of an extension, opencode is MIT, model-agnostic, and by far the largest community of the bunch (~200k stars, actively pushed as of a couple of days ago). 
Frontman
Morph

If you want the lowest-maintenance-risk choice that runs entirely locally against your own models: Cline. If you specifically want Roo's Architect/Code/Debug modes back, Zoo Code for the direct migration path, Kilo for the bigger project behind it.

## Add note about use of AI to write text .


## Section 1

M03 Add student task for copilot settings - next edit suggestions (rename variables in a script)

## Section 2

M02 Add short discussion on other memory files lke claude.md and agents.md. Crosslink to section 2 M02

Section 6

## Add appendix section

Add an appendix section with: intro to markdown. Intro to quarto. Make it brief, link to external resources. 

## Add section on local models
Scaffolded in `section-8-local-models/` from the blog post. Still to do: write the Challenge callouts (all six modules currently say TODO), and check whether the intro/setup need a pointer to it.

## Agentic engineering

Add section on asking for multiple subagents to run a task independently. Then test and compare. Even better provide them with test data so you can evaluate their performance. 

## Positron
Add more about positron and its setup

## Open LLM
Read and update this section

Try out then add Qwen2.5-Coder at 1.5B or 0.5B if you're CPU-only, larger with VRAM for autocomplete, try llama.vscode for tab completion