require 'spec_helper'

require 'spec_helper'

describe Todo::Item do
  describe "#initialize" do
    it "should raise an error if the index is zero" do
      expect{Todo::Item.new :index => 0}.to raise_error
    end

    it "should raise an error if the index is a negative integer" do
      expect{Todo::Item.new :index => -1}.to raise_error
    end

    it "should raise an error if the index cannot be coerced into an integer" do
      expect{Todo::Item.new :index => Object.new}.to raise_error
    end

    it "should not raise an error if the index is a positive integer" do
      expect{Todo::Item.new :index => 1}.to_not raise_error
    end
  end

  describe "#==" do
     before do 
      @item1 = Todo::Item.new :index => 1, :title => 'title', :status => 'status', 
                     :worker => 'worker', :description => 'desc', :children => [1]
      @item2 = Todo::Item.new :index => 1, :title => 'title', :status => 'status', 
                     :worker => 'worker', :description => 'desc', :children => [1]
    end

    it "should treat @items with same data as equal" do
      @item1.should == @item2
    end

    %w[index title status worker description].each do |attr|
      it "should treat items with different #{attr}s as not equal" do
        @item2.send("#{attr}=", "changed")
        @item1.should_not == @item2
      end
    end

    it "should treat items with different children as not equal" do
      @item2.children << 2
      @item1.should_not == @item2
    end
  end

  shared_context "basic item" do
    before do
      @item = Todo::Item.new :index => 1, :title => 'title', :status => 'todo',
                             :worker => 'worker', :description => 'desc'
    end
  end
end
