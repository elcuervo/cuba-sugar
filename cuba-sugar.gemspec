Gem::Specification.new do |s|
  s.name              = "cuba-sugar"
  s.version           = "0.3.1"
  s.summary           = "Give Cuba some Sugar!"
  s.description       = "Useful stuff to use with cuba"
  s.authors           = ["elcuervo"]
  s.email             = ["yo@brunoaguirre.com"]
  s.homepage          = "http://github.com/elcuervo/cuba-sugar"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files test`.split("\n")

  s.add_dependency("cuba",      "~> 3.1.0")
  s.add_dependency("rack_csrf", "~> 2.4.0")

  s.add_development_dependency("cutest", "~> 1.1.3")
  s.add_development_dependency("tilt",   "~> 1.3.3")
end
