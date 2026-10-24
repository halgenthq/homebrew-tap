# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.4"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.4/halgent_0.0.4_darwin_arm64.tar.gz"
      sha256 "e639c7feb0a7cd141603d13db17724207ea03dedc4818d4b9c2c5e02f6005ed7"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.4/halgent_0.0.4_darwin_amd64.tar.gz"
      sha256 "c7de130ecef4618c40102bca6bb9917745e6a07dca315c65b56b47ca1ae3a21a"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.4/halgent_0.0.4_linux_arm64.tar.gz"
      sha256 "3e2df93ec4a8c8364d4d1e30fcdfed3a0a368ad130a88b1c5af8e1315ee419b4"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.4/halgent_0.0.4_linux_amd64.tar.gz"
      sha256 "2412c2152ae709b1f719afe7fc7d85bcf196e2943746efcd7eb7435c8dd65e90"
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
