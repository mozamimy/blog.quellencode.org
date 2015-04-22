#!/usr/bin/env ruby
# encoding: utf-8
# example02.rb

output = ->(str) { puts str }

"Alice".downcase.tap(&output)
       .upcase.tap(&output)
       .swapcase.tap(&output)
       .capitalize.tap(&output)
