## 0.2.0 [☰](https://github.com/Deradon/that_language-client/compare/v0.1.2...v0.2.0) (2026-07-20)

Revival release. 0.1.2 dates from 2016 and does not install on Ruby 3 or later.

### Breaking changes

* **Return types now match the core gem.** This gem claims to be a drop-in
  replacement for `that_language`, and it was not: language *names* are symbols
  and language *codes* are strings in the core gem, but this gem returned
  strings throughout, and `available_languages` came back unsorted. Seven of
  fourteen public methods disagreed, and had since 2016. Corrected at the JSON
  boundary; `to_h` still exposes the raw wire format. Code that compares
  against strings will need updating — which is precisely the incompatibility
  that made this gem not a drop-in replacement in the first place.
* `required_ruby_version` is now `>= 3.1`, so the gem no longer installs on
  Ruby 2.x.
* The default host is now `localhost:4567`. The previous default pointed at
  `that-language-api.ruby-on-rails.guru`, which no longer resolves. A default
  you can start yourself cannot rot; point it elsewhere with
  `ThatLanguage::Client.configure { |c| c.host = "..." }`.

### Bug fixes

* `ostruct` is declared as a runtime dependency. It stopped being a default gem
  in Ruby 4.0, where `DetailsQuery` requiring it is a bare `LoadError`.

### Enhancements

* Gemspec: dropped the `bundler ~> 1.10` development dependency that made
  `bundle install` unsolvable, and modernised the remaining pins.
* The specs no longer encode the implementation's own assumptions — they assert
  the core gem's contract, which is why stubs alone never caught the drift
  above.
* CI moved from Travis to GitHub Actions, covering Ruby 3.1 through 4.0.

## 0.1.2 [☰](https://github.com/Deradon/that_language-client/compare/v0.1.1...v0.1.2) (2016-04-12)

## 0.1.1 [☰](https://github.com/Deradon/that_language-client/compare/v0.1.0...v0.1.1) (2015-12-07)

## 0.1.0 (2015-12-07)

* Initial release
