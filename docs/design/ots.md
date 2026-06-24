# OTS Software Integration Design

This document provides the integration and usage design for all Off-The-Shelf (OTS) software
items used by the Template DotNet Tool.

## Scope

OTS items are third-party tools and libraries consumed by the project. This document covers the
integration pattern and usage design for each item. The internal design of OTS items is out of
scope; only how this project integrates and uses each item is documented.

## OTS Items

The following OTS items have integration design documentation:

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

## References

N/A
