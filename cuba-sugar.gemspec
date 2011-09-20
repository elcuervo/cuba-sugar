Gem::Specification.new do |s|
  s.name              = "cuba-sugar"
  s.version           = "0.2.0"
  s.summary           = "Give Cuba some Sugar!"
  s.description       = "Bundled contrib utils to use with cuba"
  s.authors           = ["elcuervo"]
  s.email             = ["yo@brunoaguirre.com"]
  s.homepage          = "http://github.com/elcuervo/cuba-sugar"
  s.files = ["LICENSE", "README.md", "lib/cuba/sugar.rb"]
  s.add_dependency("cuba")
  s.add_dependency("json")
  s.add_dependency("rack_csrf")
end
