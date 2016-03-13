require_relative "station"

class TramSystem
  attr_accessor :stations

  def initialize(routes_graph)
    @stations = routes_graph.each_with_object({}) do |route, hash|
      hash[route[0]] ||= Station.new(route[0])
      hash[route[1]] ||= Station.new(route[1])
      hash[route[0]].add_route(route[1], route[2].to_i)
    end
  end

  def routes
    @stations.map do |name, destination|
      [name] + destination.routes.to_a
    end
  end

  def route_exist?(source, destination)
    @stations[source].connected?(destination)
  end

  def route_time(itinerary)
    stops = itinerary.split("->")
    if stops.size == 2
      route_exist?(stops.first, stops.last)
    else
      trips = []
      stops.map.with_index do |stop, index|
        trips << stop + stops[index + 1] unless index == stops.size - 1
      end
      legs = trips.flatten
      legs.inject(0) do |time, leg|
        leg_time = route_exist?(leg.chars.first, leg.chars.last)
        time += leg_time
      end
    end
  end
end



