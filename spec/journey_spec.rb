require 'journey'

describe Journey do
  let(:station) {double :station, name: "test", zone: 0}
  subject(:journey){described_class.new(station)}

  it 'it starts a trip by saving an entry station' do
   expect(journey.entry_station).to eq ({"test"=>0})
 end


end
