class Station
  attr_accessor :name

  def initialize(name)
    @name ||= name
    @connections ||= {}
  end

  def add_route(terminal, time)
    @connections[terminal] = time
  end

  def routes
    @connections
  end

  def connected?(destination)
    @connections[destination]
  end
end
