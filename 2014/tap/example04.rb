#!/usr/bin/env ruby
# encoding: utf-8
# example03.rb

class String
  def to_a
    Array.new.tap do |array|
      self.chars {|ch| array << ch}
    end
  end
end

p "Alice".to_a

