---
title: Getting started
summary: Install the tool, check that it works, and find the other topics.
aliases:
  - start
  - quickstart
  - examples
tags:
  - tutorial
order: 1
see-also:
  - command-line
  - self-validation
examples:
  - name: version
    kind: command
    language: shell
    description: Print the version and exit.
    content: '{{tool}} --version'
  - name: validate
    kind: command
    language: shell
    description: Run the built-in self-tests. Exits 0 when every test passes.
    content: '{{tool}} --validate'
    expect: 'Failed: 0'
  - name: topic
    kind: command
    language: shell
    description: Print a help topic, here the list of options.
    content: '{{tool}} help command-line'
    expect: '--validate'
---
{{tool}} {{version}} is a .NET tool.
It reads and writes only the files that options name, apart from a temporary folder that `--validate` uses.

1. **Install it.** Install the tool from NuGet, globally or in a local tool
   manifest:

   ```bash
   dotnet tool install -g DemaConsulting.TemplateDotNetTool
   ```

2. **Check it.** The command that [[#version]] prints shows the version.
   The command from [[#validate]] runs the built-in self-tests and exits 0
   when all pass; see [[self-validation]].
3. **Learn the options.** [[command-line]] lists every option. With no
   arguments, the tool prints a banner and runs its main function, which in
   the template prints a demonstration message.

Print any help topic with `{{tool}} help <topic>`, as in the command that
[[#topic]] prints. Add `--search <words>` to find a topic, and `--json` to
get any help answer as JSON.
