# SelfTest Subsystem Verification

<!-- TODO: Fill in for your project -->

This document describes the subsystem-level verification design for the `SelfTest` subsystem. It
defines the integration test approach, subsystem boundary, mocking strategy, and test scenarios
that together verify the `SelfTest` subsystem requirements.

## Verification Approach

<!-- TODO: Fill in for your project -->

The `SelfTest` subsystem is verified by integration tests defined in `SelfTestSubsystemTests.cs`.
Each test exercises the `Validation.Run` method with a real `Context` to confirm that the
subsystem produces correct output and result files across the supported result-format options.

## Dependencies and Mocking Strategy

<!-- TODO: Fill in for your project -->

At the subsystem boundary, `Context` (from the `Cli` subsystem) and `PathHelpers` (from the
`Utilities` subsystem) are both used with their real implementations. No mocking is applied.
Temporary directories are used for result file output so that tests remain isolated and
leave no permanent file-system side-effects.

## Integration Test Scenarios

<!-- TODO: Fill in for your project -->

The following integration test scenarios are defined in `SelfTestSubsystemTests.cs`.

### SelfTestSubsystem_ValidationWorkflow_NoResultFiles_CompletesSuccessfully

**Scenario**: `Validation.Run` is called with a context that does not specify any results file.

**Expected**: Validation completes without error; exit code is 0; the summary text appears in
the output.

### SelfTestSubsystem_ValidationWorkflow_WithTrxFile_GeneratesResults

**Scenario**: `Validation.Run` is called with a context whose `ResultsFile` points to a temporary
`.trx` path.

**Expected**: A TRX file is created at the specified path; the file contains the `<TestRun`
XML element confirming a valid TRX structure; exit code is 0.

### SelfTestSubsystem_ValidationWorkflow_WithJUnitFile_GeneratesResults

**Scenario**: `Validation.Run` is called with a context whose `ResultsFile` points to a temporary
`.xml` path.

**Expected**: A JUnit XML file is created at the specified path; the file contains the
`<testsuites` XML element confirming a valid JUnit structure; exit code is 0.

### SelfTestSubsystem_ValidationWorkflow_WithBothResultFiles_GeneratesBothResults

**Scenario**: Two separate `Validation.Run` calls are made, one targeting a `.trx` path and one
targeting a `.xml` path.

**Expected**: Both files are created; each file contains the correct root XML element for its
format; exit code is 0 for each run.

## Requirements Coverage

<!-- TODO: Fill in for your project -->

| Requirement                     | Test Scenario                                                                 |
|---------------------------------|-------------------------------------------------------------------------------|
| Self-validation without results | SelfTestSubsystem_ValidationWorkflow_NoResultFiles_CompletesSuccessfully      |
| TRX results file generation     | SelfTestSubsystem_ValidationWorkflow_WithTrxFile_GeneratesResults             |
| JUnit results file generation   | SelfTestSubsystem_ValidationWorkflow_WithJUnitFile_GeneratesResults           |
| Both result formats generation  | SelfTestSubsystem_ValidationWorkflow_WithBothResultFiles_GeneratesBothResults |
