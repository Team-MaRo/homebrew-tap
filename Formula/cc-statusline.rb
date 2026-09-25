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
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-darwin-arm64"
      sha256 "b5769f3b6d47f755def7b7f35233136aa862ee3d1116fb5ba31bbfdb45160f28"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-darwin-amd64"
      sha256 "a66f53cd9a9e55fc9bd2e48fc1b298765082f3fe88e4930837e95b7e40475488"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-linux-arm64-gnu"
      sha256 "f234e8d4bbd9363259095a20cb972dc0dac5e5900c1d7d20e611a66bae0f4972"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/download/#{version}/cc-statusline-linux-amd64-gnu"
      sha256 "66546e95bb47b78b2d37da6b95611585dc4f797bd3b4e8543ba5281b94402812"
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
