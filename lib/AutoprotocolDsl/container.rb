module Autoprotocol
  class Container
    extend AttrExtras.mixin
    attr_initialize :name, :id, :store, :discard
    attr_private :name, :id, :store, :discard

    def to_h
      blob = {id: id}
      blob.update(
        if discard
          {discard: true}
        else
          {store: {where: store}}
        end
      )
      {name => blob}
    end

    def to_json(state)
      JSON.pretty_generate(to_h, state)
    end
  end

  class ContainerBuilder
    def initialize
      @name = nil
      @id = nil
      @store = nil
    end

    def name(name)
      @name = name
      self
    end

    def id(id)
      @id = id
      self
    end

    def store(store)
      @store = store
      self
    end

    def discard(discard=true)
      @discard = discard
      self
    end

    def build
      validate!
      Container.new(@name, @id, @store, @discard)
    end

    private
    def validate!
      raise "Must specify container name" unless @name
      raise "Must specify container ID" unless @id
      raise "Must specify storage or discard condition" unless @store || @discard
      raise "Must either store or discard, not both" if @store && @discard
    end
  end

  def self.container(&block)
    Docile.dsl_eval(ContainerBuilder.new, &block).build
  end
end
