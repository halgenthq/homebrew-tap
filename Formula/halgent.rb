# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.10"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.10/halgent_0.0.10_darwin_arm64.tar.gz"
      sha256 "2f3031ab5962822b2dddf89b4a917a399bd62011efe35f128f3b5380af2dfdc4"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.10/halgent_0.0.10_darwin_amd64.tar.gz"
      sha256 "f0d0953b41c1fa1acb8fac730a684fdeb89b3b47bda3c0758bced7f1b48ad2ee"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.10/halgent_0.0.10_linux_arm64.tar.gz"
      sha256 "d2fbcaa74c961048930f1a8f02e06f76995b6d0b5cab2ee35c1934cfe32e735b"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.10/halgent_0.0.10_linux_amd64.tar.gz"
      sha256 "5394aa1c83c78a213b13a49932e356fc3040a6d6f11e8a69e659fe2651eceab7"
    end
  end

  def install
    bin.install "halgent"
  end

  def caveats
    s = <<~EOS
      halgent run -- claude needs sandbox-runtime (srt) 0.0.79, which brew cannot install:
        npm install -g --ignore-scripts @anthropic-ai/sandbox-runtime@0.0.79
    EOS
    on_linux do
      s += <<~EOS
        It also needs bubblewrap from your system packages, whose AppArmor profile Ubuntu requires:
          sudo apt-get install bubblewrap
      EOS
    end
    s + "Check the machine with: halgent doctor\n"
  end

  test do
    assert_match "halgent #{version}", shell_output("#{bin}/halgent version")
  end
end
