#!/usr/bin/env ruby

module Kernel
  def global_varialbe_get(symbol)
    eval("#{symbol.to_s}")
  end

  def global_varialbe_set(symbol, obj)
    eval("#{symbol.to_s} = obj")
  end
end

names = [:$rabbit, :$bunny]
#names = ["$rabbit", "$bunny"]

names.each do |v|
  global_varialbe_set(v, v.to_s.upcase)
end

names.each do |v|
  p global_varialbe_get(v)
end
