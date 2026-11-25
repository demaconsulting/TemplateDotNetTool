package TemplateDotNetTool_HelpCommand {
    private import SoftwareItemMetadata::*;

    part def HelpCommand {
        doc /* Built-in help command: answers the help verb from embedded help cards before option parsing. */

        metadata info : SoftwareInfo {
            sourceFiles = ("src/DemaConsulting.TemplateDotNetTool/Cli/HelpCommand.cs");
            testFiles = ("test/DemaConsulting.TemplateDotNetTool.Tests/Cli/HelpCommandTests.cs");
            designFiles = ("docs/design/template-dot-net-tool/cli/help-command.md");
            verificationFiles = ("docs/verification/template-dot-net-tool/cli/help-command.md");
            requirementFiles = ("docs/reqstream/template-dot-net-tool/cli/help-command.yaml");
        }
    }
}
