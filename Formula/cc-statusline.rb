# typed: false
# frozen_string_literal: true

# version + sha256 values are maintained by
# .github/workflows/bump-cc-statusline.yml on each cc-statusline release. The
# download URLs interpolate #{version}, so a bump (which sets `version` to the
# source release's exact tag) moves the URL and its sha256 together — there's no
# `latest/download` window where the on-disk asset could mismatch the pinned sha.
#
# brew audit flags the explicit `version` as "redundant with version scanned
# from URL" on Linux (where the versionless asset name lets it read the version
# out of the URL path). The version is NOT redundant on macOS — the darwin asset
# names end in `arm64`/`amd64`, so URL scanning yields a wrong version (e.g.
# `64`) and the explicit stanza is required. The tap-syntax CI therefore audits
# with `--except=version` (see .github/workflows/tests.yml).
class CcStatusline < Formula
  desc "Customizable Claude Code statusline with rate-limit curves and context bar"
  homepage "https://github.com/Team-MaRo/cc-statusline"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-darwin-arm64"
      sha256 "e9208583c1d857dac0c04117f2dde9c0d8822bbdfdd7c56319cb15a7e523a528"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-darwin-amd64"
      sha256 "e4686975ca07ef515fc7352f8d4a08c23a75032953c219ce6e91e5f3efbce5b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-linux-arm64-gnu"
      sha256 "16df5c48a58a10973a47ae8b23a0ba85752c3cc23a3cc537722557fa8e5dfd69"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-linux-amd64-gnu"
      sha256 "6ea2518ccf5fcbcf0c8ae2f06d05162423b6922bd1b5964d8238dfcb8ed31597"
    end
  end

  def install
    # The downloaded asset keeps its platform-suffixed name; install it as `cc-statusline`.
    bin.install Dir["cc-statusline-*"].first => "cc-statusline"
  end

  test do
    assert_match "cc-statusline", shell_output("#{bin}/cc-statusline --version")
  end
end
