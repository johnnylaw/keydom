Gem::Specification.new do |s|
  s.name = 'keydom'
  s.version = '1.0.0'
  s.summary = 'Support for UUID as primary key with Rails using PostgreSQL'
  s.description = "Adds helpers to facilitate the use of the uuid-type column as a primary key. " +
    "Also adds helper to migrations and dumps non-default primary keys to schema.rb"

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = '>= 1.3.5'

  s.author            = 'John Lawrence'
  s.email             = 'johnonrails@gmail.com'
  s.homepage          = 'http://github.com/johnnylaw/keydom'
  s.rubyforge_project = 'keydom'

  s.extra_rdoc_files = %w(README.rdoc)
  s.files = %w(MIT-LICENSE README.rdoc) + Dir['lib/**/*.rb']# + Dir['test/**/*.rb']
  s.add_dependency('activerecord', '>= 3.0.0')
  s.add_development_dependency('activerecord', '>= 3.1.0')
  s.add_dependency('uuidtools', '>=2.1.3')
end