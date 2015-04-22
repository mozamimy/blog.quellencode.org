#!/usr/bin/env ruby
# encoding: utf-8
# example04.rb

class String
  def to_a
    array = []
    self.chars { |ch| array << ch }
    array
  end
end

p "Alice".to_a

