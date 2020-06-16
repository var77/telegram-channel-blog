defmodule Mix.Tasks.Blog.Compile do
  use Mix.Task

  @shortdoc "Compiles the project"
  def run(_) do
    IO.puts "Compiling project..."
    File.cd! "priv/client"
    System.cmd("npm", ["run", "compile"])
    IO.puts "Successfully compiled!"
  end
end