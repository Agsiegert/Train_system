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

  def trip_count(source, destination, min_stops = 1, max_stops = 10)
    max_trips = build_trips(source, destination).select do |conditonal_trips|
      conditonal_trips.tr('->', '').size - 1 <= max_stops
    end
    trips = max_trips.select do |conditonal_trips|
      conditonal_trips.tr('->', '').size - 1 >= min_stops
    end
    trips.size
  end

  def shortest_route(source, destination)
    trip_times(source, destination).sort.first
  end

  def scenic_route(source, destination, max_time)
    trip_times(source, destination).select do |trip_time|
      trip_time < max_time
    end.size
  end

  def build_trips(source, destination)
    trip_options = []
    trips = []
    options_from_source = stations[source].routes.keys
    options_from_source.flat_map do |stop|
      trips << source + "->" + stop
    end
    all_options(trips, destination, trip_options)
  end

  def all_options(trips, destination, trip_options, limit = 8) #8 iterations for Q10
    return trip_options if limit.zero?
    trip_search = trips.flatten.collect do |trip|
      next_options = stations[trip.chars.last].routes.keys
      next_options.map do |stop|
        if stop == destination
          trip_options <<  trip + "->" + stop
        end
        trip + "->" + stop
      end
    end
    trips = trip_search.delete_if do |trip|
      trip_options.include?(trip)
    end
    limit -= 1
    all_options(trips, destination, trip_options, limit)
  end

  def trip_times(source, destination)
    trips = build_trips(source, destination)
    trips.map do |trip|
      route_time(trip)
    end
  end

end



