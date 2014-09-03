$:.unshift File.expand_path("../test", __FILE__)

task :test do
  require "cutest"
  Cutest.run(Dir["test/*.rb"])
end

task :default => :test
