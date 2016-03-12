require_relative '../train_system'
# # given a source and terminal find the distance based on the routes (directed_graph)
ROUTES = %w(MN5 NL4 LP8 PL8 PR6 MP5 LR2 RN3 MR7)

RSpec.describe 'a route' do
  it 'has a source, terminal and distance' do
    system = TrainSystem.new("MN5")
    expect(system.source).to eq("M")
    expect(system.terminal).to eq("N")
    expect(system.distance).to eq(5)
    # expect(system.route("MN5")).to eq(5)
    # expect(M->N->L).to eq(9)
    # expect(M->P).to eq(5)
    # expect(M->P->L).to eq(13)
    # expect(M->R->N->L->P).to eq(22)
    # expect(M->R->P).to eq('Itinerary not possible')
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