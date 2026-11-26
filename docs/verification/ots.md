# OTS Software Verification

This section provides verification evidence for all Off-The-Shelf (OTS) software items
used by the Template DotNet Tool.

## Scope

Each OTS item is verified according to its category:

- **Runtime OTS items** ship with the tool and are verified by its integration tests
- **OTS tools** never ship and are verified by the evidence they produce in CI: their own
  self-validation suite (where the tool supports `--validate`), FileAssert assertions on the
  documents they produce, or the test results they report

Internal OTS design is out of scope; only integration and usage evidence is documented.

## Runtime OTS Items

- HelpCards (*help-cards.md*) — built-in help library

## OTS Tools

The verification evidence of the OTS tools is in `ots/tools/`:

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
