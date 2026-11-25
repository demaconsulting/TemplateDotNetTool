### HelpCommand

![Cli Structure](CliView.svg)

#### Purpose

`HelpCommand` answers the `templatetool help` command from the help cards that are embedded in the
tool assembly. Its single responsibility is to recognize the `help` verb before the command-line
options are parsed, and to serve the topic index, topic cards, examples, search results, and JSON
documents for it. It is the only unit that references the HelpCards library, and it is the
pattern that DEMA Consulting command-line tools copy for their built-in help.

#### Data Model

**ToolName**: `string` constant — `templatetool`, the name of the tool as the user types it; used
in the usage lines, the command examples, and the `{{tool}}` token of the cards.

**PurposeTags**: `string[]` — `tutorial`, `reference`, and `troubleshooting`; the closed tag
vocabulary. Every card carries at least one of these tags and no other tag.

**RootCardIds**: `string[]` — the ids of the root cards, which are the topics that
`templatetool help` lists: `getting-started`, `command-line`, and `self-validation`. A missing or
extra root card fails the catalog.

**Cards**: `HelpSource` (static) — the cards embedded in the tool assembly. Creating the source
reads nothing.

**Default**: `HelpCommand` (static) — the instance used by the tool; it writes to the console at
the time of the command.

**_cli**: `HelpCli` — the command-line helper of HelpCards, created from the options of
`CreateOptions`. It is immutable after creation and keeps no state between calls.

**Help cards**: the files under `src/DemaConsulting.TemplateDotNetTool/Help/`, embedded by the
HelpCards build targets. Each card is a Markdown file with YAML front matter; its path below the
`Help` folder, without the extension, is its id. `_source.md` names the source (`name:`) and sets
`schema: 2`. Command examples may state the exit code (`exit:`) and an output fragment
(`expect:`) that a run of the example gives; example names are unique within a card. Cards show
complete sample files only for formats that users author; formats that the tool produces (TRX,
JUnit) are described in prose, and test data stays in the test project.

To add a card, add `Help/<id>.md` with a purpose tag, a title, a summary, and runnable examples;
add the id to `RootCardIds` when it is a new topic; and run the tests. The validation test and the
example-runner test prove that the card is valid and that every command example gives the result
the card states.

#### Key Methods

**TryRun**: Runs the help command when the arguments start with the `help` verb.

- *Parameters*: `string[] args` — the command-line arguments of the tool; `out int exitCode` —
  receives the exit code when the command was answered.
- *Returns*: `bool` — `true` when the arguments started with `help` and were answered; `false`
  when the tool should continue with its own option parser.
- *Preconditions*: None.
- *Postconditions*: When `false` is returned, nothing was written and the catalog was not built.
  When `true` is returned, the answer was written and `exitCode` is 0, 2, or 70.

Delegates to `HelpCli.TryRun`, which compares the first argument with `help` without regard to
case and builds the catalog only after the verb was recognized.

**Footer**: Gets the sentence that ends the usage text.

- *Parameters*: None.
- *Returns*: `string` — `Run 'templatetool help' for topics and examples.`
- *Preconditions*: None.
- *Postconditions*: The catalog was not built.

**CreateOptions**: Creates the options of the command-line helper.

- *Parameters*: optional `TextWriter` output and error writers (`null` for the console), and an
  optional replacement for `Configure` that tests use to observe when the catalog is built.
- *Returns*: `HelpCliOptions` — the tool name, the version from `Program.Version`, the catalog
  configuration, the usage lines, the index preamble, and the writers.
- *Preconditions*: None.
- *Postconditions*: The tool name and the version are set here and nowhere else; the helper
  gives them to the catalog builder itself. `GetCatalogConfiguration` of the options gives the
  tests the composition that the tool ships.

**Configure**: Adds the tool's own part of the catalog configuration to a builder.

- *Parameters*: `HelpCatalogBuilder builder` — the builder to configure.
- *Returns*: `void`.
- *Preconditions*: None.
- *Postconditions*: The builder holds the embedded cards, the closed tag vocabulary
  (`PurposeTags`, each card requiring one of them), and the expected root cards (`RootCardIds`).

**CreateCatalog**: Builds the help catalog exactly as the command does; used by the
example-runner test.

- *Parameters*: None.
- *Returns*: `HelpCatalog` — the validated catalog.
- *Preconditions*: None.
- *Postconditions*: Throws `HelpCatalogException` when a card is defective.

**Create**: Creates a help command that writes to the given writers; used by tests.

- *Parameters*: `TextWriter output`, `TextWriter error`, and an optional replacement for
  `Configure`.
- *Returns*: `HelpCommand` — the new instance.
- *Preconditions*: None.
- *Postconditions*: Answers are written to the given writers.

#### Error Handling

`TryRun` does not throw for user input. A wrong help argument or an unknown topic writes a
message with a hint to the error writer and returns exit code 2. A defective card catalog writes
the first defect to the error writer and returns exit code 70; the validation test reports every
defect at build time, so a defective catalog is not shipped.

The command bypasses `Context`: it is answered before the options are parsed, so no `Context`
exists, `--silent` and `--log` do not apply, and no banner is printed. The output and error
providers of HelpCards are deliberately not used, because routing the answers through a
`Context` would mean parsing the options a second time just for help.

#### Dependencies

- **HelpCards** (OTS) — `HelpCli`, `HelpCliOptions`, `HelpSource`, `HelpCatalog`, and
  `HelpCatalogBuilder`; see *HelpCards*, the OTS integration design.
- **Program** — `Program.Version` supplies the version shown in the index and the `{{version}}`
  token.

#### Callers

- **Program** — `Program.Main` calls `HelpCommand.Default.TryRun` before `Context.Create`, and
  `Program.PrintHelp` ends the usage text with `HelpCommand.Default.Footer`.
