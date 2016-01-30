require 'AutoprotocolDsl'

my_protocol = Autoprotocol.protocol do
  ref "my_plate"

  step "step one"
  step "step two"
end

puts my_protocol
