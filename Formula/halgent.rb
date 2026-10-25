# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.6"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.6/halgent_0.0.6_darwin_arm64.tar.gz"
      sha256 "6bf761feb5e4beb000078f05cb76d9b5c88fb4f5b69b65d8d35e6d6048c43390"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.6/halgent_0.0.6_darwin_amd64.tar.gz"
      sha256 "2116a26709dab66e5f8d687ea29c06ba484c7259d59def4cd4906d95e35441ea"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.6/halgent_0.0.6_linux_arm64.tar.gz"
      sha256 "16e7c9d9bfd227d2e04cbae6fe98eecfb9701dd5b9c93b48950d2ea5678605ec"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.6/halgent_0.0.6_linux_amd64.tar.gz"
      sha256 "b44442399a5f08a15bc41326b94792da835a8361d4de83e792a075a5694b0962"
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
