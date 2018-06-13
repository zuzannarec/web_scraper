# Web scraper written in Haskell. Can be run concurrently. Works only with http protocol as HTTP library does not support https protocol.

# Create cabal sandbox:
cabal sandbox init

cabal install --only-dependencies

# Build project using 4 jobs (using multiple jobs is optional)
cabal install -j4

# Run on one thread in cabal sandbox (unrecommnded when program is compiled for multi-threads):
time .cabal-sandbox/bin/web-scraper "<website_address>" "<path_to_folder_for_downloaded_images>"

# Run in parallel on 4 threads in cabal sandbox:
time .cabal-sandbox/bin/web-scraper "<website_address>" "<path_to_folder_for_downloaded_images>" +RTS -N4

example:
time .cabal-sandbox/bin/web-scraper "http://bitcoinist.com/" "~/web-scraper-pictures/" +RTS -N4
