require 'spec_helper'
require 'stringio'

describe Todo::ItemRenderer do
  def rewind_after(&block)
    block.call
    @stream.rewind
  end

  before do
    @stream = StringIO.new
    @renderer = Todo::ItemRenderer.new(@stream)
  end

  describe "#render_output" do
    context "when passed nil" do
      it "should render nothing when passed a nil value" do
        rewind_after {@renderer.render_output(nil)}
        @stream.readlines.should == []
      end
    end

    context "when passed single item" do
      context "with a title only" do
        before {@item = Todo::Item.new{|item| item.title = 'test'}}

        it 'should render "1. [TITLE]\n" to the stream' do
          rewind_after {@renderer.render_output(@item)}
          @stream.read.should == "1.   TEST\n"
        end
      end

      context "with a title and one line" do
        before do
          @item = Todo::Item.new do |item|
            item.title = 'test'
            item.append! 'This is a test.'
          end
        end

        it 'should render "1. [TITLE]\n[LINE]\n" to the stream' do
          rewind_after{@renderer.render_output(@item)}
          @stream.read.should == "1.   TEST\n     This is a test.\n"
        end
      end

      context "with a title and two lines" do
        before do
          @item = Todo::Item.new do |item|
            item.title = 'test'
            item.append!('This is a test.')
            item.append!('It is only a test.')
          end
        end

        it 'should render "1. [TITLE]\n[LINE1]\n[LINE2]" to the stream' do
          rewind_after {@renderer.render_output(@item)}
          @stream.read.should == "1.   TEST\n     This is a test.\n     It is only a test.\n"
        end
      end
    end

    context "when passed multiple items (title only)" do
      context "with two items" do
        before do
          @items = [
            Todo::Item.new {|item| item.title = 'one'},
            Todo::Item.new {|item| item.title = 'two'}
          ]
        end

        it 'should render "1. [TITLE]\n\n2.[TITLE]\n" to the stream' do
          rewind_after {@renderer.render_output(@items)}
          @stream.read.should == "1.   ONE\n\n2.   TWO\n"
        end
      end

      context "with three items" do
        before do
          @items = [
            Todo::Item.new {|item| item.title = 'one'},
            Todo::Item.new {|item| item.title = 'two'},
            Todo::Item.new {|item| item.title = 'three'}
          ]
        end

        it 'should render "1.   [TITLE]\n\n2.  [TITLE]\n\n3.   [TITLE]\n" to the stream' do
          rewind_after {@renderer.render_output(@items)}
          @stream.read.should == "1.   ONE\n\n2.   TWO\n\n3.   THREE\n"
        end
      end
    end

    context "when passed a chipotle burrito worth of items" do
      before do
        @items = []
        @items << Todo::Item.new do |item|
          item.title = 'one'
          item.append!('line 1.1')
          item.append!('line 1.2')
        end
        @items << Todo::Item.new do |item|
          item.title = 'two'
          item.append!('line 2.1')
          item.append!('line 2.2')
        end
        @items << Todo::Item.new do |item|
          item.title = 'three'
          item.append!('line 3.1')
          item.append!('line 3.2')
        end
      end

      it "should render a chipotle burrito worth of items" do
        rewind_after {@renderer.render_output(@items)}
        lines = @stream.readlines
        lines.shift.should == "1.   ONE\n"
        lines.shift.should == "     line 1.1\n"
        lines.shift.should == "     line 1.2\n"
        lines.shift.should == "\n"
        lines.shift.should == "2.   TWO\n"
        lines.shift.should == "     line 2.1\n"
        lines.shift.should == "     line 2.2\n"
        lines.shift.should == "\n"
        lines.shift.should == "3.   THREE\n"
        lines.shift.should == "     line 3.1\n"
        lines.shift.should == "     line 3.2\n"
        lines.shift.should == nil
      end
    end
  end
end
