# typed: false
# frozen_string_literal: true

# version + sha256 values are maintained by .github/workflows/bump.yml on each
# cc-statusline release. The placeholders below mean the formula won't install
# until the first bump has run against a published release.
class CcStatusline < Formula
  desc "Customizable Claude Code statusline with rate-limit curves and context bar"
  homepage "https://github.com/Team-MaRo/cc-statusline"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-darwin-arm64"
      sha256 "aa75b69ad014998f950ae91473b50c4db1fa9dd4a887e366e4ecc7f7ed83b49d"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-darwin-amd64"
      sha256 "f70af2274de901973b0649ea88a95066e143a37fb52eaa87b3198de92c963b07"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-linux-arm64-gnu"
      sha256 "cb1be0c57e9b18e56b428fcd6a12632a52369e1e14505c1555d17f7ef2bb2478"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-linux-amd64-gnu"
      sha256 "7ad8b30b52dc74c464cd53d0814a257a548127f00bcd8913e7fe5f262d2a46cb"
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
