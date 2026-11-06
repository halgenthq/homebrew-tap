# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.14"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.14/halgent_0.0.14_darwin_arm64.tar.gz"
      sha256 "20e0b541e05aa36d936a057b4d46c008adf9baa5070cebef34dc7aa171c7e71d"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.14/halgent_0.0.14_darwin_amd64.tar.gz"
      sha256 "41f6f298b84b6f10d341d9a80afd3b5340612e47bffb40257e19af9cbd1f51a0"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.14/halgent_0.0.14_linux_arm64.tar.gz"
      sha256 "835491f2151cf110392b848f097a6a4c3bbde77e776c28313e767cda7f266878"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.14/halgent_0.0.14_linux_amd64.tar.gz"
      sha256 "a49bfe07e9f2c7cebd5aa48350d401d3f1c6de24c66d01fb8767710f9138eccf"
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
