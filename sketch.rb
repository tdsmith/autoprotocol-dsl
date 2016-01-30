require 'AutoprotocolDsl'

my_protocol = Autoprotocol.protocol do
  ref do
    name "Hello world"
    id 12345
    store :cold_20
  end

  ref do
    name "Goodbye world"
    id 12346
    discard
  end

  step "step one"
  step "step two"
end

puts my_protocol
