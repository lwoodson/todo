require 'spec_helper'
require_relative 'shared'

describe Todo::Commands::List do
  before do
    @command = Todo::Commands::List.new :parent => test_parent,
                                        :stream => test_stream
  end

  context "with no existing project" do
    it_behaves_like 'initialized project'
  end

  context "with existing TODO file only" do
    include_context "existing TODO"
    it_behaves_like 'initialized project'
    it_behaves_like 'TODO preserver'
  end

  context "encountering an existing todo project" do
    include_context "existing project"
    it_behaves_like 'initialized project'
    it_behaves_like 'TODO preserver'
  end

  context "with empty TODO file" do
    before {write_todo "\n\n"}

    describe "#execute" do
      it "should render 'There is nothing todo.'" do
        @command.execute
        stream_contents.should == "There is nothing todo.\n"
      end
    end
  end

  context "with populated TODO file" do
    before {write_todo "* test one\n* test two"}

    describe "#execute" do
      it "should render items in TODO file" do
        @command.execute
        stream_contents.should == "1.   TEST ONE\n\n2.   TEST TWO\n"
      end
    end
  end
end
