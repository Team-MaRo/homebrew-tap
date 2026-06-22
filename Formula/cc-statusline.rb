# typed: false
# frozen_string_literal: true

# version + sha256 values are maintained by .github/workflows/bump.yml on each
# cc-statusline release. The placeholders below mean the formula won't install
# until the first bump has run against a published release.
class CcStatusline < Formula
  desc "Customizable Claude Code statusline with rate-limit curves and context bar"
  homepage "https://github.com/Team-MaRo/cc-statusline"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-darwin-arm64"
      sha256 "e9208583c1d857dac0c04117f2dde9c0d8822bbdfdd7c56319cb15a7e523a528"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-darwin-amd64"
      sha256 "e4686975ca07ef515fc7352f8d4a08c23a75032953c219ce6e91e5f3efbce5b6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-linux-arm64-gnu"
      sha256 "16df5c48a58a10973a47ae8b23a0ba85752c3cc23a3cc537722557fa8e5dfd69"
    end
    on_intel do
      url "https://github.com/Team-MaRo/cc-statusline/releases/latest/download/cc-statusline-linux-amd64-gnu"
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
