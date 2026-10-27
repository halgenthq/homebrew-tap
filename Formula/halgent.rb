# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.7/halgent_0.0.7_darwin_arm64.tar.gz"
      sha256 "6d7479e3586cc39c66ea069ed423fe3561eec08a0c89f3395f36aacc3332b80e"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.7/halgent_0.0.7_darwin_amd64.tar.gz"
      sha256 "443004f2f6bb2abb31f7f0825395a36fccdedfdf273b729e2263be5e5a09d32e"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.7/halgent_0.0.7_linux_arm64.tar.gz"
      sha256 "b7db70f38ff4f13603dde2945669a2e75d615b95e09cfbe772dfbbaa1dd51288"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.7/halgent_0.0.7_linux_amd64.tar.gz"
      sha256 "8c6519c190b25583f6f9438ecc0fc4d9586370867284f65757662d9168d49f8c"
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
