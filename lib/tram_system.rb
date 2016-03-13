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
    trips = []
    stops.map.with_index do |stop, index|
      trips << stop + stops[index + 1] unless index == stops.size - 1
    end
    legs = trips.flatten
    legs.inject(0) do |time, leg|
      leg_time = route_exist?(leg.chars.first, leg.chars.last)
      return 'Itinerary not possible' unless leg_time
      time += leg_time
    end
  end

  def trip_count(source, destination)
    build_trips(source, destination).size
  end

  def build_trips(source, destination)
    trip_options = []
    trips = []
    options_from_source = stations[source].routes.keys
    options_from_source.map do |stop|
      trips << source + "->" + stop
    end
    trips = trips.flatten

    all_options(trips, destination, trip_options)
  end

  def all_options(trips, destination, trip_options )
    return trip_options if trips.empty?

    trip_search = trips.map do |trip|
      next_options = stations[trip.chars.last].routes.keys
      next_options.flat_map do |stop|
        if stop == destination
          trip_options <<  trip + "->" + stop
        else
          trip + "->" + stop
        end
      end
    end

    trips = trip_search.flatten.delete_if do |trip|
      trip_options.include?(trip)
    end

    all_options(trips,destination, trip_options)
  end

  def destination_reached?(trips, destination)
    trips.each do |trip|
      return false unless trip.chars.last == destination
    end
  end
end



