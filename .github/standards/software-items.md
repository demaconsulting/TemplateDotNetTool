---
name: Software Items
description: Follow these standards when categorizing software components.
---

# Software Item Categories

Categorize all software into six primary groups:

- **Software Package**: Distributable unit delivered to end users or dependent
  systems, containing one software system with all its components. All software
  systems are delivered as a software package. When consumed by a system outside
  the producing program, our software package is treated as an OTS Software Item
  by that system. When consumed by another repository within the same program,
  it is treated as a Shared Package.
- **Software System**: Complete deliverable product including all components
  and external interfaces, contained within a software package
- **Software Subsystem**: Major architectural component with well-defined
  interfaces and responsibilities
- **Software Unit**: Individual class, function, or tightly coupled set of
  functions that can be tested in isolation
- **OTS Software Item**: Third-party software not developed within the program - either a
  **Runtime OTS** item (shipped with the product) or an **OTS tool** (never ships)
- **Shared Package**: A software package produced by a different repository within
  the same program, consumed as a dependency. Referenced by its advertised features
  rather than internal design; traceability to program-level requirements runs
  through the top-level project.

**Naming**: When names collide in hierarchy, add descriptive suffix to higher-level entity:

- Package: Package (e.g. TestResults → TestResultsPackage)
- System: Application/Library/System (e.g. TestResults → TestResultsLibrary)
- Subsystem: Subsystem (e.g. Linter → LinterSubsystem)

# Naming Conventions in File Path Patterns

Three placeholder forms appear in path patterns across these standards:

- **Kebab-case** (`{system-name}`, `{unit-name}`): always kebab-case —
  documentation and requirements file paths
- **PascalCase IDs** (`{SystemName}`, `{UnitName}`): always PascalCase —
  requirements IDs, ReviewMark IDs, and other documentation identifiers
- **Language-cased** (`{SystemName}` or `{system_name}`): follow your language's
  convention — `PascalCase` for C#/Java, `snake_case` for C++/Python —
  source and test file/folder names

## Nesting Depth Notation

Subsystems nest to any depth. Patterns use bracket-ellipsis to express this without
enumerating levels — `[/{subsystem-name}...]` in paths, `[-{SubsystemName}...]` in
dash-separated IDs. Examples covering all three forms:

- `{SystemName}[-{SubsystemName}...]-{UnitName}-Feature` (PascalCase ID)
- `docs/design/{system-name}[/{subsystem-name}...]/{unit-name}.md` (kebab-case doc path)
- `src/{SystemName}[/{SubsystemName}...]/{UnitName}.cs` (C# source path)
- `src/{system_name}[/{subsystem_name}...]/{unit_name}.cpp` (C++/Python source path)

# Categorization Guidelines

## Software Package

- Represents one distributable artifact
  (e.g., NuGet package, npm package, Docker image, installer)
- Contains exactly one software system with its subsystems and units
- Tested through package-level acceptance and integration tests

## Software System

- Represents the entire product boundary
- Tested through system integration and end-to-end tests

## Software Subsystem

- Major architectural boundary (authentication, data layer, UI, communications)
- Contains software units and optionally child subsystems
- Subsystems may nest when a component has distinct internal boundaries
- Typically maps to project folders or namespaces
- Tested through subsystem integration tests

## Software Unit

- Smallest independently testable component
- Typically a single class or cohesive set of functions
- Methods within a class are NOT separate units
- Tested through unit tests with mocked dependencies

## OTS Software Item

- External dependency from outside the program; repo-level (not per-system). A package
  produced by an unrelated program (inside or outside the organization) is OTS to its consumer
- OTS items have no internal design documentation; their artifact folders sit parallel to
  system folders (not inside any system folder)
- **Runtime OTS**: linked in and shipped with the product (e.g. NuGet libraries)
  - Verified by integration tests proving the functionality used (unless vendor evidence such as
    published compliance reports suffices), one test file per item in a fixed repo-level project:
    `test/OtsSoftwareTests/` (C#) or `test/ots_software_tests/` (Python/other) — never prefixed
    with a system or project name
  - Artifacts: `docs/reqstream/ots/{ots-name}.yaml`, `docs/design/ots/{ots-name}.md`
    (integration/usage design), `docs/verification/ots/{ots-name}.md`
  - System design documentation records which runtime OTS items each system depends on
- **OTS tool**: build, test, documentation, or compliance tooling that never ships (e.g.
  ReqStream, ReviewMark, SysML2Tools, TextLint, Pandoc)
  - Verified by evidence produced in CI: the tool's self-validation results (e.g. `--validate --results`),
    or for a test framework (e.g. xUnit) the test run itself; not by tests written for the tool
  - Artifacts: `docs/reqstream/ots/tools/{tool-name}.yaml`, `docs/design/ots/tools/{tool-name}.md`
    (optional), `docs/verification/ots/tools/{tool-name}.md`

## Shared Package

- A software package produced by a different repository within the same program
- The consuming repository references advertised features, not internal design or source
- Traceability to program-level requirements runs through the top-level project,
  not directly between repositories
- Verified through any appropriate approach in the consuming repository - most commonly
  downstream integration tests that transitively prove the advertised features are functional
- **Artifact locations** (no internal design documentation in the consuming repository):
  - Requirements: `docs/reqstream/shared/{package-name}.yaml`
  - Design: `docs/design/shared/{package-name}.md` (integration/usage design)
  - Verification: `docs/verification/shared/{package-name}.md`
  - These folders sit parallel to system and OTS folders

# Software Item Artifact Model

Each software item has five artifact types that together form a complete review
unit - because reviewing any one artifact in isolation cannot determine whether
the item is correct, well-designed, and proven to work:

- **Requirements** - WHAT the item must do (drives all other artifacts; applies to all item types)
- **Design** - HOW the item satisfies its requirements (full design for local items: system,
  subsystem, unit; integration/usage design for OTS and Shared Package)
- **Verification Design** - HOW the requirements will be tested (applies to all item types)
- **Source code** - The implementation of the design (local units only; not applicable to OTS or Shared Package)
- **Tests** - PROOF the item does WHAT it is required to do (applies to all item types)

Where the repository models its software structure in SysML2, each item's part def carries a
`metadata info : SoftwareInfo` annotation whose attributes (`sourceFiles`/`testFiles`/
`designFiles`/`verificationFiles`/`requirementFiles`) point at these same artifact locations
so agents can query them directly — see `sysml2-modeling.md`.
