require 'journey'

describe Journey do
  let(:entry_station){ double :station}
  let(:exit_station){ double :station}
  subject(:journey){described_class.new}

  it 'it starts a trip by saving an entry station' do
   journey.start(entry_station)
   expect(journey.trip[:entry_station]).to eq entry_station
 end


end
