require 'oystercard'


describe Oystercard do
  # In order to use public transport
  # As a customer
  # I want money on my card
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }
  let(:teststation) {double :station, name: "test", zone: 0}
  subject(:oystercard){described_class.new}

  it { is_expected.to respond_to :balance }

  it 'Shows initial balance of zero' do
    expect(oystercard).to have_attributes(:balance => 0)
  end

  it "checks if balance is less than minimum limit" do
    expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds"
  end

  it 'has an empty list of journeys by default' do
    expect(oystercard.journeylog).to be_empty
  end

  context 'it has a full balance' do
    before{oystercard.top_up(Oystercard::BALANCE_LIMIT)}

    it "won't let you top up over the balance limit" do
      expect{ oystercard.top_up(1)}.to raise_error(BalanceError, "Maximum balance of #{Oystercard::BALANCE_LIMIT} exceeded")
    end

    it 'reduces minimum fare from balance when touching out' do
      oystercard.touch_in(teststation)
      expect{ oystercard.touch_out(teststation) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    let(:trip){ {entry_station: entry_station, exit_station: exit_station} }

    it 'stores a journey' do
      oystercard.touch_in(teststation)
      oystercard.touch_out(teststation)
      expect(oystercard.journeylog.size).to eq 1
    end

    it "raises an error on touch_out if passenger didn't touch_in" do
      expect{ oystercard.touch_out(teststation)}.to raise_error "No journey initiated"
    end

    it 'deducts penalty if previous journey has not been touched out' do
      oystercard.touch_in(teststation)
      expect{ oystercard.touch_in(teststation)}.to change { oystercard.balance }.by(-Oystercard::PENALTY)
    end
  end
end
