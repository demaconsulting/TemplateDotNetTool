# PathHelpers

The `PathHelpers` class provides safe path-combination utilities for the Template DotNet Tool.
It protects against path-traversal attacks by validating relative path segments before combining
them with a base path.

## Overview

`PathHelpers` is a static utility class with a single method, `SafePathCombine`. It is used
wherever the tool constructs a file path from a base directory and a caller-supplied relative
segment, ensuring the resulting path cannot escape the intended base directory.

## Data Model

`PathHelpers` has no instance state or instance methods.

## Methods

### SafePathCombine(string basePath, string relativePath)

Combines `basePath` and `relativePath` safely:

1. Validates that neither argument is `null`.
2. Rejects `relativePath` values that contain `".."` or are rooted (absolute).
3. Calls `Path.Combine` to produce the candidate path.
4. Resolves both `basePath` and the candidate to full paths and calls `Path.GetRelativePath`
   to confirm the result remains inside `basePath`.

**Throws:** `ArgumentException` — when `relativePath` contains `".."`, is an absolute path, or
the resolved combined path escapes `basePath`.

**Returns:** `string` — the combined path.

## Interactions

`PathHelpers` has no dependencies on other tool units. It uses only .NET base class library types
(`Path`, `ArgumentNullException`).
