class RouteFinder
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def route_time(itinerary)
    stations = itinerary.split("->")
    if stations.size == 2
      route = stations.join
      found_route = routes.select{ |r| r[0..1] == route  }
      found_route.first.chars.last.to_i
    else
      puts "Needs refactor for more difficult queries"
      # time = 0
      # # do stuff here with new knowledge of system map
      #  += time
    end
  end
end
