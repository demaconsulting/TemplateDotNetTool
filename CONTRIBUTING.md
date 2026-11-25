# Contributing to Template DotNet Tool

Thank you for your interest in contributing to Template DotNet Tool! We welcome contributions from the community and
appreciate your help in making this project better.

## Code of Conduct

This project adheres to a [Code of Conduct][code-of-conduct]. By participating, you are expected to uphold this code.
Please report unacceptable behavior through GitHub.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue on GitHub with the following information:

- **Description**: Clear description of the bug
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: Operating system, .NET version, Template DotNet Tool version
- **Logs**: Any relevant error messages or logs

### Suggesting Features

We welcome feature suggestions! Please create an issue on GitHub with:

- **Feature Description**: Clear description of the proposed feature
- **Use Case**: Why this feature would be useful
- **Proposed Solution**: Your ideas on how to implement it (optional)
- **Alternatives**: Any alternative solutions you've considered (optional)

### Submitting Pull Requests

We follow a standard GitHub workflow for contributions:

1. **Fork** the repository
2. **Clone** your fork locally
3. **Create a branch** for your changes (`git checkout -b feature/my-feature`)
4. **Make your changes** following our coding standards
5. **Test your changes** thoroughly
6. **Commit your changes** with clear commit messages
7. **Push** to your fork
8. **Create a Pull Request** to the main repository

## Development Setup

### Prerequisites

- [.NET SDK][dotnet-download] 10.0 and 11.0 (both are required: the 11.0 SDK builds the
  `net11.0` target and the .NET 10 runtime runs the `net10.0` tests)
- Git
- A code editor (Visual Studio, VS Code, or Rider recommended)

### Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/demaconsulting/TemplateDotNetTool.git
   cd TemplateDotNetTool
   ```

2. Restore dependencies:

   ```bash
   dotnet tool restore
   dotnet restore
   ```

3. Build the project:

   ```bash
   dotnet build --configuration Release
   ```

4. Run unit tests:

   ```bash
   dotnet test --configuration Release
   ```

## Coding Standards

### General Guidelines

- Follow the [C# Coding Conventions][csharp-conventions]
- Use clear, descriptive names for variables, methods, and classes
- Write XML documentation comments for all public, internal, and private members
- Keep methods focused and single-purpose
- Write tests for new functionality

### Code Style

This project enforces code style through `.editorconfig`. Key requirements:

- **Indentation**: 4 spaces for C#, 2 spaces for YAML/JSON/XML
- **Line Endings**: LF (Unix-style)
- **Encoding**: UTF-8
- **Namespaces**: Use file-scoped namespace declarations
- **Braces**: Required for all control statements
- **Naming Conventions**:
  - Interfaces: `IInterfaceName`
  - Classes/Structs/Enums: `PascalCase`
  - Methods/Properties: `PascalCase`
  - Parameters/Local Variables: `camelCase`

### XML Documentation

All members require XML documentation with proper indentation:

```csharp
/// <summary>
///     Brief description of what this does.
/// </summary>
/// <param name="parameter">Description of the parameter.</param>
/// <returns>Description of the return value.</returns>
public int ExampleMethod(string parameter)
{
    // Implementation
}
```

Note the spaces after `///` for proper indentation in summary blocks.

## Testing Guidelines

### Test Framework

We use MSTest v4 for unit and integration tests.

### Test Naming Convention

Use the pattern: `ClassName_MethodUnderTest_Scenario_ExpectedBehavior`

Examples:

- `Program_Main_NoArguments_ReturnsSuccess`
- `Context_Create_WithInvalidFlag_ThrowsArgumentException`
- `Validation_Run_AllTests_ReturnsSuccess`

### Writing Tests

- Write tests that are clear and focused
- Use modern MSTest v4 assertions:
  - `Assert.HasCount(expectedCount, collection)`
  - `Assert.IsEmpty(collection)`
  - `Assert.DoesNotContain(item, collection)`
- Always clean up resources (use `try/finally` for console redirection)
- Link tests to requirements in `requirements.yaml` when applicable

### Running Tests

#### Unit Tests

```bash
# Run all unit tests
dotnet test --configuration Release

# Run specific unit test
dotnet test --filter "FullyQualifiedName~YourTestName"

# Run with coverage
dotnet test --collect "XPlat Code Coverage"
```

#### Self-Validation Tests

```bash
# Run self-validation tests
dotnet run --project src/DemaConsulting.TemplateDotNetTool \
  --configuration Release --framework net10.0 --no-build -- --validate
```

## Documentation

### Markdown Guidelines

All markdown files must follow these rules (enforced by LintMark):

