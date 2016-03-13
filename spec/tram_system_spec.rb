require 'tram_system'
# # given a source and terminal find the distance based on the routes (directed_graph)

RSpec.describe 'Tram System' do
  # test_input = 'MN5, NL4, LP8, PL8, PR6, MP5, LR2, RN3, MR7'
  test_input = "MN5", "NL4", "LP8", "PL8", "PR6", "MP5", "LR2", "RN3", "MR7"
  system = TramSystem.new(test_input)

  it 'creates each stations from the routes_graph(test_input)' do
    expect(system.stations.count).to eq(5)
  end
  it 'stations are uniq' do
    expect(system.stations).to include("M", "N", "L", "P", "R")
  end
end
