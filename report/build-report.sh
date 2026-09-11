#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_MD="${ROOT_DIR}/report/mall_expert_report.md"
EXPANDED_MD="${ROOT_DIR}/report/README_REPORT.md"
HTML_FILE="${ROOT_DIR}/report/mall_expert_report.html"
PDF_FILE="${ROOT_DIR}/report/mall_expert_report.pdf"
LEGACY_HTML="${ROOT_DIR}/report/README_REPORT.html"
LEGACY_PDF="${ROOT_DIR}/report/README_REPORT.pdf"

ruby - "$ROOT_DIR" "$SOURCE_MD" "$EXPANDED_MD" <<'RUBY'
root, source, output = ARGV
text = File.read(source)
expanded = text.gsub(/\{\{include:([^}]+)\}\}/) do
  relative = Regexp.last_match(1).strip
  File.read(File.join(root, relative))
end
File.write(output, expanded)
RUBY

tmp_body="$(mktemp)"
trap 'rm -f "$tmp_body"' EXIT

npx --yes marked "$EXPANDED_MD" --gfm > "$tmp_body"

ruby - "$HTML_FILE" "$tmp_body" <<'RUBY'
html_file, body_file = ARGV
body = File.read(body_file)
style = <<~CSS
  @page { margin: 15mm 13mm; size: A4; }
  * { box-sizing: border-box; }
  body {
    font-family: Georgia, "Times New Roman", serif;
    font-size: 10.4pt;
    line-height: 1.32;
    color: #111827;
    background: #ffffff;
  }
  h1, h2, h3, h4 { font-family: Georgia, "Times New Roman", serif; color: #111827; page-break-after: avoid; }
  h1 { font-size: 21pt; margin: 0 0 9pt; text-align: center; }
  h2 { font-size: 15.5pt; margin: 14pt 0 7pt; }
  h3 { font-size: 12.5pt; margin: 10pt 0 6pt; }
  h4 { font-size: 11pt; margin: 8pt 0 5pt; }
  p { margin: 0 0 6pt; text-align: justify; }
  ul, ol { margin: 0 0 6pt 18pt; padding: 0; }
  li { margin: 2pt 0; text-align: justify; }
  table { width: 100%; border-collapse: collapse; margin: 8pt 0 10pt; page-break-inside: avoid; }
  th, td { border: 1px solid #9ca3af; padding: 4pt 5pt; vertical-align: top; font-size: 8.7pt; line-height: 1.18; }
  th { background: #f3f4f6; font-weight: 700; }
  code { font-family: Menlo, Consolas, monospace; font-size: 8pt; }
  pre {
    background: #f6f8fa;
    border: 1px solid #d0d7de;
    border-radius: 5pt;
    padding: 5pt;
    margin: 6pt 0 8pt;
    white-space: pre-wrap;
    page-break-inside: auto;
  }
  pre code { font-size: 6.4pt; line-height: 1.16; }
  img { display: block; max-width: 100%; height: auto; border: 1px solid #d1d5db; }
  figure { margin: 8pt 0 13pt; page-break-inside: avoid; }
  figcaption { margin-top: 3pt; text-align: center; font-size: 8.8pt; color: #374151; }
  .title-page { height: 700pt; display: flex; flex-direction: column; justify-content: space-between; text-align: center; }
  .title-page p { text-align: center; }
  .assignment p { text-align: left; }
  .signature { margin-top: 18pt; display: grid; grid-template-columns: 1fr 1fr; gap: 24pt; }
  .signature p { text-align: left; }
  .page-break { page-break-before: always; break-before: page; }
  .center { text-align: center; }
  .right { text-align: right; }
  .small { font-size: 8.8pt; }
  .no-break { page-break-inside: avoid; }
  @media print { a[href]::after { content: none; } }
CSS

File.write(html_file, <<~HTML)
  <!doctype html>
  <html lang="ru">
  <head>
    <meta charset="utf-8">
    <title>MallExpert SPb - курсовой проект</title>
    <style>#{style}</style>
  </head>
  <body>
  #{body}
  </body>
  </html>
HTML
RUBY

npx --yes playwright pdf --wait-for-timeout=1200 --paper-format=A4 "file://${HTML_FILE}" "$PDF_FILE"
cp "$HTML_FILE" "$LEGACY_HTML"
cp "$PDF_FILE" "$LEGACY_PDF"

echo "PDF saved: $PDF_FILE"
echo "Compatibility copy: $LEGACY_PDF"
