require 'spec_helper'

describe Todo::Item do
  shared_examples_for "equivalent items" do
    describe "#==" do
      it "should be true" do
        (@item == @other).should == true
      end
    end

    describe "#hash" do
      it "should be equal" do
        @item.hash.should == @other.hash
      end
    end
  end

  shared_examples_for "non-equivalent items" do
    describe "#==" do
      it "should not be true" do
        (@item == @other).should_not == true
      end
    end

    describe "#hash" do
      it "should not be equal" do
        @item.hash.should_not == @other.hash
      end
    end
  end

  describe "#append!" do
    it "should append a single line" do
      subject.append! "one"
      subject.lines.should == ["one"]
    end

    it "should append array of lines" do
      subject.append! ["one", "two"]
      subject.lines.should == ["one", "two"]
    end
  end

  context "two empty items" do
    before do
      @item = Todo::Item.new
      @other = Todo::Item.new
    end
    it_behaves_like "equivalent items"
  end

  context "two items with same title" do
    before do
      @item = Todo::Item.new{|item| item.title = 'title'}
      @other = Todo::Item.new{|item| item.title = 'title'}
    end
    it_behaves_like "equivalent items"
  end

  context "two items with same lines" do
    before do
      @item = Todo::Item.new{|item| item.append! ['one', 'two']}
      @other = Todo::Item.new{|item| item.append! ['one', 'two']}
    end
    it_behaves_like "equivalent items"
  end

  context "two items with different titles" do
    before do
      @item = Todo::Item.new{|item| item.title = 'one'}
      @other = Todo::Item.new{|item| item.title = 'two'}
    end
    it_behaves_like "non-equivalent items"
  end

  context "two items with different lines" do
    before do
      @item = Todo::Item.new{|item| item.append! ['one', 'two']}
      @other = Todo::Item.new{|item| item.append! ['one', 'three']}
    end
    it_behaves_like "non-equivalent items"
  end
end
