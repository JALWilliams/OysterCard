require 'oystercard'

describe OysterCard do

  it 'responds to an instance of itself' do 
    expect(subject).to be_kind_of(OysterCard)
  end

  it 'card has a balance of zero when new (ie.initliazed)' do
    expect(subject.balance).to eql 0
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'change the overall balance by top up amount' do
      expect{subject.top_up(2)}.to change{subject.balance}.by 2
    end

    it 'raises and error when try to top up a card that is above 90' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{subject.top_up(1)}.to raise_error "Maximum balance of #{maximum_balance} reached"
    end

  end

  describe '#deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'expect to reduce the balance by the deducted amount' do
      expect {subject.deduct(2)}.to change{subject.balance}.by -2
    end

  end

  describe 'touch_in' do
    it {is_expected.to respond_to(:touch_in)}

    it 'expect to be in_journey to be true'do
      subject.top_up(20)
      subject.touch_in
      expect(subject).to be_in_journey 
    end 

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey 
    end

    it 'raises and error if less than 1 pound' do
      expect{subject.touch_in}.to raise_error "Insufficient funds"
    end

  end

  describe 'touch_out' do

    it 'expect to be in_journey to be false' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'reduces your balance when you touch out' do
      subject.top_up(20)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by(-OysterCard::MINIMUM_CHARGE)
    end

  end

    
end