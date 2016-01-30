require 'AutoprotocolDsl/container'

module AutoprotocolDsl
  class Protocol
    extend AttrExtras.mixin
    attr_initialize :refs, :steps
    attr_private :refs, :steps

    def to_s
      JSON.pretty_generate({refs: refs.values, steps: steps})
    end
  end

  class ProtocolBuilder
    attr_reader :refs

    def initialize
      @refs = {}
      @steps = []
    end

    def ref(container_or_name=nil, &block)
      container = \
        if block_given?
          if container_or_name.is_a? Container
            raise ArgumentError.new "Must not provide both a container and a block"
            Docile.dsl_eval(ContainerBuilder.new, &block).build
          else
            builder = Docile.dsl_eval(ContainerBuilder.new, &block)
            builder.name container_or_name if container_or_name
            builder.build
          end
        else
          container_or_name
        end
      @refs[container.name] = container if container
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
