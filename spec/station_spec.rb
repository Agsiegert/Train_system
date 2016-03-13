require 'station'

RSpec.describe 'Station' do
  station = Station.new('M')

  it 'has a name'do
    expect(station.name).to eq('M')
  end

  it '#add_route adds a terminal and time' do
    expect(station.add_route('N', 5)).to eq(5)
  end

  it '#routes stores all its routes and times' do
    station.add_route('N', 5)
    expect(station.routes).to eq({'N'=>5})
    station.add_route('P', 5)
    expect(station.routes).to eq({'N'=>5,'P'=>5})
  end

  it 'knows which terminals it is connected to' do
    expect(station.connected?('N')).to be_truthy
    expect(station.connected?('Z')).to be_falsy
  end

  it '#connected? provides time to destination as truthy' do
    expect(station.connected?('N')).to eq(5)
  end
end
