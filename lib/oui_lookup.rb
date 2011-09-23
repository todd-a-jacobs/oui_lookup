#!/usr/bin/env ruby

module OUI_Lookup
  require_relative 'oui_lookup/version'
  require_relative 'oui_lookup/lookup'
end

if __FILE__ == $0
  a = ARGV.last.to_s.scan(/\h{2}/).join
  m = a.empty? \
      ? '000510' : a
  l = OUI_Lookup::Lookup.new m
  h = l.lookup
  n = l.parse h
  v = l.vendor n
  puts v
end
