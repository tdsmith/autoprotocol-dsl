require 'AutoprotocolDsl'

container = AutoprotocolDsl.container do
  name "Foo"
  id "Bar"
  discard
end

my_protocol = AutoprotocolDsl.protocol do
  ref "Hello world" do
    container_type :pcr_96
    store :cold_20
  end

  ref do
    name "Goodbye world"
    id "opaque_string"
    discard
  end

  ref container

  step "step one"
  step "step two"
end

puts my_protocol
