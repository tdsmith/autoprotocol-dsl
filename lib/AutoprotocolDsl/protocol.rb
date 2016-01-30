require 'AutoprotocolDsl/container'

module Autoprotocol
  class Protocol
    extend AttrExtras.mixin
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

    def ref(container=nil, &block)
      if block_given?
        raise ArgumentError.new("Must not provide both a container and a block") if container
        container = Docile.dsl_eval(ContainerBuilder.new, &block).build
      end
      @refs << container if container
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
