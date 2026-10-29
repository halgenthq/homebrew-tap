# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.8/halgent_0.0.8_darwin_arm64.tar.gz"
      sha256 "908d729088859eeb7a1eb39a4bc3f9379aa6ba6ced18c0cd9a21596fc2dde4ae"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.8/halgent_0.0.8_darwin_amd64.tar.gz"
      sha256 "949ec213a3b3330b4e8fff72b3c1f20ecade294e5aeff8b1c2d10871a5530540"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.8/halgent_0.0.8_linux_arm64.tar.gz"
      sha256 "22154af74b0181551db2ad0467469c7b97c3f758fea202b5c69c4c23650751db"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.8/halgent_0.0.8_linux_amd64.tar.gz"
      sha256 "5298c047f6a08d42746a4cccfae0af73094269cde17fa62d3301032cf9197e9d"
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
