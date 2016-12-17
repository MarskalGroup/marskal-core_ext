# Marskal::CoreExt

This gem contains several extensions to the core classes of Ruby. 
This was developed using Ruby 2.0 and Ruby 2.1 but many of the extension will likely work with other versions.

The legacy gem was [marskal-core-extensions](https://rubygems.org/gems/marskal-core-extensions). This gem is no longer being maintained. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marskal-core_ext'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marskal-core_ext

## Usage
#### Review documentation for each classes new methods. This gem adds new methods to the following classes:
* [<tt>Array</tt>, <tt>Date</tt>, <tt>File</tt>, <tt>Hash</tt>, <tt>I18n</tt>, <tt>String</tt>]

###### Requires:
```ruby
  # There 2 ways to require all modules in this gem:
  require 'marskal/core_ext/all'  # This is recommended way
  require 'marskal/core_ext'      # However this works as well
  
  # To use only selected modules, just simply require one or more as needed
  require 'marskal/core_ext/array'
  require 'marskal/core_ext/date'
  require 'marskal/core_ext/file'
  require 'marskal/core_ext/hash'
  require 'marskal/core_ext/i18n'
  require 'marskal/core_ext/string'
  # etc
```
	
## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` or just `rake` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

<b>Note:</b> If on Microsoft Windows or `bin/console` is not working then try this:

```
$  irb -Ilib -r 'marskal/core_ext'
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Documentation
Documentation is available in both <tt>Yard</tt> and <tt>Rdoc</tt> formats.

To install both formats, use the following <tt>rake</tt> command.

    # Note: files will be built in docs/yard and docs/rdoc
    $ rake marskal:rdoc:generate_all_docs

## Contributing

Bug reports and pull requests are welcome on GitHub at (https://github.com/MarskalGroup/marskal-core_ext). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

