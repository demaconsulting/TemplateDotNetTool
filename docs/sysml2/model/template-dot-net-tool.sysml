package TemplateDotNetTool {
    public import TemplateDotNetTool_Program::*;
    public import TemplateDotNetTool_CliSubsystem::*;
    public import TemplateDotNetTool_SelfTestSubsystem::*;
    public import TemplateDotNetTool_UtilitiesSubsystem::*;
    private import SoftwareItemMetadata::*;
    private import OtsDependencies::*;

    doc
    /*
     * TemplateDotNetTool is a template .NET command-line application demonstrating
     * DemaConsulting's compliance/documentation tooling conventions.
     */

    part def TemplateDotNetToolSystem {
        doc /* The TemplateDotNetTool system as a whole. */

        metadata info : SoftwareInfo {
            testFiles = ("test/DemaConsulting.TemplateDotNetTool.Tests/IntegrationTests.cs");
            designFiles = ("docs/design/template-dot-net-tool.md");
            verificationFiles = ("docs/verification/template-dot-net-tool.md");
            requirementFiles = ("docs/reqstream/template-dot-net-tool.yaml");
        }

        part program : Program;
        part cli : CliSubsystem;
        part selfTest : SelfTestSubsystem;
        part utilities : UtilitiesSubsystem;
        part helpCards : HelpCards;
    }
}
