require 'spec_helper'
require_relative 'shared'

describe Todo::Commands::Init do
  before {@command = Todo::Commands::Init.new :parent => test_parent}

  context "encountering no existing todo directory/file structure" do
    describe "#execute" do
      it_behaves_like "initialized project"
    end
  end

  context "encountering an existing TODO" do
    describe "#execute" do
      include_context "existing TODO"
      it_behaves_like "initialized project"
      it_behaves_like "TODO preserver"
    end
  end

  context "encountering an existing todo project" do
    describe "#execute" do
      include_context "existing project"
      it_behaves_like "initialized project"
      it_behaves_like "TODO preserver"
    end
  end
end
