package TemplateDotNetTool_CliSubsystem {
    public import TemplateDotNetTool_Context::*;
    public import TemplateDotNetTool_HelpCommand::*;
    private import SoftwareItemMetadata::*;

    part def CliSubsystem {
        doc /* Command-line argument parsing, output-channel management, exit-code tracking, and the built-in help command. */

        metadata info : SoftwareInfo {
            testFiles = ("test/DemaConsulting.TemplateDotNetTool.Tests/Cli/CliSubsystemTests.cs");
            designFiles = ("docs/design/template-dot-net-tool/cli.md");
            verificationFiles = ("docs/verification/template-dot-net-tool/cli.md");
            requirementFiles = ("docs/reqstream/template-dot-net-tool/cli.yaml");
        }

        part context : Context;
        part helpCommand : HelpCommand;
    }
}
