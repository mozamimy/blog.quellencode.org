#!/usr/bin/env ruby
# encoding: utf-8

class String
  # Objectクラスのメソッドを呼ぶ
  def call_instance_method_under_object_class(method)
    self.class.superclass.instance_method(:inspect).bind(self).call
  end
end

returned = "Alice".tap do |obj|
  puts obj.call_instance_method_under_object_class(:inspect)
end

puts returned.call_instance_method_under_object_class(:inspect)

