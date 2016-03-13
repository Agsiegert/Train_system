require 'station'

RSpec.describe 'Station' do
  it 'has a name'do
    station = Station.new("M")
    expect(station.name).to eq("M")
  end
end
