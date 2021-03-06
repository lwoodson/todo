require 'spec_helper'

klass = Todo::Commands::Init
describe Todo::Commands do

  describe "#register of #{klass}" do
    before {Todo::Commands.register(klass)}

    describe "then #lookup" do
      klass.name.downcase.split("::")[-1].split("").inject("") do |key, c|
        key.tap do |key|
          key << c
          it "should return #{klass} for key #{key}" do
            Todo::Commands.lookup(key).should == klass
          end
        end
      end
    end
  end

  describe "#default" do
    it "should return a class that responds to #execute" do
      Todo::Commands.default.instance_methods.grep(/^execute$/)
        .should == [:execute]
    end
  end
end
