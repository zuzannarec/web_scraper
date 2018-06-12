# web_scraper

# Web scraper written in Haskell. Can be run concurrently.

# Create cabal sandbox:
cabal sandbox init
cabal install --only-dependencies
# Build project using 4 jobs (using multiple jobs is optional)
cabal install -j4

# Run on one thread in cabal sandbox (unrecommnded when program is compiled for multi-threads):
time .cabal-sandbox/bin/web-scraper "<website_address"

# Run in parallel on 7 threads in cabal sandbox:
time .cabal-sandbox/bin/web-scraper "website_address" +RTS -N7
