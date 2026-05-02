# Program Verification

This document describes the unit-level verification design for the `Program` unit. It defines the
test scenarios, dependency usage, and requirement coverage for `Program.cs`.

## Verification Approach

`Program` is verified with unit tests defined in `ProgramTests.cs`. Because `Program` directly
instantiates `Context` from real arguments and calls `Validation.Run` when needed, no mocking is
required. The tests pass controlled argument arrays and assert on captured console output and exit
codes.

## Dependencies

| Dependency   | Usage in Tests                                                           |
|--------------|--------------------------------------------------------------------------|
| `Context`    | Used directly (not mocked) — created from the argument array under test. |
| `Validation` | Used directly (not mocked) — called when the validate flag is set.       |

No test doubles are introduced at the `Program` level; all collaborators execute their real logic.

## Test Scenarios

### Program_Run_WithVersionFlag_DisplaysVersionOnly

**Scenario**: `Program.Run` is called with a context created from `["--version"]`.

**Expected**: Standard output contains the version string; the word "Copyright" does not appear;
the banner prefix "Template DotNet Tool version" does not appear; exit code is 0.

**Requirement coverage**: `Template-Program-Version`, `Template-Program-ExitCode`.

### Program_Run_WithHelpFlag_DisplaysUsageInformation

**Scenario**: `Program.Run` is called with a context created from `["--help"]`.

**Expected**: Standard output contains "Usage:" and "Options:"; exit code is 0.

**Requirement coverage**: `Template-Program-Help`, `Template-Program-ExitCode`.

### Program_Run_WithValidateFlag_RunsValidation

**Scenario**: `Program.Run` is called with a context created from `["--validate"]`.

**Expected**: Standard output contains "Total Tests:"; exit code is 0.

**Requirement coverage**: `Template-Program-Validate`, `Template-Program-ExitCode`.

### Program_Run_NoArguments_DisplaysDefaultBehavior

**Scenario**: `Program.Run` is called with a context created from an empty argument array.

**Expected**: Standard output contains the tool name and copyright notice; exit code is 0.

**Requirement coverage**: `Template-Program-ExitCode`.

### Program_Run_ErrorHandling_ExitCodeIsNonZero

**Scenario**: `Program.Main` is called with an unknown flag `["--unknown-flag"]`. The exception
handler in `Main` catches the `ArgumentException` thrown by `Context.Create`, writes an error to
stderr, and returns exit code 1. This scenario is tested via reflection through the Cli subsystem
test `CliSubsystem_InvalidArgs_ContextAndProgram_RejectsUnknownArgumentsAndExitsNonZero` as
related coverage.

**Expected**: Exit code is 1; stderr contains an error message.

**Requirement coverage**: `Template-Program-ExitCode`.

### Program_Version_ReturnsNonEmptyString

**Scenario**: The `Program.Version` static property is read.

**Expected**: The returned string is non-empty and non-null.

**Requirement coverage**: `Template-Program-Version`.

## Requirements Coverage

| Requirement                   | Test Scenario                                     |
|-------------------------------|---------------------------------------------------|
| `Template-Program-Version`    | Program_Run_WithVersionFlag_DisplaysVersionOnly, Program_Version_ReturnsNonEmptyString |
| `Template-Program-Help`       | Program_Run_WithHelpFlag_DisplaysUsageInformation |
| `Template-Program-Validate`   | Program_Run_WithValidateFlag_RunsValidation       |
| `Template-Program-ExitCode`   | Program_Run_WithVersionFlag_DisplaysVersionOnly, Program_Run_WithHelpFlag_DisplaysUsageInformation, Program_Run_WithValidateFlag_RunsValidation, Program_Run_NoArguments_DisplaysDefaultBehavior |
