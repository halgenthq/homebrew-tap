# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.1/halgent_0.0.1_darwin_arm64.tar.gz"
      sha256 "23c7bcb4a3321bf93a69b5c9299aeedd124dece8d01f280d0c9a84a4b767732d"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.1/halgent_0.0.1_darwin_amd64.tar.gz"
      sha256 "488bd81c13d40b7aaa2f4fa2fc5c40ff40dcf87675e81a5f598ff99a9a15cab5"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.1/halgent_0.0.1_linux_arm64.tar.gz"
      sha256 "30c8bd32d2fe76605a8937c876c94da314ed5f5853cb25984e9438be5c456e6f"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.1/halgent_0.0.1_linux_amd64.tar.gz"
      sha256 "b5bdca440cc7c4a57e00d96347f6c162d45d0e107e80ea9832df82f9c46e7fd5"
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
