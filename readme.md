# AI Assistants for Scientific Coding

## Code for the book

[View the book, rendered with Quarto pages](https://www.seascapemodels.org/AI-assistants-for-scientific-coding/)

## v2 structure

The book is now a set of short, self-paced modules (~10 min each) grouped into six sections, following Introduction and Setup. Every module except Introduction and Setup ends with a Challenge callout. See `_quarto.yml` for the full chapter/part list.

- Introduction, Setup (no quizzes)
- Section 1: Line-by-line code completion
- Section 2: Agents
- Section 3: AI in workflows
- Section 4: Security, data privacy and cloud agents
- Section 5: Agentic engineering for data analysis
- Section 6: LLM access via API

## Planned updates

The `fakedataR` package pointer lives in Section 4's [Keeping data secure from the cloud](section-4-security-privacy/04-keeping-data-secure.qmd) module — still needs proper hands-on investigation before recommending it more strongly.

Two Section 4 modules need a real hands-on pass before publishing: [Claude Code for web example](section-4-security-privacy/02-claude-code-web-example.qmd) and [Bash sandbox example](section-4-security-privacy/03-bash-sandbox-example.qmd) — both are drafted, but should be run through and verified rather than taken on faith.

`quarto render` needs to be run locally to regenerate `docs/` — it wasn't available in the environment this rewrite was drafted in, so `docs/` still reflects the old v1 chapter structure until re-rendered.

Chapter 11 from v1 ("Authoring documents" — writing papers with Quarto + AI) was dropped from v2 rather than migrated. It's still fully recoverable from git history / `main` if it's wanted back in as a future section.

## Teaching plan

Map a seminar session onto sections rather than individual chapters:

1. Setup + Section 1 (line-by-line completion) — intro to the tools, cheapest to demo live.
2. Section 6 (API access) + DIY stats bot — prompting fundamentals, using ellmer, vscode or just a web browser.
   - Get participants to try a specific vs. vague prompt and score the answers.
   - Do the "break your problem into smaller parts" example live, comparing two models and two prompt strategies.
3. Section 3 (workflows) + Section 5 (agentic engineering) — stats problem solving, implementation advice, verification habits.
4. Section 2 (agents) + Section 4 (security/privacy) — automation, safety, and a discussion of what this means for science.

## Notes for next time

Works well having VSCode and coding first.
Add some more case-studies, e.g. make three creative figure ideas and prototype these; create three analyses and explore residual diagnostics.
Deep search.
