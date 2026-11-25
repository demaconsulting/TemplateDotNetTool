## HelpCards Verification

This document provides the verification evidence for the HelpCards OTS software item.
Requirements for this OTS item are defined in the HelpCards OTS Software Requirements document.

### Required Functionality

HelpCards (`Template-OTS-HelpCards-Cli`, `Template-OTS-HelpCards-Catalog`,
`Template-OTS-HelpCards-Validator`, `Template-OTS-HelpCards-ExampleRunner`, and
`Template-OTS-HelpCards-Embedding`) shall answer a help command from a catalog of Markdown help
cards, build that catalog only after the help verb is recognized, support search and JSON output,
report defects in cards and command examples to tests, run every command example through a test
delegate and compare the exit code and output that the example states, and embed the card folder
in the tool assembly. HelpCards is the library that serves `templatetool help` to people and AI
agents.

### Verification Approach

HelpCards is a runtime library with no self-validation mode, so it is verified by integration
test evidence. The `HelpCommand` unit tests drive the command-line helper of the package with the
cards embedded in the tool assembly, and check the answers, the exit codes, and the deferred
creation of the catalog; the same tests run the validator of the package against the shipped
cards. The system tests run the built tool to confirm that the same behavior holds in a separate
process and that every command example of every card gives its stated result.

### Test Scenarios

**Command Answers**: Verifies that the helper prints the topic index, a card with its examples,
and a usage error with exit code 2 for an unknown topic, and that arguments other than the help
verb are not answered and never build the catalog. This scenario is tested by
`HelpCommand_TryRun_HelpVerb_PrintsTopicIndexAndReturnsZero`,
`HelpCommand_TryRun_CardPath_PrintsCardWithExamples`, `HelpCommand_TryRun_UnknownTopic_ReturnsTwo`,
and `HelpCommand_TryRun_NonHelpArguments_ReturnsFalseWithoutBuildingCatalog`.

**Catalog, Search, and JSON**: Verifies that the catalog loads the cards, lists the cards that
match a search, and writes a versioned JSON document. This scenario is tested by
`HelpCommand_TryRun_SearchOption_ListsMatchingCards` and
`HelpCommand_TryRun_JsonOption_WritesJsonDocument`.

**Validation**: Verifies that the validator accepts the shipped cards with warnings treated as
errors, including the expected topics, the purpose tags, and the command lines of the examples.
This scenario is tested by `HelpCommand_CreateOptions_ShippedCatalog_PassesValidation`.

**Example Runner**: Verifies that the runner saves the source examples of every card to a scratch
folder, runs every command example through the test's delegate against the built tool, and
compares the exit code (`exit`) and the output fragment (`expect`) that each example states. This
scenario is tested by `TemplateDotNetTool_HelpExamples_AllCommandExamples_GiveStatedResults`.

**Embedding**: Verifies that the cards embedded in the assembly by the package build targets are
complete and usable. The test output holds no card files, so a validated catalog, a printed card,
and every command example running against the built tool prove that the embedded copy is
complete. This scenario is tested by `HelpCommand_CreateOptions_ShippedCatalog_PassesValidation`,
`HelpCommand_TryRun_CardPath_PrintsCardWithExamples`, and
`TemplateDotNetTool_HelpExamples_AllCommandExamples_GiveStatedResults`.
