
module Auth
  # Caching methods for sessions.
  module Cache

    Storage = {}
    NullValue = Time.new(0)

    def self.add(token)
      Storage[token] = Time.now + (ENV['CACHE_TTL'] || 600).to_i
    end

    def self.get(token)
      Storage[token] || NullValue
    end

    def self.authorized?(token)
      Time.now < get(token)
    end
  end
end
