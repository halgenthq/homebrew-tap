# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.13"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.13/halgent_0.0.13_darwin_arm64.tar.gz"
      sha256 "05b5adebc7f49ecc3b15bf78dc4af6acde48451f4076efbf09cfb9b06d6fc348"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.13/halgent_0.0.13_darwin_amd64.tar.gz"
      sha256 "30cc14366b37102688ff3893bff50b203a1a2535f16eceec06a77e18aeb451fd"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.13/halgent_0.0.13_linux_arm64.tar.gz"
      sha256 "f5490c2efdf5c6de00849ebbfa8f2318c35b5734523185a934edda61e9e5ca01"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.13/halgent_0.0.13_linux_amd64.tar.gz"
      sha256 "6b82961316a4dc95d15f1fd9700d131ae2812fb862da6134346f8d884876eca8"
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
