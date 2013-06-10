require 'spec_helper'
require_relative 'shared'

describe Todo::Commands::List do
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
end
