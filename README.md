# DetectLanguage::Client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'detect_language-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install detect_language-client

## Examples

```
text = "This is just a random english sentence."

## == Language

  ThatLanguage.language(text)
  # => "English"


## == LanguageCode

  ThatLanguage.language_code(text)
  # => "en"


## == Detect

  detect = ThatLanguage.detect(text)
  # => #<ThatLanguage::Client::DetectQuery:...

  detect.language
  # => "English"

  detect.language_code
  # => "en"

  detect.confidence
  # => 0.5631093821386951

  detect.to_h
  # => {"language"=>"English", "language_code"=>"en", "confidence"=>0.5631093821386951}


## == Details

  details = ThatLanguage.details(text)
  # => #<ThatLanguage::Client::DetailsQuery:...

  winner = details.winner
  # => OpenStruct

    winner.language
    # => "English"

    winner.language_code
    # => "en"

    winner.confidence
    # => 0.5631093821386951

    winner.value
    # => 3.9417656749708656

    winner.hit_ratio
    # => 0.8571428571428571

    winner.hit_count
    # => 6

    winner.words_count
    # => 7

  results = details.results
  # => [#<OpenStruct, #<OpenStruct, ...]

  details.to_h
  # =>
  # {
  #   "results" => [
  #     {
  #       "language"=>"English",
  #       "language_code"=>"en",
  #       "confidence"=>0.5631093821386951,
  #       "value"=>3.9417656749708656,
  #       "hit_ratio"=>0.8571428571428571,
  #       "hit_count"=>6,
  #       "words_count"=>7
  #     },
  #     {
  #       "language"=>"Sundanese",
  #       "language_code"=>"su",
  #       "confidence"=>0.26101716738575337,
  #       "value"=>1.8271201717002734,
  #       "hit_ratio"=>0.7142857142857143,
  #       "hit_count"=>5,
  #       "words_count"=>7
  #     },
  #     # ...
  #   ]
  # }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake rspec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Deradon/that_language-client.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

