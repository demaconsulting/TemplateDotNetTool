---
title: Command-line options
summary: Every option of the tool, and the order in which a run handles them.
aliases:
  - options
  - flags
tags:
  - reference
order: 2
see-also:
  - self-validation
examples:
  - name: usage
    kind: command
    language: shell
    description: Print the short usage text. It ends with a pointer to this help.
    content: '{{tool}} --help'
    expect: "Run '{{tool}} help' for topics and examples."
  - name: silent-log
    kind: command
    language: shell
    description: Hide the console output and keep it in a log file.
    content: '{{tool}} --silent --log output.log --version'
  - name: unknown-option
    kind: command
    language: shell
    description: An unknown argument is an error, printed even with --silent. Exits 1.
    content: '{{tool}} --silent --unknown'
    exit: 1
    expect: "Error: Unsupported argument '--unknown'"
---
Options start with `--` (or a single letter after `-`) and may be given in
any order.

| Option | Meaning |
| --- | --- |
| `-v`, `--version` | Print only the version. |
| `-?`, `-h`, `--help` | Print the short usage text. |
| `--silent` | Hide console output. Errors still set exit code 1. |
| `--log <file>` | Also write the output to a file. |
| `--validate` | Run the self-tests; see [[self-validation]]. |
| `--results <file>` | Write the self-test results as `.trx` or `.xml`. `--result` also works. |
| `--depth <n>` | First heading level of the self-test report, 1 to 6; default 1. |

**Order.** `--version`, when all arguments are valid, prints only the
version and skips everything else. Without it, the tool prints a banner,
then handles the first of `--help`, `--validate`, or its main function.
The command that [[#silent-log]] prints writes the version to the log
file only.

**Errors.** An unknown argument, or an option without its value, prints
`Error: ...` and exits 1 ([[#unknown-option]]). These errors are found
before `--silent` and `--log` take effect, so they are always printed and
never logged.

**Help.** `help` is a command, not an option, and must be the first
argument. `--silent` and `--log` do not apply to it, and an unknown topic
exits 2.
