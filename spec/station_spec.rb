require 'station'

describe Station do

    subject {described_class.new(name="Bank", zone=1)}

    it 'saves its name' do
        expect(subject.name).to eq "Bank"
    end

    it 'saves a station' do
        expect(subject.zone).to eq 1
    end
end
