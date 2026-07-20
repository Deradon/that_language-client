# The contract probe.
#
# This one file is run twice, in two separate processes: once against the core
# that_language gem and once against this client. Both define the ThatLanguage
# module, so they cannot be loaded into the same process -- that is by design,
# the client *is* a replacement rather than a companion, and it is why the
# mechanism is two processes and a diff rather than one shared spec suite.
#
# Nothing in here branches on which implementation is loaded. If it did, it
# would stop being a comparison.
#
# The output format is one `key<TAB>value.inspect` line per probe. `inspect` is
# doing the real work: `:German` and `"German"` render differently, so a
# symbol/string drift shows up as a plain text difference with no explicit type
# checking anywhere. The contract being asserted is that language *names* are
# symbols and language *codes* are strings.
#
# Two properties fall out of writing it this way, both deliberate:
#
#   - `api_version` is excluded by construction. It exists only on the client
#     and has no core-gem counterpart, and since this file only ever calls
#     methods the core gem has, it is never reached. There is no exclusion list
#     to keep in sync.
#
#   - `details.winner` is compared by value, not by class. The core gem returns
#     a ThatLanguage::Result and the client an OpenStruct; that difference is a
#     documented, accepted TODO rather than drift, so reading attributes with
#     `public_send` is what keeps this test from failing on day one over a
#     difference nobody intends to change.

require "that_language"

# Long enough to detect unambiguously, short enough that the expected winner is
# obvious to a human reading a failing diff.
TEXT = "Guten Tag mein Freund, wie geht es dir heute".freeze

probes = []
probe = ->(key, value) { probes << "#{key}\t#{value.inspect}" }

probe.call("language", ThatLanguage.language(TEXT))
probe.call("language_code", ThatLanguage.language_code(TEXT))

detected = ThatLanguage.detect(TEXT)
probe.call("detect.language", detected.language)
probe.call("detect.language_code", detected.language_code)
probe.call("detect.confidence", detected.confidence)

details = ThatLanguage.details(TEXT)

winner = details.winner
%i[language language_code confidence value hit_ratio hit_count words_count].each do |attribute|
  probe.call("details.winner.#{attribute}", winner.public_send(attribute))
end

# Ranking is part of the contract, not just the winner. The core gem returns
# results sorted descending by value; if the client ever reverts to trusting the
# order the service happened to send, these lines are what notices.
results = details.results
probe.call("details.results.size", results.size)
probe.call("details.results.language_codes", results.map(&:language_code))
probe.call("details.results.descending_by_value?", results.map(&:value) == results.map(&:value).sort.reverse)

available = ThatLanguage.available
probe.call("available.size", available.size)
probe.call("available", available.sort_by { |code, _| code.to_s }.to_h)

# The `sorted?` lines are not redundant with the diff. A diff alone only proves
# the two implementations agree with each other -- they could agree while both
# being unsorted. Sortedness is part of the contract the core gem keeps, and
# `available_languages` really did come back unsorted from the client for ten
# years, so it is asserted rather than inferred.
languages = ThatLanguage.available_languages
probe.call("available_languages", languages)
probe.call("available_languages.sorted?", languages == languages.sort)

codes = ThatLanguage.available_language_codes
probe.call("available_language_codes", codes)
probe.call("available_language_codes.sorted?", codes == codes.sort)

puts probes
