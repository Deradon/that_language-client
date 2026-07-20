# CLAUDE.md — that_language-client

HTTP client for `that_language-service`, and a drop-in replacement for the
`that_language` gem: same `ThatLanguage` module, same methods, same return
types, but each call is an HTTP request instead of a local wordlist lookup.

Developed on Ruby 4.0.6 (`.tool-versions`); supports 3.1 and up.

## Commands

```sh
bundle install
bundle exec rspec       # 56 examples, 0 failures
bundle exec rubocop
```

The specs stub HTTP with webmock and never touch the network.

## Hard constraints

**The public API is a contract with two other repositories.** `that_language`
is the reference implementation, `that_language-service` exposes the same
surface as eight HTTP endpoints, and this gem mirrors it method for method.
Nothing enforces the parity. Adding a method to the core gem means adding a
query class here.

**Language names are symbols; language codes are strings.** That is the core
gem's contract, and it is what `Query#language_name` exists to preserve across
the JSON boundary. The one exception is `available`, which is keyed by symbol.
`to_h` is deliberately outside this — it returns the raw wire format.

This drifted once, undetected from 2016 until 2026-07-20: every language name
came back as a string and `available_languages` was unsorted. **The specs did
not catch it because they were written from the implementation** — the webmock
stubs asserted whatever the code already did, so they were green against a
client that did not match the gem it replaces.

If you change anything on the JSON boundary, verify against a real service
rather than the stubs:

```sh
docker run -p 4567:4567 that_language-service    # from that_language-docker
```

Then call every public method and compare the *types* against the core gem. The
two gems both define `ThatLanguage` and cannot be loaded into one process, so
this is two processes producing comparable output and a diff.

## Conventions

- Two-space indent, double-quoted strings in `require`s.
- **Do not mass-autocorrect RuboCop.** `.rubocop_todo.yml` grandfathers the
  pre-existing offences by design. If a cop fires on new code, fix that code; if
  the todo needs regenerating, use `rubocop --auto-gen-config`.
- **Explain a shared constraint once, in the shared place.** If the same comment
  would appear on several call sites, that is a signal to hoist the thing being
  explained — a helper method, a shared example — and put the explanation there.
  Repeating an explanation verbatim is noise: it costs a reader attention at
  every occurrence and it goes stale in more than one place at once.
  `Query#language_name` and `spec/support/private_readers.rb` are both this
  pattern.

## Gotchas

- **`ostruct` is a declared runtime dependency.** It stopped being a default gem
  in Ruby 4.0 and `DetailsQuery` requires it. Removing it means a bare
  `LoadError` on 4.x. (There is a `TODO` about replacing OpenStruct with a real
  result class; that would retire the dependency.)
- **`rspec-its` 2.0 resolves the subject with `public_send`**, so `its(:foo)`
  cannot reach a private reader. Use the shared examples in
  `spec/support/private_readers.rb` rather than widening the API to suit a
  matcher.
- **The default host is `localhost:4567`** — what the service container listens
  on. It used to be a hosted domain, which went offline and left the gem inert
  out of the box. Prefer a default the reader can start themselves over one that
  depends on somebody else's DNS.
- `Config#host` accepts a bare host, a `host:port`, or a full base URL. Without a
  scheme, `http` is assumed.

## Context

This is a public GitHub repository — do not push without asking.
