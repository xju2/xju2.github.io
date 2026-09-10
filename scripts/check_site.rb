#!/usr/bin/env ruby
# frozen_string_literal: true

site_root = File.expand_path(ARGV.fetch(0, "_site"))

required_files = {
  "home page" => "index.html",
  "projects page" => "projects/index.html",
  "publications page" => "publications/index.html",
  "talks page" => "talks/index.html",
  "students page" => "students/index.html",
  "sitemap" => "sitemap.xml",
  "custom domain" => "CNAME",
  "compiled stylesheet" => "assets/css/main.css",
  "compiled JavaScript" => "assets/js/main.min.js"
}.freeze

errors = []

abort "Generated site directory does not exist: #{site_root}" unless File.directory?(site_root)

required_files.each do |label, relative_path|
  path = File.join(site_root, relative_path)
  errors << "missing #{label}: #{relative_path}" unless File.file?(path) && File.size?(path)
end

cname = File.join(site_root, "CNAME")
if File.file?(cname) && File.read(cname).strip != "www.ml4phys.com"
  errors << "unexpected CNAME value: #{File.read(cname).strip.inspect}"
end

required_files
  .select { |_label, path| path.end_with?(".html") }
  .each_value do |relative_path|
    html = File.read(File.join(site_root, relative_path))
    errors << "unrendered Liquid in #{relative_path}" if html.include?("{{") || html.include?("{%")
  end

unless errors.empty?
  warn "Site smoke checks failed:"
  errors.each { |error| warn "  - #{error}" }
  exit 1
end

html_count = Dir.glob(File.join(site_root, "**", "*.html")).length
puts "Site smoke checks passed (#{html_count} generated HTML files)."
