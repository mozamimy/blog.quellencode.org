p def alice
  "hello, alice"
end

alice

block = ->() { puts "hello, white rabbit" }
p define_method :white_rabbit, block

white_rabbit
