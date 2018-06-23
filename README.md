# Web scraper written in Haskell. Allows to download images from given website.
# Can be run concurrently. Works only with http protocol as HTTP library does not support https protocol.

# Works with ghc-7.8.4

# Create cabal sandbox:
cabal sandbox init

cabal install --only-dependencies <path_to_ghc-7.8.4_compiler>

# Build project using 4 jobs (using multiple jobs is optional)
cabal install -j4 -w <path_to_ghc-7.8.4_compiler>

# Run on one thread in cabal sandbox (unrecommended when program is compiled for multi-threads):
time .cabal-sandbox/bin/web-scraper "<website_address>" "<path_to_folder_for_downloaded_images>"

# Run in parallel on 4 threads in cabal sandbox:
time .cabal-sandbox/bin/web-scraper "<website_address>" "<path_to_folder_for_downloaded_images>" +RTS -N4

# example:
time .cabal-sandbox/bin/web-scraper "http://bitcoinist.com/" "/home/zuzanna/web-scraper-pictures/" +RTS -N4
