package TemplateDotNetTool_HelpCommand {
    private import SoftwareItemMetadata::*;
    private import OtsDependencies::*;

    part def HelpCommand {
        doc /* Built-in help command: answers the help verb from the help cards embedded in the assembly. */

        metadata info : SoftwareInfo {
            sourceFiles = ("src/DemaConsulting.TemplateDotNetTool/Cli/HelpCommand.cs");
            testFiles = ("test/DemaConsulting.TemplateDotNetTool.Tests/Cli/HelpCommandTests.cs");
            designFiles = ("docs/design/template-dot-net-tool/cli/help-command.md");
            verificationFiles = ("docs/verification/template-dot-net-tool/cli/help-command.md");
            requirementFiles = ("docs/reqstream/template-dot-net-tool/cli/help-command.yaml");
        }
    }

    // Serves the help command from the cards embedded in the assembly
    dependency HelpCommand to HelpCards;
}
