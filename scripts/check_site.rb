#!/usr/bin/env ruby
# frozen_string_literal: true

require "pathname"

site_root = Pathname.new(ARGV.fetch(0, "_site")).expand_path

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

unless site_root.directory?
  abort "Generated site directory does not exist: #{site_root}"
end

required_files.each do |label, relative_path|
  path = site_root.join(relative_path)
  errors << "missing #{label}: #{relative_path}" unless path.file? && !path.empty?
end

cname = site_root.join("CNAME")
if cname.file? && cname.read.strip != "www.ml4phys.com"
  errors << "unexpected CNAME value: #{cname.read.strip.inspect}"
end

required_files
  .select { |_label, path| path.end_with?(".html") }
  .each_value do |relative_path|
    html = site_root.join(relative_path).read
    errors << "unrendered Liquid in #{relative_path}" if html.include?("{{") || html.include?("{%")
  end

unless errors.empty?
  warn "Site smoke checks failed:"
  errors.each { |error| warn "  - #{error}" }
  exit 1
end

html_count = Dir.glob(site_root.join("**/*.html")).length
puts "Site smoke checks passed (#{html_count} generated HTML files)."
