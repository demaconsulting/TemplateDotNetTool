# Template DotNet Tool

[![Build on Push](https://github.com/demaconsulting/TemplateDotNetTool/actions/workflows/build_on_push.yaml/badge.svg)](https://github.com/demaconsulting/TemplateDotNetTool/actions/workflows/build_on_push.yaml)

DEMA Consulting template project for DotNet Tools, demonstrating best practices for building command-line tools with .NET.

## Features

This template demonstrates:

- **Standardized Command-Line Interface**: Context class handling common arguments (`--version`, `--help`, `--silent`, `--validate`, `--results`, `--log`)
- **Self-Validation**: Built-in validation tests with TRX/JUnit output
- **Multi-Platform Support**: Builds and runs on Windows and Linux
- **Multi-Runtime Support**: Targets .NET 8, 9, and 10
- **Comprehensive CI/CD**: GitHub Actions workflows with quality checks, builds, and integration tests
- **Documentation Generation**: Automated build notes, user guide, code quality reports, requirements, justifications, and trace matrix

## Installation

Install the tool globally using the .NET CLI:

```bash
dotnet tool install -g DemaConsulting.TemplateDotNetTool
```

## Usage

```bash
# Display version
templatetool --version

# Display help
templatetool --help

# Run self-validation
templatetool --validate

# Save validation results
templatetool --validate --results results.trx

# Silent mode with logging
templatetool --silent --log output.log
```

## Command-Line Options

| Option | Description |
|--------|-------------|
| `-v`, `--version` | Display version information |
| `-?`, `-h`, `--help` | Display help message |
| `--silent` | Suppress console output |
| `--validate` | Run self-validation |
| `--results <file>` | Write validation results to file (TRX or JUnit format) |
| `--log <file>` | Write output to log file |

## Building from Source

```bash
# Restore dependencies
dotnet restore

# Build the project
dotnet build --configuration Release

# Run tests
dotnet test --configuration Release

# Create NuGet package
dotnet pack --configuration Release
```

## Project Structure

```
TemplateDotNetTool/
├── src/
│   └── DemaConsulting.TemplateDotNetTool/
│       ├── Context.cs           # Command-line argument handling
│       ├── Program.cs            # Main entry point
│       └── Validation.cs         # Self-validation tests
├── docs/                         # Documentation source files
├── .github/workflows/            # CI/CD workflows
├── requirements.yaml             # Requirements specification
└── DemaConsulting.TemplateDotNetTool.sln
```

## CI/CD Pipeline

The GitHub Actions workflow performs:

1. **Quality Checks**: Markdown linting, spell checking, YAML linting
2. **Build**: Multi-platform build on Windows and Linux
3. **CodeQL Analysis**: Security scanning
4. **Integration Tests**: Test on Windows/Linux with .NET 8/9/10
5. **Documentation Generation**: Build all project documents

## Documentation

Generated documentation includes:

- **Build Notes**: Release information and changes
- **User Guide**: Comprehensive usage documentation
- **Code Quality Report**: CodeQL and SonarCloud analysis results
- **Requirements**: Functional and non-functional requirements
- **Requirements Justifications**: Detailed requirement rationale
- **Trace Matrix**: Requirements to test traceability

## License

Copyright (c) DEMA Consulting. Licensed under the MIT License. See [LICENSE](LICENSE) for details.
