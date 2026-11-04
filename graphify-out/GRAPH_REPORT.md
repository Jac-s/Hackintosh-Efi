# Graph Report - Hackintosh-Efi  (2026-11-04)

## Corpus Check
- Corpus is ~230 words - fits in a single context window. You may not need a graph.

## Summary
- 9 nodes · 12 edges · 2 communities (1 shown, 1 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Android Emulator Setup
- Emulator Runner

## God Nodes (most connected - your core abstractions)
1. `main()` - 6 edges
2. `setup-android-emulator.sh script` - 2 edges
3. `check_dependencies()` - 2 edges
4. `install_components()` - 2 edges
5. `create_avd()` - 2 edges
6. `launch_emulator()` - 2 edges
7. `run-emulator.sh script` - 1 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (2 total, 1 thin omitted)

### Community 0 - "Android Emulator Setup"
Cohesion: 0.52
Nodes (6): check_dependencies(), create_avd(), install_components(), launch_emulator(), main(), setup-android-emulator.sh script

## Knowledge Gaps
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Not enough signal to generate questions. This usually means the corpus has no AMBIGUOUS edges, no bridge nodes, no INFERRED relationships, and all communities are tightly cohesive. Add more files or run with --mode deep to extract richer edges._