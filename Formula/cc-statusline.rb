# typed: false
# frozen_string_literal: true

# version + sha256 values are maintained by .github/workflows/bump.yml on each
# cc-statusline release. The placeholders below mean the formula won't install
# until the first bump has run against a published release.
class CcStatusline < Formula
  desc "Customizable Claude Code statusline with rate-limit curves and context bar"
  homepage "https://github.com/Team-MaRo/cc-statusline"
  version "0.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-darwin-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-linux-arm64-gnu"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-linux-amd64-gnu"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
