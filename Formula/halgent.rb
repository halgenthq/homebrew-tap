# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.21"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.21/halgent_0.0.21_darwin_arm64.tar.gz"
      sha256 "44dc78f76974d178c1533bbbe2d16986b5bf5ae3f1626d77d0d2ea9771aef282"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.21/halgent_0.0.21_darwin_amd64.tar.gz"
      sha256 "86884cfc26bea30b5a728c344e92044c07c80cc8b0c5ab6dc665b7fa660593c9"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.21/halgent_0.0.21_linux_arm64.tar.gz"
      sha256 "b97e1fc4f634af20e3bc5c02cdf595d98866711abd840d0b7f4fec2040d00059"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.21/halgent_0.0.21_linux_amd64.tar.gz"
      sha256 "ecad00c8c603674226fbe75c94f84b8317fed0c231cdcbe6b929f71f6482dbe3"
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
