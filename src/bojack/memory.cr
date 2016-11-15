require "./exceptions"

module BoJack
  class Memory(K, V)
    class InvalidKey < BoJack::Exceptions::Runtime; end

    struct Entry(V)
      getter value
      def initialize(@value : V); end
    end

    def initialize
      @cache = {} of K => BoJack::Memory::Entry(V)
    end

    def write(key : K, value : V) : V
      @cache[key] = BoJack::Memory::Entry.new(value)

      value
    end

    def read(key : K) : V?
      if entry = @cache[key]?
        entry.value
      else
        raise BoJack::Memory::InvalidKey.new("'#{key.to_s}' is not a valid key")
      end
    end

    def delete(key : K) : V?
      if entry = @cache.delete(key)
        entry.value
      else
        raise BoJack::Memory::InvalidKey.new("'#{key.to_s}' is not a valid key")
      end
    end

    def append(key : K, values : V)
      data = read(key)
      data += values
      write(key, data)
    end

    def size
      @cache.size
    end

    def reset
      @cache = {} of K => BoJack::Memory::Entry(V)
    end

    private def read_entry(key : K) : BoJack::Memory::Entry(V)?
      if entry = @cache[key]?
        entry
      end
    end
  end
end
