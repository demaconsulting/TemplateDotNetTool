## HelpCards

This document describes the integration and usage design for the `HelpCards` OTS software item
(the `DemaConsulting.HelpCards` NuGet package).

### Purpose

HelpCards provides the built-in help of the tool. It turns Markdown help cards embedded in the
tool assembly into a validated catalog, serves `templatetool help` from that catalog for people
and AI agents, and supplies the test helpers that prove the cards are valid and that their
examples work.

It was chosen because DEMA Consulting command-line tools want help of the quality of a skill file:
a short usage text that points to topics, and a focused card per topic with worked examples that a
person or an AI agent can read, search, and request as JSON. The package is maintained within the
same program (DEMA Consulting), has no dependencies beyond the .NET Base Class Library, carries a
compatible MIT license, and ships build targets that embed the cards in the assembly, so a .NET
tool package needs no loose files.

The package is classified as an OTS item: it is produced by a different repository, this
repository does not change it, and it is verified through integration tests of the features the
tool uses. This repository has no Shared Package artifact tree, and other DEMA Consulting tools
(ReqStream) model the same package as an OTS item.

### Features Used

- **`HelpSource.FromAssembly`** — exposes the `Help` folder that the package build targets embed
  in the tool assembly. Creating the source reads nothing.
- **`HelpCli.Create`**, **`HelpCli.TryRun`**, and **`HelpCli.Footer`** — the command-line helper that
  answers `help`, `help <topic>`, `--example`, `--search`, and `--json`, and the constant pointer
  sentence for the usage text.
- **`HelpCliOptions`** — `ToolName` and `Version` are set once and the helper gives both to the
  catalog builder; `ConfigureCatalog` adds the sources and settings that belong to the tool;
  `UsageLines` and `IndexPreamble` shape the topic index; `GetCatalogConfiguration` gives the
  tests the identical composition.
- **`HelpCatalog.Create`** with **`HelpCatalogBuilder.AddSource`**, **`TagVocabulary`**, and
  **`ExpectedRoots`** — builds and validates the catalog, and fixes the allowed tags and the set of
  topics.
- **`HelpCardValidator.AssertValid`** with **`HelpValidationOptions.WarningsAreErrors`** — a unit
  test proves the cards are valid, including the expected topics, the purpose tags, and the
  command lines of the examples.
- **`HelpExampleRunner.Run`**, **`HelpExampleOutcome`**, and **`HelpExampleRunReport.AssertSucceeded`**
  — a system test runs every command example against the built tool and compares the exit code
  (`exit`) and the output fragment (`expect`) that the card states. The runner saves the source
  examples of each card to a fresh scratch folder; it never starts a process, so the test supplies
  a delegate that runs the built tool in that folder.
- **MSBuild targets** shipped in the package — embed `Help/**` as resources of the tool assembly.

### Integration Pattern

`HelpCommand` is the only unit that uses the package in the shipped tool. It keeps one static
`HelpSource` and one `HelpCli`; creating them performs no I/O and needs no disposal.
`Program.Main` calls `HelpCommand.Default.TryRun` before `Context.Create`. The package answers only
when the first argument is `help`, and otherwise returns `false` without building the catalog, so
no other run reads or parses a card.

The tool project file references the package directly, because only a project with its own
package reference embeds cards; the reference is a normal runtime dependency of the tool. The
test project receives the validator and example-runner helpers through its project reference to
the tool. The package is a pre-release, so its exact version is pinned in the project file;
upgrading it requires re-running the card validation and example-runner tests and a review of
this design.

The cards use schema 2 (`schema: 2` in `_source.md`): an inline example names the file to save it
as with `save-as`, and a command example states its result with `exit` and `expect`.

The help answer is written by the package directly to the console, not through `Context`.
`--silent` and `--log` therefore do not apply to the `help` command, and the output and error
provider hooks of the package are not used: the verb is answered before the options are parsed,
so no `Context` exists yet. See the *HelpCommand* unit design.
