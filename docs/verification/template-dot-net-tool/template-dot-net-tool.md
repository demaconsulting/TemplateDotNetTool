# System Verification

This document describes the system-level verification design for the Template DotNet Tool. It
defines the overall verification strategy, test environments, interface simulation approach, and
end-to-end integration test scenarios that together demonstrate the system meets its requirements.

## Verification Strategy

System-level verification uses end-to-end integration tests that invoke the tool as a real process
via the `Runner.Run` helper in `IntegrationTests.cs`. Each test exercises the full stack — argument
parsing, dispatch, execution, and output — and validates both exit code and console output.

This approach ensures that system requirements are verified at the system boundary without assuming
any internal implementation detail. The tests treat the tool as a black box and assert on
observable outputs only.

**Note**: `Runner.Run` merges stdout and stderr into a single combined output string. Per-stream
assertions (e.g., "standard error is empty") are therefore not possible at the integration test
level; all assertions are made against the combined output.

## Test Environments

Integration tests are executed across the following environments to satisfy multi-runtime and
multi-platform requirements:

| Runtime    | Platform |
|------------|----------|
| .NET 8.0   | Windows  |
| .NET 8.0   | Linux    |
| .NET 8.0   | macOS    |
| .NET 9.0   | Windows  |
| .NET 9.0   | Linux    |
| .NET 9.0   | macOS    |
| .NET 10.0  | Windows  |
| .NET 10.0  | Linux    |
| .NET 10.0  | macOS    |

All integration test scenarios are expected to produce identical results on all supported runtime
and platform combinations.

## External Interface Simulation

At the system level, no interfaces are mocked. All external interfaces are exercised with real
implementations:

- **Standard output / standard error** — Captured by `Runner.Run` and returned as a combined
  string for assertion. Per-stream assertions are not available.
- **File system** — Temporary files and directories are created and cleaned up within each test.
  The `--results` and `--log` flags are exercised with real file paths under a temporary folder.
- **Process exit code** — Returned by `Runner.Run` and asserted directly.

## Integration Test Scenarios

The following integration test scenarios are defined in `IntegrationTests.cs`.

### IntegrationTest_VersionFlag_OutputsVersion

**Scenario**: The `--version` flag is passed as the sole argument.

**Expected**: Exit code 0; combined output contains the tool version string; combined output does
not contain error messages.

### IntegrationTest_HelpFlag_OutputsUsageInformation

**Scenario**: The `--help` flag is passed as the sole argument.

**Expected**: Exit code 0; combined output contains the text "Usage" and "Options"; combined
output does not contain error messages.

### IntegrationTest_ValidateFlag_RunsValidation

**Scenario**: The `--validate` flag is passed as the sole argument.

**Expected**: Exit code 0; combined output contains a validation summary (the text "Total Tests:"
appears in the output).

### IntegrationTest_ValidateWithResults_GeneratesTrxFile

**Scenario**: The `--validate` flag is combined with `--results <path>.trx` pointing to a
temporary file.

**Expected**: Exit code 0; a TRX file is created at the specified path; the file contains a
`<TestRun` XML element confirming the TRX format is valid.

### IntegrationTest_ValidateWithResults_GeneratesJUnitFile

**Scenario**: The `--validate` flag is combined with `--results <path>.xml` pointing to a
temporary file.

**Expected**: Exit code 0; an XML file is created at the specified path; the file contains a
`<testsuites` XML element confirming the JUnit format is valid.

### IntegrationTest_SilentFlag_SuppressesOutput

**Scenario**: The `--version` and `--silent` flags are passed together.

**Expected**: Exit code 0; combined output is empty or whitespace-only.

### IntegrationTest_LogFlag_WritesOutputToFile

**Scenario**: The `--log <path>` flag is passed pointing to a temporary file.

**Expected**: Exit code 0; the specified log file is created and contains output that also appears
on standard output.

### IntegrationTest_UnknownArgument_ReturnsError

**Scenario**: An unrecognized argument (e.g., `--unknown`) is passed.

**Expected**: Exit code non-zero; combined output contains an error message indicating the
unrecognized argument.

### IntegrationTest_ValidateWithDepth_OutputsHeadingAtCorrectDepth

**Scenario**: The `--validate` flag is combined with `--depth 3`.

**Expected**: Exit code 0; combined output contains `###` (heading at depth 3).

## Requirements Coverage

The following list maps each system-level requirement category to the integration test scenarios
that verify it.

- **Version display**: IntegrationTest_VersionFlag_OutputsVersion
- **Help display**: IntegrationTest_HelpFlag_OutputsUsageInformation
- **Self-validation**: IntegrationTest_ValidateFlag_RunsValidation
- **TRX results output**: IntegrationTest_ValidateWithResults_GeneratesTrxFile
- **JUnit results output**: IntegrationTest_ValidateWithResults_GeneratesJUnitFile
- **Silent mode**: IntegrationTest_SilentFlag_SuppressesOutput
- **Log file output**: IntegrationTest_LogFlag_WritesOutputToFile
- **Invalid argument rejection**: IntegrationTest_UnknownArgument_ReturnsError
- **`Template-System-Depth`**: IntegrationTest_ValidateFlag_RunsValidation,
  IntegrationTest_ValidateWithDepth_OutputsHeadingAtCorrectDepth
- **`Template-System-ValidateFailure`**: *(no integration test yet)*
- **`Template-System-DefaultBehavior`**: *(no integration test yet)*
- **`Template-System-ResultAlias`**: *(no integration test yet)*
