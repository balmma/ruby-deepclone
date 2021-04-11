Gem::Specification.new do |s|
  s.name = 'ruby_deep_clone'
  s.version = '0.8.0'
  s.date = '2017-08-03'

  s.summary = 'Ruby native deep clone'
  s.description = 'Native implementation to create deep clones of Ruby objects'

  s.authors = ['Matthias Balmer', 'Andre Medeiros', 'Anthony Williams']
  s.email = ['balmma@sysinf.ch', 'me@andremedeiros.info', 'hi@antw.io']

  s.homepage = 'https://github.com/gmodarelli/ruby-deepclone'
  s.license = 'MIT'

  s.extensions = ['ext/deep_clone/extconf.rb']

  s.files = Dir.glob('lib/**/*.rb') +
            Dir.glob('ext/**/*.{c,h,rb}')

  s.add_development_dependency('rake', '~> 12.3')
  s.add_development_dependency('rake-compiler', '~> 0.8.3')
  s.add_development_dependency('rspec', '~> 3.6')
end
