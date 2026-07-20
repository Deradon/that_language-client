# Rackup for the contract test's throwaway service instance.
#
# The published that_language-service gem ships its own config.ru, but this one
# adds the boot-time cache warm that the deployed image performs -- wordlists
# load lazily and memoise at module level (~0.9 s cold). Paying it here means a
# service that answers at all is warm, so the probe never eats it mid-run.
require "that_language/service"

warn "[INFO] Warming the wordlist cache"
ThatLanguage.language_code("Hello world!")
warn "[INFO] Cache warm, #{ThatLanguage.available.size} languages available."

run ThatLanguage::Service::Application
