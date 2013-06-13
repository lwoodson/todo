require 'spec_helper'

describe Todo::Group do
  before {@item = Todo::Item.new}
  describe "#<<" do
    it "should append an item to the group" do
      subject << @item
      subject.items.include?(@item).should == true
    end

    it "should set the index for the item" do
      subject << @item
      @item.index.should == 1
    end
  end

  describe "#items" do
    before {subject << @item}
    it "should return an equivalent array of items" do
      subject.items.should == [@item]
    end

    it "should not return a mutable array of items" do
      expect{subject.items << 1}.to raise_error
    end
  end
end
