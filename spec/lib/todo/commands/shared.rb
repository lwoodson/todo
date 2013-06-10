require 'tmpdir'
require 'fileutils'


shared_context "existing TODO" do
  before do
    write_todo('* test')
  end
end

shared_context "existing project" do
  before do
    create_todo_dir
    create_symlink
  end
  include_context "existing TODO"
end


shared_examples_for "initialized project" do
  it "should have a .todo directory" do
    @command.execute
    Dir.exists?(todo_dir).should == true
  end

  it "should have a TODO file in the .todo directory" do
    @command.execute
    File.exists?(todo_file).should == true
  end

  it "should have a WORKING file in the .todo directory" do
    @command.execute
    File.exists?(working_file).should == true
  end

  it "should have a DONE file in the .todo directory" do
    @command.execute
    File.exists?(done_file).should == true
  end

  it "should have a symlink from $ROOT/TODO to $ROOT/.todo/TODO" do
    @command.execute
    File.symlink?(todo_symlink).should == true
  end
end

shared_examples_for "TODO preserver" do
  it "should preserve original contents of TODO" do
    todo_contents.should == '* test'
  end
end
