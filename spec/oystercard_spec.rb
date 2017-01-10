require 'oystercard'


describe Oystercard do
  # In order to use public transport
  # As a customer
  # I want money on my card
  subject(:oystercard){described_class.new}

  it { is_expected.to respond_to :balance }

  it 'Shows initial balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

    it "checks if balance is less than minimum limit" do
      expect{oystercard.touch_in}.to raise_error "Insufficient funds"
    end

  context 'it has a full balance' do
    before{oystercard.top_up(Oystercard::BALANCE_LIMIT)}

    it "won't let you top up over the balance limit" do
      expect{ oystercard.top_up(1)}.to raise_error(BalanceError, "Maximum balance of #{Oystercard::BALANCE_LIMIT} exceeded")
    end

    it 'can touch in' do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'can touch out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'reduces minimum fare from balance when touching out' do
      expect{ oystercard.touch_out }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
  end

  it 'is initially not in a journey' do
    expect(oystercard).not_to be_in_journey
  end
end
