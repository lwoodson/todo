require 'spec_helper'

describe "Auto-load and registry of commands" do
  it "should auto load and register the Todo::Commands::Init command" do
    Todo::Commands.lookup("init").should == Todo::Commands::Init
  end
end
