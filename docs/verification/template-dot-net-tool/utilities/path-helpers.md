# PathHelpers Verification

<!-- TODO: Fill in for your project -->

This document describes the unit-level verification design for the `PathHelpers` unit. It defines
the test scenarios, dependency usage, and requirement coverage for `Utilities/PathHelpers.cs`.

## Verification Approach

<!-- TODO: Fill in for your project -->

`PathHelpers` is verified with unit tests defined in `PathHelpersTests.cs`. Because `PathHelpers`
performs pure path manipulation using only .NET BCL types, no mocking or test doubles are needed.
Tests call `PathHelpers.SafePathCombine` directly with controlled base and relative path arguments
and assert on the returned string or the thrown exception.

## Dependencies

<!-- TODO: Fill in for your project -->

`PathHelpers` has no dependencies on other tool units. All path operations use .NET BCL types
(`Path`, `string`); no mocking is needed at this level.

## Test Scenarios

<!-- TODO: Fill in for your project -->

### PathHelpers_SafePathCombine_ValidPaths_CombinesCorrectly

**Scenario**: A relative path (e.g., `"subfolder/file.txt"`) is combined with a base path.

**Expected**: The returned path equals the expected combined result; no exception is thrown.

**Requirement coverage**: Valid path combination requirement.

### PathHelpers_SafePathCombine_PathTraversalWithDoubleDots_ThrowsArgumentException

**Scenario**: A relative path starting with `"../"` is passed to `SafePathCombine`.

**Expected**: An `ArgumentException` is thrown containing the text "Invalid path component".

**Boundary / error path**: Directory traversal attempt via leading `../`.

**Requirement coverage**: Path traversal rejection requirement.

### PathHelpers_SafePathCombine_DoubleDotsInMiddle_ThrowsArgumentException

**Scenario**: A relative path containing `"subfolder/../../../"` is passed to `SafePathCombine`.

**Expected**: An `ArgumentException` is thrown.

**Boundary / error path**: Directory traversal attempt via embedded `../` sequence.

**Requirement coverage**: Path traversal rejection requirement (embedded traversal).

### PathHelpers_SafePathCombine_AbsolutePath_ThrowsArgumentException

**Scenario**: An absolute path (Unix-style `/etc/passwd` or Windows-style `C:\Windows`) is passed
as the relative argument to `SafePathCombine`.

**Expected**: An `ArgumentException` is thrown.

**Boundary / error path**: Absolute path used where a relative path is required.

**Requirement coverage**: Absolute path rejection requirement.

### PathHelpers_SafePathCombine_CurrentDirectoryReference_CombinesCorrectly

**Scenario**: A relative path starting with `"./"` (e.g., `"./subfolder/file.txt"`) is combined
with a base path.

**Expected**: The returned path equals the expected combined result; no exception is thrown.

**Requirement coverage**: Current-directory-prefixed path requirement.

### PathHelpers_SafePathCombine_NestedPaths_CombinesCorrectly

**Scenario**: A deeply nested relative path (e.g., `"a/b/c/d/file.txt"`) is combined with a base
path.

**Expected**: The returned path equals the expected combined result; no exception is thrown.

**Requirement coverage**: Nested path combination requirement.

### PathHelpers_SafePathCombine_EmptyRelativePath_ReturnsBasePath

**Scenario**: An empty string is passed as the relative path argument.

**Expected**: The returned path equals the base path; no exception is thrown.

**Boundary / error path**: Empty relative path edge case.

**Requirement coverage**: Empty relative path handling requirement.

### PathHelpers_SafePathCombine_DotDotPrefixedName_CombinesCorrectly

**Scenario**: A relative path whose filename starts with `".."` but is not a traversal sequence
(e.g., `"..data/file.txt"`) is combined with a base path.

**Expected**: The returned path equals the expected combined result; no exception is thrown.

**Boundary / error path**: Filename beginning with `".."` must not be misidentified as a traversal.

**Requirement coverage**: Non-traversal dot-dot-prefixed name requirement.

## Requirements Coverage

<!-- TODO: Fill in for your project -->

| Requirement                       | Test Scenario                                                                    |
|-----------------------------------|----------------------------------------------------------------------------------|
| Valid relative path combination   | PathHelpers_SafePathCombine_ValidPaths_CombinesCorrectly                         |
| Leading traversal rejection       | PathHelpers_SafePathCombine_PathTraversalWithDoubleDots_ThrowsArgumentException  |
| Embedded traversal rejection      | PathHelpers_SafePathCombine_DoubleDotsInMiddle_ThrowsArgumentException           |
| Absolute path rejection           | PathHelpers_SafePathCombine_AbsolutePath_ThrowsArgumentException                 |
| Current-directory prefix handling | PathHelpers_SafePathCombine_CurrentDirectoryReference_CombinesCorrectly          |
| Nested path combination           | PathHelpers_SafePathCombine_NestedPaths_CombinesCorrectly                        |
| Empty relative path handling      | PathHelpers_SafePathCombine_EmptyRelativePath_ReturnsBasePath                    |
| Dot-dot filename (not traversal)  | PathHelpers_SafePathCombine_DotDotPrefixedName_CombinesCorrectly                 |
