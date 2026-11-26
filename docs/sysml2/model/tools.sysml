package OtsTools {
    private import SoftwareItemMetadata::*;

    doc /* Off-the-shelf (OTS) tools that build, test, and document TemplateDotNetTool; none of them ships. */

    part def Toolchain {
        doc /* The build, test, documentation, and compliance tools of the repository. */

        part buildMark : BuildMark;
        part fileAssert : FileAssert;
        part pandoc : Pandoc;
        part reqStream : ReqStream;
        part reviewMark : ReviewMark;
        part sarifMark : SarifMark;
        part sonarMark : SonarMark;
        part sysml2Tools : SysML2Tools;
        part versionMark : VersionMark;
        part weasyPrint : WeasyPrint;
        part xunit : xUnit;
    }

    part def BuildMark {
        doc /* OTS tool: DemaConsulting.BuildMark, build-notes documentation tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/buildmark.md");
            verificationFiles = ("docs/verification/ots/tools/buildmark.md");
            requirementFiles = ("docs/reqstream/ots/tools/buildmark.yaml");
        }
    }

    part def FileAssert {
        doc /* OTS tool: DemaConsulting.FileAssert, document assertion tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/fileassert.md");
            verificationFiles = ("docs/verification/ots/tools/fileassert.md");
            requirementFiles = ("docs/reqstream/ots/tools/fileassert.yaml");
        }
    }

    part def Pandoc {
        doc /* OTS tool: DemaConsulting.PandocTool, Markdown-to-HTML conversion tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/pandoc.md");
            verificationFiles = ("docs/verification/ots/tools/pandoc.md");
            requirementFiles = ("docs/reqstream/ots/tools/pandoc.yaml");
        }
    }

    part def ReqStream {
        doc /* OTS tool: DemaConsulting.ReqStream, requirements traceability tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/reqstream.md");
            verificationFiles = ("docs/verification/ots/tools/reqstream.md");
            requirementFiles = ("docs/reqstream/ots/tools/reqstream.yaml");
        }
    }

    part def ReviewMark {
        doc /* OTS tool: DemaConsulting.ReviewMark, file review enforcement tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/reviewmark.md");
            verificationFiles = ("docs/verification/ots/tools/reviewmark.md");
            requirementFiles = ("docs/reqstream/ots/tools/reviewmark.yaml");
        }
    }

    part def SarifMark {
        doc /* OTS tool: DemaConsulting.SarifMark, SARIF report conversion tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/sarifmark.md");
            verificationFiles = ("docs/verification/ots/tools/sarifmark.md");
            requirementFiles = ("docs/reqstream/ots/tools/sarifmark.yaml");
        }
    }

    part def SonarMark {
        doc /* OTS tool: DemaConsulting.SonarMark, SonarCloud quality report tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/sonarmark.md");
            verificationFiles = ("docs/verification/ots/tools/sonarmark.md");
            requirementFiles = ("docs/reqstream/ots/tools/sonarmark.yaml");
        }
    }

    part def SysML2Tools {
        doc /* OTS tool: DemaConsulting.SysML2Tools.Tool, architecture model validation and diagram rendering tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/sysml2tools.md");
            verificationFiles = ("docs/verification/ots/tools/sysml2tools.md");
            requirementFiles = ("docs/reqstream/ots/tools/sysml2tools.yaml");
        }
    }

    part def VersionMark {
        doc /* OTS tool: DemaConsulting.VersionMark, tool-version documentation tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/versionmark.md");
            verificationFiles = ("docs/verification/ots/tools/versionmark.md");
            requirementFiles = ("docs/reqstream/ots/tools/versionmark.yaml");
        }
    }

    part def WeasyPrint {
        doc /* OTS tool: DemaConsulting.WeasyPrintTool, HTML-to-PDF conversion tool. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/weasyprint.md");
            verificationFiles = ("docs/verification/ots/tools/weasyprint.md");
            requirementFiles = ("docs/reqstream/ots/tools/weasyprint.yaml");
        }
    }

    part def xUnit {
        doc /* OTS tool: xunit.v3 and xunit.runner.visualstudio, unit-testing framework. */

        metadata info : SoftwareInfo {
            designFiles = ("docs/design/ots/tools/xunit.md");
            verificationFiles = ("docs/verification/ots/tools/xunit.md");
            requirementFiles = ("docs/reqstream/ots/tools/xunit.yaml");
        }
    }
}
