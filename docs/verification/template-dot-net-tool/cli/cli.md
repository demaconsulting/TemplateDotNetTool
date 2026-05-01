# Cli Subsystem Verification

<!-- TODO: Fill in for your project -->

This document describes the subsystem-level verification design for the `Cli` subsystem. It
defines the integration test approach, subsystem boundary, mocking strategy, and test scenarios
that together verify the `Cli` subsystem requirements.

## Verification Approach

<!-- TODO: Fill in for your project -->

The `Cli` subsystem boundary at `Program` is verified by integration tests defined in
`CliSubsystemTests.cs`. Each test exercises `Context.Create` and `Program.Run` together, treating
the pair as the observable subsystem interface. Tests pass controlled argument arrays and assert
on captured console output, file system side-effects, and exit codes.

## Dependencies and Mocking Strategy

<!-- TODO: Fill in for your project -->

At the subsystem boundary, `Validation` (part of the `SelfTest` subsystem) is the only external
collaborator that `Program` calls. In scenarios that exercise the `--validate` path, `Validation`
executes its real logic rather than being stubbed. Scenarios that do not involve `--validate` do
not reach `Validation` at all.

No mocking is applied at this level; all collaborators within and directly adjacent to the
subsystem use their real implementations.

## Integration Test Scenarios

<!-- TODO: Fill in for your project -->

The following integration test scenarios are defined in `CliSubsystemTests.cs`.

### CliSubsystem_VersionFlow_ContextAndProgram_DisplaysVersionAndExits

**Scenario**: Arguments `["--version"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: Standard output contains the version string; exit code is 0.

### CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits

**Scenario**: Arguments `["--help"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: Standard output contains help text; exit code is 0.

### CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits_WithShortQuestionFlag

**Scenario**: Arguments `["-?"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: Standard output contains help text; exit code is 0.

### CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits_WithShortHFlag

**Scenario**: Arguments `["-h"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: Standard output contains help text; exit code is 0.

### CliSubsystem_ValidateFlow_ContextAndProgram_RunsValidationAndExits

**Scenario**: Arguments `["--validate"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: Standard output contains the validation summary; exit code is 0.

### CliSubsystem_SilentFlow_ContextAndProgram_SuppressesOutput

**Scenario**: Arguments `["--silent"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: Standard output is empty; exit code is 0.

### CliSubsystem_ResultsFlow_ContextAndProgram_WritesResultsFile

**Scenario**: Arguments `["--validate", "--results", "<tmp>.trx"]` are passed through
`Context.Create` and `Program.Run`.

**Expected**: A results file is created at the specified path; exit code is 0.

### CliSubsystem_LogFlow_ContextAndProgram_WritesLogFile

**Scenario**: Arguments `["--log", "<tmp>.log"]` are passed through `Context.Create` and
`Program.Run`.

**Expected**: A log file is created at the specified path; exit code is 0.

### CliSubsystem_InvalidArgs_ContextAndProgram_RejectsUnknownArgumentsAndExitsNonZero

**Scenario**: Arguments containing an unknown flag are passed through `Context.Create` and
`Program.Run`.

**Expected**: Exit code is non-zero; standard error contains an error message.

### CliSubsystem_ErrorOutput_ContextAndProgram_WritesErrorToStderr

**Scenario**: An error condition is triggered through the subsystem.

**Expected**: Standard error receives the error message; exit code is non-zero.

### CliSubsystem_ResultAliasFlow_ContextAndProgram_WritesResultsFile

**Scenario**: Arguments `["--validate", "--result", "<tmp>.trx"]` (legacy alias) are passed
through `Context.Create` and `Program.Run`.

**Expected**: A results file is created at the specified path; exit code is 0.

### CliSubsystem_DepthFlow_ContextAndProgram_AdjustsHeadingDepth

**Scenario**: Arguments `["--depth", "2"]` are passed through `Context.Create` and `Program.Run`.

**Expected**: The heading depth is set to the specified value; exit code is 0.

## Requirements Coverage

<!-- TODO: Fill in for your project -->

| Requirement                 | Test Scenario                                                                      |
|-----------------------------|------------------------------------------------------------------------------------|
| Version flag handling       | CliSubsystem_VersionFlow_ContextAndProgram_DisplaysVersionAndExits                 |
| Help flag (long form)       | CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits                       |
| Help flag (-?)              | CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits_WithShortQuestionFlag |
| Help flag (-h)              | CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits_WithShortHFlag        |
| Validate flag handling      | CliSubsystem_ValidateFlow_ContextAndProgram_RunsValidationAndExits                 |
| Silent flag handling        | CliSubsystem_SilentFlow_ContextAndProgram_SuppressesOutput                         |
| Results flag handling       | CliSubsystem_ResultsFlow_ContextAndProgram_WritesResultsFile                       |
| Log flag handling           | CliSubsystem_LogFlow_ContextAndProgram_WritesLogFile                               |
| Unknown argument rejection  | CliSubsystem_InvalidArgs_ContextAndProgram_RejectsUnknownArgumentsAndExitsNonZero  |
| Error output to stderr      | CliSubsystem_ErrorOutput_ContextAndProgram_WritesErrorToStderr                     |
| Results alias flag handling | CliSubsystem_ResultAliasFlow_ContextAndProgram_WritesResultsFile                   |
| Depth flag handling         | CliSubsystem_DepthFlow_ContextAndProgram_AdjustsHeadingDepth                       |
