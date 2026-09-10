#!/usr/bin/env bash
set -euo pipefail

site_root="${1:-_site}"

required_files=(
  "index.html"
  "projects/index.html"
  "publications/index.html"
  "talks/index.html"
  "students/index.html"
  "sitemap.xml"
  "CNAME"
  "assets/css/main.css"
  "assets/js/main.min.js"
)

for relative_path in "${required_files[@]}"; do
  if [[ ! -s "${site_root}/${relative_path}" ]]; then
    echo "Missing or empty generated file: ${relative_path}" >&2
    exit 1
  fi
done

if [[ "$(tr -d '\r\n' < "${site_root}/CNAME")" != "www.ml4phys.com" ]]; then
  echo "Unexpected generated CNAME value" >&2
  exit 1
fi

html_files=(
  "index.html"
  "projects/index.html"
  "publications/index.html"
  "talks/index.html"
  "students/index.html"
)

for relative_path in "${html_files[@]}"; do
  if grep -Fq '{{' "${site_root}/${relative_path}" || grep -Fq '{%' "${site_root}/${relative_path}"; then
    echo "Unrendered Liquid found in: ${relative_path}" >&2
    exit 1
  fi
done

html_count="$(find "${site_root}" -type f -name '*.html' | wc -l | tr -d ' ')"
echo "Site smoke checks passed (${html_count} generated HTML files)."
