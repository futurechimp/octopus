# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{octopus}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dave@boomer"]
  s.date = %q{2009-11-23}
  s.default_executable = %q{octopus}
  s.description = %q{Grabs stuff off the net and notifies interested subscribers.}
  s.email = %q{dave.hrycyszyn@headlondon.com}
  s.executables = ["octopus"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/octopus.rb",
     "test/helper.rb",
     "test/test_octopus.rb"
  ]
  s.homepage = %q{http://github.com/futurechimp/octopus}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An experimental octopus implementation.}
  s.test_files = [
    "test/helper.rb",
     "test/test_octopus.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<datamapper>, [">= 0.10.1"])
      s.add_development_dependency(%q<do_sqlite3>, [">= 0.10.0"])
      s.add_development_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_development_dependency(%q<thin>, [">= 1.2.5"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 2.10.2"])
      s.add_development_dependency(%q<rack>, [">= 1.0.1"])
      s.add_development_dependency(%q<rack-flash>, [">= 0.1.1"])
      s.add_development_dependency(%q<rack-test>, [">= 0.5.2"])
    else
      s.add_dependency(%q<datamapper>, [">= 0.10.1"])
      s.add_dependency(%q<do_sqlite3>, [">= 0.10.0"])
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
      s.add_dependency(%q<thin>, [">= 1.2.5"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 2.10.2"])
      s.add_dependency(%q<rack>, [">= 1.0.1"])
      s.add_dependency(%q<rack-flash>, [">= 0.1.1"])
      s.add_dependency(%q<rack-test>, [">= 0.5.2"])
    end
  else
    s.add_dependency(%q<datamapper>, [">= 0.10.1"])
    s.add_dependency(%q<do_sqlite3>, [">= 0.10.0"])
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    s.add_dependency(%q<thin>, [">= 1.2.5"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 2.10.2"])
    s.add_dependency(%q<rack>, [">= 1.0.1"])
    s.add_dependency(%q<rack-flash>, [">= 0.1.1"])
    s.add_dependency(%q<rack-test>, [">= 0.5.2"])
  end
end

