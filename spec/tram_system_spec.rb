require 'tram_system'
# # given a source and terminal find the distance based on the routes (directed_graph)

RSpec.describe 'Tram System' do
  # test_input = 'MN5, NL4, LP8, PL8, PR6, MP5, LR2, RN3, MR7'
  test_input = "MN5", "NL4", "LP8", "PL8", "PR6", "MP5", "LR2", "RN3", "MR7"
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
    expect(system.routes[0]).to eq(["M", ["N", 5], ["P", 5], ["R", 7]])
  end
  it 'needs to know if a route is possible with route_exist?' do
    expect(system.route_exist?("M", "N")).to be_truthy
    expect(system.route_exist?("M", "Z")).to be_falsy
  end

  it '#route_exist? provides the time to destination as truthy' do
    expect(system.route_exist?("M", "N")).to eq(5)
  end

  context 'route_time returns a distance based on itinerary' do
    it 'for M->P' do
      expect(system.route_time("M->P")).to eq(5)
    end
    it 'for N->L' do
      expect(system.route_time("N->L")).to eq(4)
    end
    it 'for M->N->L' do
      expect(system.route_time("M->N->L")).to eq(9)
    end
    it 'for M->P->L' do
      expect(system.route_time("M->P->L")).to eq(13)
    end
    it 'for M->R->N->L->P' do
      expect(system.route_time("M->R->N->L->P")).to eq(22)
    end
    it 'lets you know if route is not possible' do
      expect(system.route_time("M->R->P")).to eq('Itinerary not possible')
    end
  end
end

  # Questions:

  # 1. The time for the route: M->N->L

  # 2. The time for the route: M->P

  # 3. The time for the route: M->P->L

  # 4. The time for the route: M->R->N->L->P

  # S. The time for the route: M->R->P

  # 6. The number of trips starting at L and ending at L with a maximum of 3 stops. There are 2 trips: L->P->L and L->R->N->L

  # 7. The number of trips starting at M and ending at L with exactly 4 stops. There are 3 trips: M->N->L->P->L, M->P->L->P->L, M->P->R->N->L

  # 8. The length of the shortest route (in terms of distance to travel) from M to L.

  # 9. The length of the shortest route (in terms of distance to travel) from N to N.

  # 10. The number of different routes from L to L with a distance of less than 30. In the sample data, the trips are: LPL, LRNL, LRNLPL, LPLRNL, LPRNL, LRNLRNL, LRNLRNLRNL
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


