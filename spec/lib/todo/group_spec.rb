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

  describe "#==" do
    before do
      @group = Todo::Group.new :title => 'group',
                               :description => 'desc',
                               :parent_dir => test_parent

      @other = Todo::Group.new :title => 'group',
                               :description => 'desc',
                               :parent_dir => test_parent

      @other_item = Todo::Item.new

      @group << @item
      @other << @other_item
    end

    it "should identify two groups with same data as equivalent" do
      @group.should == @other
    end

    %w[title description parent_dir].each do |attr|
      it "should identify two groups with different #{attr} as not equal" do
        @other.send("#{attr}=", 'changed')
        @group.should_not == @other
      end
    end

    it "should identify two groups with different items as not equal" do
      @other_item.title = 'changed'
      @group.should_not == @other
    end
  end

  describe "#filename" do
    it "should replace spaces with dashes" do
      subject.title = 'this is a test'
      subject.filename.should == 'this-is-a-test'
    end

    it "should replace capitals with lowercase" do
      subject.title = 'This is A test'
      subject.filename.should == 'this-is-a-test'
    end

    it "should preserve letters, dashes, underscores and numbers" do
      subject.title = 'a-_1'
      subject.filename.should == 'a-_1'
    end

    it "should replace funky characters with dash" do
      subject.title = 'a#@!-:^&*_()1!.?'
      subject.filename.should == 'a-_1'
    end

    it "should raise error if group has no title" do
      expect{subject.filename}.to raise_error
    end
  end

  describe "#path" do
    it "should return the concatenation of the parent_dir and filename" do
      subject.title = 'test'
      subject.parent_dir = 'tmp'
      subject.path.should == File.join('tmp', 'test')
    end

    it "should raise error if group has no title" do
      subject.parent_dir = test_parent
      expect{subject.path}.to raise_error
    end

    it "should raise error if group has no parent_dir" do
      subject.title = 'test'
      expect{subject.path}.to raise_error
    end
  end
end
