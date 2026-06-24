## OTS Software Verification

This section provides verification evidence for all Off-The-Shelf (OTS) software items
used by the Template DotNet Tool.

### Scope

Each OTS item is verified by a combination of:

- The OTS tool's own self-validation suite (where the tool supports `--validate`)
- Pipeline output assertions performed by FileAssert on documents produced by the tool

Internal OTS tool design is out of scope; only integration and usage evidence is documented.

### OTS Items

The following OTS items have verification evidence in this section:

- [BuildMark](ots/buildmark.md) — build-notes documentation tool
- [FileAssert](ots/fileassert.md) — document assertion tool
- [Pandoc](ots/pandoc.md) — Markdown-to-HTML conversion tool
- [ReqStream](ots/reqstream.md) — requirements traceability tool
- [ReviewMark](ots/reviewmark.md) — file review enforcement tool
- [SarifMark](ots/sarifmark.md) — SARIF report conversion tool
- [SonarMark](ots/sonarmark.md) — SonarCloud quality report tool
- [VersionMark](ots/versionmark.md) — tool-version documentation tool
- [WeasyPrint](ots/weasyprint.md) — HTML-to-PDF conversion tool
- [xUnit](ots/xunit.md) — unit-testing framework

### References

N/A
