module Autoprotocol
  class Protocol
    attr_initialize :refs, :steps
    attr_private :refs, :steps

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

  def self.protocol(&block)
    Docile.dsl_eval(ProtocolBuilder.new, &block).build
  end
end
