# Auth
Auth is a rails enigne for running auth with json_web_tokens

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'auth', git: 'git://github.com/fourwallsstudio/auth_engine.git'
```

And then execute:
```bash
$ bundle
```

init auth:
```bash
$ rails g auth:install
```

create user model:
```bash
$ rails g auth user
$ rails db:migrate
```

use blacklist tokens:

in `config/initializers/auth.rb`
```ruby
config.blacklist_tokens = true
```

note: requires 'rails-redis' and 'redis-namespace'

recomended to use 'sidekiq' for activejob queue adapter

set up cleanup_blacklist_tokens_job:
```bash
$ rails g auth:schedule
```
in `config/schedule.rb`
set frequency of cleanup

to run:
```bash
$ whenever --update-crontab
```
to stop:
```bash
$ whenever --clear-crontab
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
