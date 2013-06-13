require 'spec_helper'

require 'spec_helper'

describe Todo::Item do
  describe "#initialize" do
    Todo::Item::STATUSES.each do |status|
      it "should not raise error if the status is #{status}" do
        expect{Todo::Item.new :index => 1, :status => status}.to_not raise_error
      end
    end
  end

  describe "#index=" do
    it "should work with positive integers" do
      subject.index = 1
      subject.index.should == 1
    end

    it "should fail with negative integers" do
      expect{subject.index = -1}.to raise_error
    end

    it "should fail with zero" do
      expect{subject.index = 0}.to raise_error
    end

    it "should fail with values that cant be coerced into ints" do
      expect{subject.index = Object}.to raise_error
    end
  end

  context "status related methods" do
    before {@item = Todo::Item.new :index => 1}
    Todo::Item::STATUSES.each do |status|
      describe "##{status}!" do
        it "should put the item in a #{status} status" do
          @item.send("#{status}!")
          @item.status.should == status
        end
      end

      describe "##{status}?" do
        it "should be true if the item is in a #{status} status" do
          @item.send("#{status}!")
          @item.send("#{status}?").should == true
        end

        (Todo::Item::STATUSES - [status]).each do |other_status|
          it "should be false if the item is in a #{other_status} status" do
            @item.send("#{other_status}!")
            @item.send("#{status}?").should == false
          end
        end
      end
    end
  end

  describe "#==" do
     before do 
      @item1 = Todo::Item.new :index => 1, :title => 'title', :status => Todo::Item::TODO_STATUS,
                     :worker => 'worker', :description => 'desc', :children => [1]
      @item2 = Todo::Item.new :index => 1, :title => 'title', :status => Todo::Item::TODO_STATUS,
                     :worker => 'worker', :description => 'desc', :children => [1]
    end

    it "should treat @items with same data as equal" do
      @item1.should == @item2
    end

    %w[title worker description].each do |attr|
      it "should treat items with different #{attr}s as not equal" do
        @item2.send("#{attr}=", "changed")
        @item1.should_not == @item2
      end
    end

    it "should treat items with different children as not equal" do
      @item2.children << 2
      @item1.should_not == @item2
    end

    it "should treat items with different indexes as not equal" do
      @item2.index = 2
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
