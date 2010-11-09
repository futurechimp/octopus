# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{octopus}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dave@boomer"]
  s.date = %q{2010-11-09}
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
     "bin/octopus",
     "doc/octopus.zargo",
     "lib/ext/array_ext.rb",
     "lib/ext/partials.rb",
     "lib/init.rb",
     "lib/octopus.rb",
     "lib/octopus/config.ru",
     "lib/octopus/grabbers/generic_http.rb",
     "lib/octopus/models/net_resource.rb",
     "lib/octopus/models/subscription.rb",
     "lib/octopus/public/default.css",
     "lib/octopus/public/images/bg01.jpg",
     "lib/octopus/public/images/bg02.jpg",
     "lib/octopus/public/images/bg03.jpg",
     "lib/octopus/public/images/bg04.jpg",
     "lib/octopus/public/images/img01.jpg",
     "lib/octopus/public/images/img02.gif",
     "lib/octopus/public/images/img03.gif",
     "lib/octopus/public/images/img04.gif",
     "lib/octopus/public/images/img05.gif",
     "lib/octopus/public/images/img06.jpg",
     "lib/octopus/public/images/spacer.gif",
     "lib/octopus/views/edit.erb",
     "lib/octopus/views/index.erb",
     "lib/octopus/views/layout.erb",
     "lib/octopus/views/new.erb",
     "lib/octopus/views/resource_list_item.erb",
     "octopus.gemspec",
     "test/helper.rb",
     "test/support/blueprints.rb",
     "test/test_net_resource.rb",
     "test/test_octopus.rb",
     "test/test_subscription.rb"
  ]
  s.homepage = %q{http://github.com/futurechimp/octopus}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{An experimental octopus implementation.}
  s.test_files = [
    "test/test_octopus.rb",
     "test/test_net_resource.rb",
     "test/helper.rb",
     "test/support/mock_server.rb",
     "test/support/blueprints.rb",
     "test/test_subscription.rb",
     "test/grabbers/test_generic_http.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<data_mapper>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<dm-sqlite-adapter>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<thin>, [">= 1.2.5"])
      s.add_runtime_dependency(%q<rack-flash>, [">= 0.1.1"])
      s.add_runtime_dependency(%q<rack>, [">= 1.0.1"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.2"])
      s.add_development_dependency(%q<rack-test>, [">= 0.5.2"])
      s.add_development_dependency(%q<machinist>, [">= 1.0.3"])
    else
      s.add_dependency(%q<data_mapper>, [">= 1.0.0"])
      s.add_dependency(%q<dm-sqlite-adapter>, [">= 1.0.0"])
      s.add_dependency(%q<sinatra>, [">= 1.0.0"])
      s.add_dependency(%q<thin>, [">= 1.2.5"])
      s.add_dependency(%q<rack-flash>, [">= 0.1.1"])
      s.add_dependency(%q<rack>, [">= 1.0.1"])
      s.add_dependency(%q<shoulda>, [">= 2.10.2"])
      s.add_dependency(%q<rack-test>, [">= 0.5.2"])
      s.add_dependency(%q<machinist>, [">= 1.0.3"])
    end
  else
    s.add_dependency(%q<data_mapper>, [">= 1.0.0"])
    s.add_dependency(%q<dm-sqlite-adapter>, [">= 1.0.0"])
    s.add_dependency(%q<sinatra>, [">= 1.0.0"])
    s.add_dependency(%q<thin>, [">= 1.2.5"])
    s.add_dependency(%q<rack-flash>, [">= 0.1.1"])
    s.add_dependency(%q<rack>, [">= 1.0.1"])
    s.add_dependency(%q<shoulda>, [">= 2.10.2"])
    s.add_dependency(%q<rack-test>, [">= 0.5.2"])
    s.add_dependency(%q<machinist>, [">= 1.0.3"])
  end
end

