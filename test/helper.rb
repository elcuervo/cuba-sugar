$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))
require "cuba"
require "cuba/sugar"
require "cutest"

prepare { Cuba.reset! }
