## Cli

![Cli Structure](CliView.svg)

### Overview

The `Cli` subsystem is the boundary between the host environment's command-line invocation and
the tool's internal logic. It owns argument parsing, output channel management, and exit-code
tracking. All other subsystems receive a `Context` object from this subsystem to read parsed
flags and write output. It also answers the built-in `help` command. The `Cli` subsystem
contains two units: `Context` and `HelpCommand`.

### Interfaces

**Context.Create**: Factory method that constructs a `Context` from a command-line argument array.

- *Type*: In-process .NET static method.
- *Role*: Provider.
- *Contract*: Parses `string[] args` into flag properties and opens the log file if `--log` is
  present. Returns a fully initialized `Context`. Accepts `--result` as a legacy alias for
  `--results`.
- *Constraints*: Throws `ArgumentException` for unknown or malformed arguments; throws
  `InvalidOperationException` when the log file cannot be opened.

**Context.WriteLine**: Writes a message to stdout and to the log file.

- *Type*: In-process .NET instance method.
- *Role*: Provider.
- *Contract*: Writes `message` to `Console.Out` and to the log file if one is open. Stdout
  output is suppressed when `Silent` is true; the log file always receives the message.
- *Constraints*: None.

**Context.WriteError**: Writes an error message and sets the error exit code.

- *Type*: In-process .NET instance method.
- *Role*: Provider.
- *Contract*: Sets `_hasErrors` to true, writes `message` in red to `Console.Error`, and writes
  to the log file if one is open. Stderr output is suppressed when `Silent` is true, but
  `ExitCode` is set to 1 regardless.
- *Constraints*: Once set, `ExitCode` cannot return to 0 within the same invocation.

**Context.ExitCode**: Derived property returning 0 or 1.

- *Type*: In-process .NET property.
- *Role*: Provider.
- *Contract*: Returns 1 if `WriteError` has been called at least once; returns 0 otherwise.
- *Constraints*: Read-only.

**Context.Dispose**: Releases the log file `StreamWriter`.

- *Type*: In-process .NET method (`IDisposable`).
- *Role*: Provider.
- *Contract*: Disposes `_logWriter` and sets it to null; flushes any buffered content. Callers
  must use a `using` statement to guarantee disposal.
- *Constraints*: Safe to call multiple times (idempotent after first call).

**HelpCommand.TryRun**: Answers the `help` command from the built-in help cards.

- *Type*: In-process .NET instance method (on the shared `HelpCommand.Default` instance).
- *Role*: Provider.
- *Contract*: Returns `false` at once, writing nothing, when the first argument is not `help`
  (compared without regard to case). Otherwise builds the card catalog, writes the topic index,
  a topic card, an example, search results, or JSON to the console, returns `true`, and sets
  the exit code: 0 for success, 2 for a wrong help argument or an unknown topic, 70 for a
  defective card catalog.
- *Constraints*: Does not throw for user input; does not use `Context`.

**HelpCommand.Footer**: The sentence that points a reader of the usage text to the help command.

- *Type*: In-process .NET property.
- *Role*: Provider.
- *Contract*: Returns `Run 'templatetool help' for topics and examples.`
- *Constraints*: Constant; reading it never builds the help catalog.

### Design

The `Cli` subsystem has no subsystem-level code of its own; its behavior is provided by the
`Context` and `HelpCommand` units, which do not call each other. `Program.Main` offers the
arguments to `HelpCommand.TryRun` first. When the help command answers, the invocation ends
with its exit code and no `Context` is created. Otherwise `Program` creates a `Context` and
passes it to all other units that produce output.

`HelpCommand` writes its answers to the console itself. It is the one exception to `Context`
owning all output: the `help` command is answered before the options are parsed, so no
`Context` exists yet, and `--silent` and `--log` do not apply to it.

The subsystem has no dependencies on other tool subsystems. `Context` uses only .NET BCL types
(`Console`, `StreamWriter`); `HelpCommand` uses the HelpCards OTS library and reads the
tool version from `Program.Version`.

Error handling flows from `Context.Create` to `Program.Main`: argument parsing errors propagate
as `ArgumentException`; log-file errors propagate as `InvalidOperationException`. Both are
caught and handled in `Program.Main`, which writes the error to stderr and returns exit code 1.

When `--log` is active, `Context` holds an open `StreamWriter` for the duration of the
invocation. The `Program.Main` call site wraps the `Context` in a `using` statement to ensure
the file handle is released and buffered content is flushed on exit.
