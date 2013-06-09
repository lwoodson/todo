require 'spec_helper'
require 'tmpdir'
require 'fileutils'

describe Todo::Commands::Init do
  before do
    @dir = File.join(Dir.tmpdir, 'todo_tests')
    @root_path = File.join(@dir, '.todo')
    @todo_path = File.join(@root_path, 'TODO')
    @working_path = File.join(@root_path, 'WORKING')
    @done_path = File.join(@root_path, 'DONE')
    @symlink_path = File.join(@dir, 'TODO')
    FileUtils.rm_rf(@dir)
    FileUtils.mkdir_p(@dir)
    @command = Todo::Commands::Init.new :parent => @dir
  end

  shared_examples_for "initialized project" do
    it "should have a .todo directory" do
      @command.execute
      Dir.exists?(@root_path).should == true
    end

    it "should have a TODO file in the .todo directory" do
      @command.execute
      File.exists?(@todo_path).should == true
    end

    it "should have a WORKING file in the .todo directory" do
      @command.execute
    end

    it "should have a symlink from $ROOT/TODO to $ROOT/.todo/TODO" do
      @command.execute
      File.symlink?(@symlink_path).should == true
    end
  end

  shared_examples_for "TODO preserver" do
    it "should preserve original contents of TODO" do
      File.read(@symlink_path).should == '* test'
    end
  end

  context "encountering no existing todo directory/file structure" do
    describe "#execute" do
      it_behaves_like "initialized project"
    end
  end

  context "encountering an existing TODO" do
    describe "#execute" do
      before do
        File.write(@symlink_path, '* test')
      end

      it_behaves_like "initialized project"
      it_behaves_like "TODO preserver"
    end
  end

  context "encountering an existing todo project" do
    describe "#execute" do
      before do
        FileUtils.mkdir_p(@root_path)
        File.write(@todo_path, '* test')
        FileUtils.ln_s(@todo_path, @symlink_path)
      end

      it_behaves_like "initialized project"
      it_behaves_like "TODO preserver"
    end
  end
end
