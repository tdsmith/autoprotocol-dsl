require 'json'

require 'docile'

Protocol = Struct.new(:refs, :steps) do
  def to_s
    JSON.pretty_generate({refs: refs, steps: steps})
  end
end

class ProtocolBuilder
  def initialize
    @refs = []
    @steps = []
  end

  def ref(name)
    @refs << name
    self
  end

  def step(name)
    @steps << name
    self
  end

  def build
    Protocol.new(refs=@refs, steps=@steps)
  end
end

def protocol(&block)
  Docile.dsl_eval(ProtocolBuilder.new, &block).build
end

my_protocol = protocol do
  ref "my_plate"

  step "step one"
  step "step two"
end

puts my_protocol
