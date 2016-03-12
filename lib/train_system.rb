class TrainSystem
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  # def route(route)
  #   @source = route.chars.first
  #   @terminal = route.chars[1]
  #   @distance = route.chars.last.to_i
  # end

  def route_time(itinerary)
    stations = itinerary.split("->")
    route = stations.join
    found_route = routes.select{ |r| r[0..1] == route  }
    found_route.first.chars.last.to_i

  end

end
