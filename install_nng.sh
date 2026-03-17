#!/usr/bin/env bash
set -euo pipefail

# Install nng with TLS support and the Ruby nng gem
# Requires: Homebrew, rbenv with Ruby installed, cmake, ninja

# 1. Install dependencies
brew install nng mbedtls@3 cmake ninja

# 2. Build nng from source with TLS enabled (Homebrew bottle lacks TLS)
cd /tmp
rm -rf nng
git clone --branch v1.11 --depth 1 https://github.com/nanomsg/nng.git
cd nng
mkdir build && cd build
cmake -G Ninja \
  -DNNG_ENABLE_TLS=ON \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_POLICY_DEFAULT_CMP0144=NEW \
  -DMBEDTLS_ROOT=$(brew --prefix mbedtls@3) \
  -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=OFF \
  ..
ninja
sudo ninja install

# 3. Install the nng gem, pointing at the custom-built library
gem install nng -- --with-nng-dir=/usr/local

# 4. Fix runtime library path on the compiled bundle
BUNDLE_PATH=$(find "$(ruby -e 'puts Gem.dir')/gems/nng-"*/lib/nng \
  -name 'rbnng.bundle' 2>/dev/null | head -1)
if [ -n "$BUNDLE_PATH" ]; then
  install_name_tool -add_rpath /usr/local/lib "$BUNDLE_PATH"
  echo "Patched rpath on $BUNDLE_PATH"
else
  echo "WARNING: Could not find rbnng.bundle to patch"
fi

# 5. Install Ruby dependencies for the TLS example
gem install async localhost

# 6. Cleanup
rm -rf /tmp/nng

echo "Done. Test with: ruby -e \"require 'nng'; puts NNG::VERSION\""
