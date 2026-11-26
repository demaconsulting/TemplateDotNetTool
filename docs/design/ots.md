# OTS Software Integration Design

This document provides the integration and usage design for all Off-The-Shelf (OTS) software
items used by the Template DotNet Tool.

## Scope

OTS items are third-party libraries and tools consumed by the project. This document covers the
integration pattern and usage design for each item. The internal design of OTS items is out of
scope; only how this project integrates and uses each item is documented.

## Runtime OTS Items

Runtime OTS items are linked into the tool and ship with it. They are parts of the system in
`docs/sysml2/model/ots.sysml`, and each unit that uses one declares a dependency on it:

- HelpCards (*help-cards.md*) — built-in help library, used by `HelpCommand`

## OTS Tools

OTS tools build, test, and document the tool but never ship. They are parts of the `Toolchain` in
`docs/sysml2/model/tools.sysml`, and their design documents are in `ots/tools/`:

![OTS Tools](ToolchainView.svg)

- BuildMark (*buildmark.md*) — build-notes documentation tool
- FileAssert (*fileassert.md*) — document assertion tool
- Pandoc (*pandoc.md*) — Markdown-to-HTML conversion tool
- ReqStream (*reqstream.md*) — requirements traceability tool
- ReviewMark (*reviewmark.md*) — file review enforcement tool
- SarifMark (*sarifmark.md*) — SARIF report conversion tool
- SonarMark (*sonarmark.md*) — SonarCloud quality report tool
- SysML2Tools (*sysml2tools.md*) — architecture model validation and diagram rendering tool
- VersionMark (*versionmark.md*) — tool-version documentation tool
- WeasyPrint (*weasyprint.md*) — HTML-to-PDF conversion tool
- xUnit (*xunit.md*) — unit-testing framework

## References

N/A
