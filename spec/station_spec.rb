require 'station'

describe Station do
  subject(:station) { described_class.new(name: 'Name', zone: 1) }

  context ' #location' do
    it 'so a user knows what station they are at, it returns the station name' do
      expect(station.name).to eq 'Name'
    end

    it 'so a user knows the area of a station, it returns the station zone' do
      expect(station.zone).to eq 1
    end
  end

end
