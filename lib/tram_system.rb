require_relative "station"

class TramSystem
  attr_accessor :stations

  def initialize(routes_graph)
    @stations = routes_graph.each_with_object({}) do |route, hash|
      hash[route[0]] ||= Station.new(route[0])
      hash[route[1]] ||= Station.new(route[1])
    end
  end
end



