# coding: utf-8

Gem::Specification.new do |s|
  s.name                      = 'dynamic_searchable'
  s.version                   = '0.0.1'
  s.date                      = %q{2010-12-01}
  s.authors                   = ["Dai Akatsuka"]
  s.email                     = %q{d.akatsuka@ist-corp.jp}
  s.description               = %q{This plugin can be search by using scope}
  s.summary                   = %q{This plugin can be search by using scope}
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version          = %q{1.3.7}
  s.files                     = [
    ".gitignore",
    "Gemfile",
    "Gemfile.lock",
    "MIT-LICENSE",
    "README",
    "Rakefile",
    "dynamic_searchable.gemspec",
    "init.rb",
    "lib/dynamic_searchable.rb"
  ]

  s.add_development_dependency 'bundler',          '>=1.0.0'
  s.add_development_dependency 'rspec',            '>=2.0.1'
  s.add_development_dependency 'sqlite3-ruby',     '>=1.3.2'
  s.add_development_dependency 'activemodel',      '3.0.1'
  s.add_development_dependency 'activerecord',     '3.0.1'
  s.add_development_dependency 'activesupport',    '3.0.1'
  s.add_development_dependency 'database_cleaner', '0.5.2'
end
