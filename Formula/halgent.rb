# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.3/halgent_0.0.3_darwin_arm64.tar.gz"
      sha256 "f5897e689c45fa0a57147b7140674600ec4353b260eff13af97886c9c2ea1d38"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.3/halgent_0.0.3_darwin_amd64.tar.gz"
      sha256 "8640a516b19d8ffc7d8b34665c09c7e80243c8d19c969282183723779a7d7400"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.3/halgent_0.0.3_linux_arm64.tar.gz"
      sha256 "b3b76ce46705e3e09e21df468fe17807d7e8442faf7ffbc1c72df040595c95b1"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.3/halgent_0.0.3_linux_amd64.tar.gz"
      sha256 "e8f4e16673328a1b5c30a1b03b9010cc4643337d96d138fbc8c146160d4825a2"
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
