$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "auth"
  s.version     = Auth::VERSION
  s.authors     = ["Calvin McElroy"]
  s.email       = ["fourwallsstudio@gmail.com"]
  s.homepage    = "https://github.com/fourwallsstudio/auth_engine"
  s.summary     = "auth engine"
  s.description = "auth engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "orm_adapter"
  s.add_dependency "bcrypt", "~> 3.0"
  s.add_dependency "jwt"
  s.add_dependency "whenever"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry"
end