- Maximum line length: 120 characters
- Use ATX-style headers (`# Header`)
- Lists must be surrounded by blank lines
- Use reference-style links: `[text][ref]` with `[ref]: url` at document end
- **Exceptions**:
  - `README.md` uses absolute URLs (it's included in the NuGet package)
  - AI agent markdown files (`.github/agents/*.agent.md`) use inline links
    `[text](url)` so URLs are visible in agent context

### Spell Checking

All files are spell-checked using TextLint. **Never** add a word to the `.textlint.yaml` word list in order to silence a
spell-checking failure. Doing so defeats the purpose of spell-checking and reduces the quality of the repository.

- If TextLint flags a word that is **misspelled**, fix the spelling in the source file.
- If TextLint flags a word that is a **genuine technical term** (tool name, project identifier, etc.) and is spelled
  correctly, raise a **proposal** (e.g. comment in a pull request) explaining why the word should be added. The
  proposal must be reviewed and approved before the word is added to the list.

### Help Cards

The built-in help (`templatetool help`) is served from Markdown help cards in
`src/DemaConsulting.TemplateDotNetTool/Help/`, which the DemaConsulting.HelpCards package embeds in the tool
assembly. `Cli/HelpCommand.cs` is the only code that uses the package.

- **One file per topic.** The path below `Help/`, without `.md`, is the card id. `_source.md` names the source
  (`name:`) and sets `schema: 2`.
- **Front matter.** Every card has a `title`, a `summary` (at most 80 characters for a topic, 100 otherwise), and
  exactly one purpose tag: `tutorial`, `reference`, or `troubleshooting`. Add `aliases` for topic names that users
  commonly guess, such as `examples`, so `help <name>` finds the card.
- **New topics.** Add the id of every new top-level card to `HelpCommand.RootCardIds`, the one list of topics; a
  missing or extra topic fails the tests.
- **Examples.** Give every task a runnable `command` example, one command per example: no pipes, redirection, or
  `&&`. Wrap `content` in single quotes and use double quotes inside the command, which bash, PowerShell, and cmd
  read alike. State the result when it matters with `exit:` (default 0) and `expect:`, a short fragment that must
  appear somewhere in the console output; `expect` cannot check a file that the command writes. Keep each
  `description` to about 50 characters.
- **Input files.** Show complete files only for formats that users author, and describe formats that the tool
  produces (TRX, JUnit) in prose. When an example reads a file that users do not author (for example a SARIF file
  from an analyzer), keep it in the test project under `TestData/HelpExamples/`, copy it to the test output, and
  copy it into `invocation.WorkingDirectory` in the example-runner test before running the tool.
- **Width.** A printed card may not be wider than 120 characters. Links print as full commands (`[[#name]]` as
  about 50 characters) and `{{version}}` of a development build as about 46, so keep body lines near 75 characters
  with at most one link each.
- **Text.** Cards are linted and spell-checked like any Markdown file: no body line starting with `#`, no wide
  tables, and every fenced block names its language.

Run `pwsh ./build.ps1 -Changed` after changing a card. The `HelpCommand` unit tests validate every card, with
warnings treated as errors, and check its printed width; an integration test runs every command example against
the built tool and compares the result with the card.

### Adding Built-in Help to an Existing Tool

> **Template only.** This checklist is for retrofitting DEMA Consulting tools from this template; do not copy it
> into a tool's own `CONTRIBUTING.md`. Copy the *Help Cards* section above instead.

1. **Copy verbatim**, renaming only the system, tool, and id prefixes:
   - `Cli/HelpCommand.cs`, `Cli/HelpCommandTests.cs`, and `Runner.RunInDirectory`;
   - the help tests in `ProgramTests.cs`, `CliSubsystemTests.cs`, and `IntegrationTests.cs`;
   - `ots/help-cards.*` under `docs/reqstream`, `docs/design`, and `docs/verification`, and the `HelpCards` part
     def in `docs/sysml2/model/ots.sysml`;
   - `cli/help-command.*` under the same three folders and `docs/sysml2/model`.
2. **Adapt**:
   - `HelpCommand.ToolName` (the one place the command name appears in the help code), `RootCardIds`, and the
     cards: write the tool's own, keeping the starter cards' structure. Check every `expect` value against the
     tool's output.
   - `Program.Main` (the `TryRun` call before `Context.Create`) and `Program.PrintHelp` (the `help [topic]` usage
     line and the footer).
   - The `DemaConsulting.HelpCards` package reference, the `src/**/Help/**` pattern in `needs-review`, and the
     `TemplateTool-Cli-HelpCommand` and `OTS-HelpCards` review sets.
   - The help requirements of the system, Cli, and Program; the *Help Command* interface of the system design,
     which is the design documents' one statement of the exit codes and of `--silent`/`--log` not applying; the
     Cli and Program design and verification docs; and the file lists in `requirements.yaml`, `definition.yaml`,
     `introduction.md`, and `ots.md`.
   - The README usage block and any `--help` output it shows, and the user guide: put *Built-in Help* right after
     `--help`, in the file that describes the command line in a multi-file guide. The user guide keeps its own
     exit-code table, and the rest of its help text refers to that table.
3. **Change together**: each requirement id with every `children` link to it; each test name with its
   requirement, its verification scenario, and the test; the review-set ids; and the tool name in `ToolName` and
   `_source.md` (cards use the `{{tool}}` token).
4. **Commit the review sets with the code.** ReviewMark fails a commit that adds source files no review set covers.
   The build, lint, and fix scripts need no change.
5. **Classify HelpCards as OTS**, like the other DEMA Consulting tools that this template uses (BuildMark,
   ReqStream, and others): another repository produces it and the tool does not change it.
6. **Existing `ots.sysml`**: add the `HelpCards` part def to its package, with the repository's naming suffix if it
   uses one (for example `HelpCardsPackage`), and declare `dependency HelpCommand to HelpCards;`. Follow the
   repository's convention for drawing OTS items: if its overview view already draws runtime OTS packages, add a
   `HelpCards` part there too; otherwise expose them in an `OtsView`, as this template does.
7. **Flat namespace**: when the tool has no `Cli` namespace, put `HelpCommand.cs` beside `Context.cs`, drop `.Cli`
   from the namespaces, and place its requirement, design, verification, and SysML files beside those of
   `Context`.

## Quality Checks

Before submitting a pull request, ensure all quality checks pass.

While developing, the scripts can limit themselves to what your change affects (compared with `origin/main`,
including uncommitted files). Each script requires a scope and prints its usage with `-Help`; run the full
`-All` checks below before submitting:

```pwsh
pwsh ./build.ps1 -Changed    # build and test only the test projects the changes affect
pwsh ./fix.ps1 -Changed      # auto-fix only the changed file types
pwsh ./lint.ps1 -Changed     # run only the lint checks whose inputs changed
```

### 1. Build and Test

```bash
# Build the project
dotnet build --configuration Release

# Run unit tests
dotnet test --configuration Release
```

All tests must pass with zero warnings. The script equivalent is `pwsh ./build.ps1 -All`.

### 2. Linting

```pwsh
# After making changes: applies dotnet format, markdown, and YAML fixes silently
pwsh ./fix.ps1 -All

# Before submitting a pull request: all linters must pass
pwsh ./lint.ps1 -All
```

### 3. Code Coverage

Maintain or improve code coverage. Use the `--collect "XPlat Code Coverage"` option when running tests.

## Commit Messages

Write clear, concise commit messages:

- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit first line to 72 characters
- Reference issues and pull requests when applicable

Examples:

- `Add support for custom report headers`
- `Fix crash when results file path is invalid`
- `Update documentation for --report-depth option`
- `Refactor argument parsing for better testability`

## Pull Request Process

1. **Update Documentation**: Update relevant documentation for your changes
2. **Add Tests**: Include tests that cover your changes
3. **Run Quality Checks**: Ensure all linters, tests, and builds pass
4. **Submit PR**: Create a pull request with a clear description
5. **Code Review**: Address feedback from maintainers
6. **Merge**: Once approved, a maintainer will merge your PR

### Pull Request Template

When creating a pull request, include:

- **Description**: What changes does this PR introduce?
- **Motivation**: Why are these changes needed?
- **Related Issues**: Link to any related issues
- **Testing**: How have you tested these changes?
- **Checklist**:
  - [ ] Tests added/updated
  - [ ] Documentation updated
  - [ ] All tests pass
  - [ ] Code follows style guidelines
  - [ ] No new warnings introduced

## Requirements Management

Template DotNet Tool uses [DemaConsulting.ReqStream][reqstream] for requirements traceability:

- All requirements are defined in `requirements.yaml`
- Each requirement should be linked to test cases
- Run `dotnet reqstream` to generate requirements documentation
- Use the `--enforce` flag to ensure all requirements have test coverage

## Release Process

Releases are managed by project maintainers. The process includes:

1. Version bump in project files
2. Tag the release in Git
3. Build and test across all supported platforms
4. Publish NuGet package
5. Create GitHub release with artifacts and release notes

## Getting Help

- **Questions**: Use [GitHub Discussions][discussions]
- **Bugs**: Report via [GitHub Issues][issues]
- **Security**: See [SECURITY.md][security] for vulnerability reporting

## License

By contributing to Template DotNet Tool, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing to Template DotNet Tool!

[code-of-conduct]: https://github.com/demaconsulting/TemplateDotNetTool/blob/main/CODE_OF_CONDUCT.md
[dotnet-download]: https://dotnet.microsoft.com/download
[csharp-conventions]: https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions
[reqstream]: https://github.com/demaconsulting/ReqStream
[discussions]: https://github.com/demaconsulting/TemplateDotNetTool/discussions
[issues]: https://github.com/demaconsulting/TemplateDotNetTool/issues
[security]: https://github.com/demaconsulting/TemplateDotNetTool/blob/main/SECURITY.md
