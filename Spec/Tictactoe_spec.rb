require 'tictactoe'

describe "" do
  it "what this test do" do
    expect(Tictactoe.new.has_won('')).to eql false
  end
end
