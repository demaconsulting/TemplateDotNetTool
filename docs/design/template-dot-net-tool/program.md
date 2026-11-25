## Program

![TemplateDotNetTool Structure](TemplateDotNetToolView.svg)

### Purpose

`Program` is the entry point and execution orchestrator for the Template DotNet Tool. Its single
responsibility is to hand the `help` command to `HelpCommand`, otherwise create a `Context`
from the command-line arguments, dispatch to the appropriate handler based on the parsed flags,
and return the exit code.

### Data Model

**Version**: `string` (static property) — The tool version read from
`AssemblyInformationalVersionAttribute` on every access, falling back to `AssemblyVersion`, then
`"0.0.0"`. No caching is applied; callers that need the value more than once should store it
locally.

### Key Methods

**Main**: Entry point for the tool process.

- *Parameters*: `string[] args` — command-line arguments from the host environment.
- *Returns*: `int` — exit code; 0 for success, 1 for expected errors; for the `help` command,
  0 for success, 2 for a wrong help argument or an unknown topic, and 70 for a defective card
  catalog.
- *Preconditions*: None.
- *Postconditions*: Exit code reflects whether any errors were reported during execution.

First calls `HelpCommand.Default.TryRun(args, out exitCode)`. The `help` command is not an
option, so `Context.Create` would reject it; when the help command answers, `Main` returns its
exit code. Otherwise creates a `Context` using `Context.Create(args)`, calls `Run(context)`,
and returns `context.ExitCode`. Catches `ArgumentException` and `InvalidOperationException` — writes
`"Error: {message}"` to stderr and returns 1. Catches any other `Exception` — writes
`"Unexpected error: {message}"` to stderr and re-throws so the runtime can record it.

**Run**: Dispatches execution based on parsed flags.

- *Parameters*: `Context context` — the parsed context.
- *Returns*: `void`.
- *Preconditions*: `context` is not null.
- *Postconditions*: Exactly one handler has been called.

Inspects flags in priority order: (1) if `context.Version` is true, calls
`context.WriteLine(Version)` and returns; (2) calls `PrintBanner`; (3) if `context.Help` is
true, calls `PrintHelp` and returns; (4) if `context.Validate` is true, calls
`Validation.Run(context)`; (5) otherwise calls `RunToolLogic(context)`.

**PrintBanner**: Writes the tool name, version, and copyright line to `context`.

- *Parameters*: `Context context` — output target.
- *Returns*: `void`.

**PrintHelp**: Writes the usage synopsis (including `templatetool help [topic]`) and options
table to `context`, and ends with `HelpCommand.Default.Footer`, the pointer to the help command.

- *Parameters*: `Context context` — output target.
- *Returns*: `void`.

**RunToolLogic**: Placeholder for main tool logic; writes a demo message to `context`.
Downstream projects replace this method body with actual tool behavior.

- *Parameters*: `Context context` — output target.
- *Returns*: `void`.

### Error Handling

`Main` handles errors at two levels. Expected errors (`ArgumentException` and
`InvalidOperationException`) are written to stderr as `"Error: {message}"` and cause exit
code 1 without a stack trace. Unexpected errors (`Exception`) are written to stderr as
`"Unexpected error: {message}"` and re-thrown so the runtime can record them in event logs.
`Run`, `PrintBanner`, `PrintHelp`, and `RunToolLogic` do not catch exceptions; all errors
propagate to `Main`.

### Dependencies

- **HelpCommand** — `Program.Main` offers the arguments to `HelpCommand.Default.TryRun` before
  the options are parsed, and `PrintHelp` writes `HelpCommand.Default.Footer`.
- **Context** — `Program` reads parsed flags from `Context` and calls `Context.WriteLine` and
  `Context.WriteError` for all output.
- **Validation** — `Program.Run` calls `Validation.Run(context)` when the `--validate` flag is
  set.

### Callers

N/A - entry point, called by the host environment.
