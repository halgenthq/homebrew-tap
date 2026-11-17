# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.18"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.18/halgent_0.0.18_darwin_arm64.tar.gz"
      sha256 "ceba098abed75674ec9290a601a10e4925e0016d33960a2f7994cb9c0132cec0"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.18/halgent_0.0.18_darwin_amd64.tar.gz"
      sha256 "653ed521fcf294a05f12ad76fc6454b813b7de2cc1d3eab0bff5a6c8a462e61a"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.18/halgent_0.0.18_linux_arm64.tar.gz"
      sha256 "633de3d8e21cafef401b9685c349cecd6c866d31ceed11f6bd401499e5df3bda"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.18/halgent_0.0.18_linux_amd64.tar.gz"
      sha256 "db5928c6bc4476f79e3e87800d913211b1e414ef955f0368b1cbf6f6db9ef3e2"
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
