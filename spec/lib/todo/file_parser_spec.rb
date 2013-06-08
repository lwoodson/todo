require 'spec_helper'
require 'tempfile'

describe Todo::FileParser do
  def temp_file(name, text='')
    Tempfile.new(name).tap do |file|
      file.write(text)
      file.rewind
    end.path
  end

  describe "#items" do
    context "with no files" do
      it "should return empty array" do
        subject.items.should == []
      end
    end

    context "with a single file" do
      context "with no contents" do
        before {@parser = Todo::FileParser.new(temp_file('test'))}
        it "should return empty array" do
          @parser.items.should == []
        end
      end

      context "with empty lines" do
        before {@parser = Todo::FileParser.new(temp_file('test', "\n\n\n"))}
        it "should return empty array" do
          @parser.items.should == []
        end
      end

      context "with a single line todo item" do
        before do
          path = temp_file('test', '* this is a test')
          @parser = Todo::FileParser.new(path)
        end

        it "should return an Array w/single Todo::Item with title populated." do
          expected = [Todo::Item.new{|item| item.title = 'THIS IS A TEST'}]
          @parser.items.should == expected
        end
      end

      context "with a multi=line todo item" do
        before do
          path = temp_file('test', "* this is a test\nIt is only a test.")
          @parser = Todo::FileParser.new(path)
        end

        it "should return an Array w/single Todo::Item with title populated." do
          expected = [Todo::Item.new do |item|
            item.title = 'THIS IS A TEST'
            item.lines << "It is only a test."
          end]
          @parser.items.should == expected
        end
      end
    end

    context "with two files" do
      before do
        path1 = temp_file('test1', '* this is a test')
        path2 = temp_file('test2', '* it is only a test')
        @parser = Todo::FileParser.new(path1, path2)
      end

      context "and 1 item in each file" do
        it "should return an array containing 2 Todo::Items populated with file data" do
          expected = []
          expected << Todo::Item.new {|item| item.title = 'THIS IS A TEST'}
          expected << Todo::Item.new {|item| item.title = 'IT IS ONLY A TEST'}
          @parser.items.should == expected
        end
      end
    end
  end
end
