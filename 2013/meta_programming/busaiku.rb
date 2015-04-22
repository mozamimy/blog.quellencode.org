#!/usr/bin/env ruby

names = ["rabbit", "bunny"]

names.each do |v|
  eval("$#{v} = v.upcase")
end

names.each do |v|
  p eval("$#{v}")
end

