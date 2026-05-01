# System Verification

<!-- TODO: Fill in for your project -->

This document describes the system-level verification design for the Template DotNet Tool. It
defines the overall verification strategy, test environments, interface simulation approach, and
end-to-end integration test scenarios that together demonstrate the system meets its requirements.

## Verification Strategy

<!-- TODO: Fill in for your project -->

System-level verification uses end-to-end integration tests that invoke the tool as a real process
via the `Runner.Run` helper in `IntegrationTests.cs`. Each test exercises the full stack — argument
parsing, dispatch, execution, and output — and validates both exit code and console output.

This approach ensures that system requirements are verified at the system boundary without assuming
any internal implementation detail. The tests treat the tool as a black box and assert on
observable outputs only.

## Test Environments

<!-- TODO: Fill in for your project -->

Integration tests are executed across the following environments to satisfy multi-runtime and
multi-platform requirements:

| Runtime    | Platform |
|------------|----------|
| .NET 8.0   | Windows  |
| .NET 8.0   | Linux    |
| .NET 9.0   | Windows  |
| .NET 9.0   | Linux    |
| .NET 10.0  | Windows  |
| .NET 10.0  | Linux    |

All integration test scenarios are expected to produce identical results on all supported runtime
and platform combinations.

## External Interface Simulation

<!-- TODO: Fill in for your project -->

At the system level, no interfaces are mocked. All external interfaces are exercised with real
implementations:

- **Standard output / standard error** — Captured by `Runner.Run` and returned as strings for
  assertion.
- **File system** — Temporary files and directories are created and cleaned up within each test.
  The `--results` and `--log` flags are exercised with real file paths under a temporary folder.
- **Process exit code** — Returned by `Runner.Run` and asserted directly.

## Integration Test Scenarios

<!-- TODO: Fill in for your project -->

The following integration test scenarios are defined in `IntegrationTests.cs`.

### IntegrationTest_VersionFlag_OutputsVersion

**Scenario**: The `--version` flag is passed as the sole argument.

**Expected**: Exit code 0; standard output contains the tool version string; standard error is
empty.

### IntegrationTest_HelpFlag_OutputsUsageInformation

**Scenario**: The `--help` flag is passed as the sole argument.

**Expected**: Exit code 0; standard output contains the text "Usage" and "Options"; standard error
is empty.

### IntegrationTest_ValidateFlag_RunsValidation

**Scenario**: The `--validate` flag is passed as the sole argument.

**Expected**: Exit code 0; standard output contains a validation summary (the text "Total Tests:"
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

**Scenario**: The `--silent` flag is passed without any action flag.

**Expected**: Exit code 0; standard output is empty; standard error is empty.

### IntegrationTest_LogFlag_WritesOutputToFile

**Scenario**: The `--log <path>` flag is passed pointing to a temporary file.

**Expected**: Exit code 0; the specified log file is created and contains output that also appears
on standard output.

### IntegrationTest_UnknownArgument_ReturnsError

**Scenario**: An unrecognized argument (e.g., `--unknown`) is passed.

**Expected**: Exit code non-zero; standard error contains an error message indicating the
unrecognized argument; standard output does not contain normal usage text.

## Requirements Coverage

<!-- TODO: Fill in for your project -->

The table below maps each system-level requirement category to the integration test scenarios that
verify it.

| Requirement Category       | Test Scenarios                                         |
|----------------------------|--------------------------------------------------------|
| Version display            | IntegrationTest_VersionFlag_OutputsVersion             |
| Help display               | IntegrationTest_HelpFlag_OutputsUsageInformation       |
| Self-validation            | IntegrationTest_ValidateFlag_RunsValidation            |
| TRX results output         | IntegrationTest_ValidateWithResults_GeneratesTrxFile   |
| JUnit results output       | IntegrationTest_ValidateWithResults_GeneratesJUnitFile |
| Silent mode                | IntegrationTest_SilentFlag_SuppressesOutput            |
| Log file output            | IntegrationTest_LogFlag_WritesOutputToFile             |
| Invalid argument rejection | IntegrationTest_UnknownArgument_ReturnsError           |
