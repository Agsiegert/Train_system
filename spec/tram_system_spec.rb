require 'tram_system'

RSpec.describe 'Tram System' do
  test_input = 'MN5', 'NL4', 'LP8', 'PL8', 'PR6', 'MP5', 'LR2', 'RN3', 'MR7'
  system = TramSystem.new(test_input)

  it 'creates each stations from the routes_graph(test_input)' do
    expect(system.stations.count).to eq(5)
  end
  it 'does not create duplicate stations' do
    unique_stations = test_input.flat_map { |s| s[0..1].chars }.uniq
    expect(system.stations.keys).to eq(unique_stations)
  end
  it 'needs to know all possible routes with #routes' do
    expect(system.routes.size).to eq(5)
    expect(system.routes[0]).to eq(['M', ['N', 5], ['P', 5], ['R', 7]])
  end
  it 'needs to know if a route is possible with route_exist?' do
    expect(system.route_exist?('M', 'N')).to be_truthy
    expect(system.route_exist?('M', 'Z')).to be_falsy
  end

  it '#route_exist? provides the time to destination as truthy' do
    expect(system.route_exist?('M', 'N')).to eq(5)
  end

  context 'route_time returns a distance based on itinerary' do
    it 'for M->P (Q2)' do
      expect(system.route_time('M->P')).to eq(5)
    end
    it 'for N->L' do
      expect(system.route_time('N->L')).to eq(4)
    end
    it 'for M->N->L (Q1)' do
      expect(system.route_time('M->N->L')).to eq(9)
    end
    it 'for M->P->L (Q3)' do
      expect(system.route_time('M->P->L')).to eq(13)
    end
    it 'for M->R->N->L->P (Q4)' do
      expect(system.route_time('M->R->N->L->P')).to eq(22)
    end
    it 'lets you know if route is not possible (Q5)' do
      expect(system.route_time('M->R->P')).to eq('Itinerary not possible')
    end
    it 'unless start and end are the same' do
      # check for Q6+, need to solve those differently...
      expect(system.route_time('L->L')).to eq('Itinerary not possible')
    end
  end

  context '#trip_count returns the number of trips based on conditionals' do
    it 'L->L with max 3 stops (Q6)' do
      expect(system.trip_count('L', 'L', 1, 3)).to eq(2)
    end
    it 'M->L with exactly 4 stops (Q7)' do
      expect(system.trip_count('M', 'L', 4, 4)).to eq(3)
    end
  end
  context '#shortest_route returns the shortest route between' do
    it 'M->L (Q8)' do
      expect(system.shortest_route('M', 'L')).to eq(9)
    end
    it 'N->N (Q9)' do
      expect(system.shortest_route('N', 'N')).to eq(9)
    end
  end
  context '#scenic_route returns the number of route options within a distance' do
    it 'L->L under 30 (Q10)' do
      expect(system.scenic_route('L', 'L', 30)).to eq(7)
    end
  end
end

  #Output" If there is no possible route, output is: "Itinerary not possible". Always follow the shortest route.

  #Test Input: MN5, NL4, LP8, PL8, PR6, MP5, LR2, RN3, MR7

  #Each letter represents a station with the number as minutes to travel. MN5 is a route from M to N taking 5 minutes.

  # Questions:

  # 1. The time for the route: M->N->L

  # 2. The time for the route: M->P

  # 3. The time for the route: M->P->L

  # 4. The time for the route: M->R->N->L->P

  # 5. The time for the route: M->R->P

  # 6. The number of trips starting at L and ending at L with a maximum of 3 stops. There are 2 trips: L->P->L and L->R->N->L

  # 7. The number of trips starting at M and ending at L with exactly 4 stops. There are 3 trips: M->N->L->P->L, M->P->L->P->L, M->P->R->N->L

  # 8. The length of the shortest route (in terms of distance to travel) from M to L.

  # 9. The length of the shortest route (in terms of distance to travel) from N to N.

  # 10. The number of different routes from L to L with a distance of less than 30. In the sample data, the trips are: LPL16, LRNL9, LRNLPL25, LPLRNL25, LPRNL21, LRNLRNL18, LRNLRNLRNL27

  # Expected Output

  # Output #1: 9

  # Output #2: 5

  # Output #3: 13

  # Output #4: 22

  # Output #5: Itinerary not possible

  # Output #6: 2

  # Output #7: 3

  # Output #8: 9

  # Output #9: 9

  # Output #10: 7


