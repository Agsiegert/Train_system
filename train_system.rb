class TrainSystem
  attr_reader :source, :terminal, :distance

  def initialize(route)
    @source = route.chars.first
    @terminal = route.chars[1]
    @distance = route.chars.last.to_i

  end
end
