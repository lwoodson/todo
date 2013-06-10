require 'spec_helper'
require_relative 'shared'

describe Todo::Commands::List do
  def check_stream
    @stream.rewind
    yield(@stream.read)
  end

  before do
    @stream = StringIO.new
    @command = Todo::Commands::List.new :parent => test_parent,
                                        :stream => @stream
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
      it "should render 'There are no TODO items currently.'" do
        @command.execute
        check_stream {|str| str.should == 'There are no TODO items currently.'}
      end
    end
  end
end
