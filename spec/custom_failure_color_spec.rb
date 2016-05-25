RSpec.configure do |config|
  config.failure_color = :magenta
  config.tty = true
  config.color = true
end

describe "failure" do
  it "fails and uses the custom color" do
    expect(2).to eq(4)
  end
end
