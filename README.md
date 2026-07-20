[![CI](https://github.com/Deradon/that_language-client/actions/workflows/ci.yml/badge.svg)](https://github.com/Deradon/that_language-client/actions/workflows/ci.yml)

# ThatLanguage::Client

A drop-in replacement for the [`that_language`][core] gem that answers each call
over HTTP against a [`that_language-service`][service] instance, instead of
loading wordlists locally.

Same `ThatLanguage` module, same methods, same return types — but no 16 MB of
wordlists in your process and no cold-start cost.

[core]: https://github.com/Deradon/that_language
[service]: https://github.com/Deradon/that_language-service

## Installation

```ruby
gem 'that_language-client'
```

Requires Ruby 3.1 or later.

> **Upgrading from 0.1.2?** Return types changed. This gem is meant to be a
> drop-in replacement for [`that_language`][core], and it was not: language
> *names* are symbols and language *codes* are strings in the core gem, but
> 0.1.2 returned strings throughout and left `available_languages` unsorted.
> Seven of fourteen public methods were affected. If your code compares those
> results against strings, it needs updating. `to_h` still returns the raw
> wire format.

## You need a service to talk to

This gem is a client and does nothing on its own. The default host is
`localhost:4567`, which is what the [service container][service] listens on:

```sh
docker run -p 4567:4567 that_language-service
```

Point it somewhere else with:

```ruby
ThatLanguage::Client.configure do |config|
  config.host = "https://api.example.com"
end
```

The host may be a bare `example.com`, a `host:port`, or a full base URL. Without
a scheme, `http` is assumed.

> Earlier versions defaulted to a hosted domain. That host went offline, which
> left the gem inert out of the box with nothing to show for it but a connection
> error. The default is now something you can start yourself.

## Examples

```ruby
text = "This is just a random english sentence."

ThatLanguage.language(text)
# => :English

ThatLanguage.language_code(text)
# => "en"

detect = ThatLanguage.detect(text)
detect.language        # => :English
detect.language_code   # => "en"
detect.confidence      # => 0.5631093821386951
detect.to_h            # => {"language"=>"English", ...}  # raw wire format

details = ThatLanguage.details(text)
winner = details.winner
winner.language        # => :English
winner.language_code   # => "en"
winner.confidence      # => 0.5631093821386951
winner.value           # => 3.9417656749708656
winner.hit_ratio       # => 0.8571428571428571
winner.hit_count       # => 6
winner.words_count     # => 7
details.results        # => [#<OpenStruct ...>, ...]

ThatLanguage.available
# => { ak: :Akan, am: :Amharic, ... }

ThatLanguage.available_languages
# => [:Akan, :Amharic, ...]

ThatLanguage.available_language_codes
# => [:ak, :am, ...]

ThatLanguage.api_version   # the *remote service's* version
# => "0.1.2"
```

### Symbols and strings

Following the core gem: **language names are symbols, language codes are
strings.** `available` is keyed by symbol with symbol values, and both
`available_languages` and `available_language_codes` come back sorted.

JSON has no symbols, so this gem converts at the boundary. Before this was
fixed, every one of those returned a string and `available_languages` was
unsorted — which meant the gem was not actually a drop-in replacement. `to_h`
is the exception and still gives you the raw wire format.

## Development

```sh
bundle install
bundle exec rspec     # 56 examples
bundle exec rubocop
```

Tested on Ruby 3.2, 3.3 and 4.0. The specs stub HTTP with `webmock` and never
touch the network.

To check parity against a real service rather than stubs, start the container
and exercise the gem against it — that is how the symbol/string drift above was
found, and stubs alone would not have caught it, because the stubs encoded the
same wrong assumption the code did.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/Deradon/that_language-client. This project is intended to be
a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
