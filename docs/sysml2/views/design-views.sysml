// Views rendered into docs/design/generated/ for the Design document.
// Per SysML2Tools syntax, 'expose' is only valid inside a named 'view' usage
// (not a 'view def' definition), and it - not 'render' - is what scopes the
// rendered diagram content.
package TemplateDotNetToolDesignViews {
    private import StandardViewDefinitions::*;
    private import TemplateDotNetTool::*;

    view SoftwareStructureView : InterconnectionView {
        expose TemplateDotNetTool::TemplateDotNetToolSystem;
    }

    view TemplateDotNetToolView {
        expose TemplateDotNetToolSystem;
    }

    view CliView {
        expose CliSubsystem;
    }

    view SelfTestView {
        expose SelfTestSubsystem;
    }

    view UtilitiesView {
        expose UtilitiesSubsystem;
    }

    view ToolchainView : InterconnectionView {
        expose OtsTools::Toolchain;
        filter not (@SysML::Documentation);
    }
}
