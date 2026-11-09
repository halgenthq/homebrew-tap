# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.16"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.16/halgent_0.0.16_darwin_arm64.tar.gz"
      sha256 "9c262f230b6ff20199d87a99197027034a4e5744fce07b3e4fa4fa8a68126548"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.16/halgent_0.0.16_darwin_amd64.tar.gz"
      sha256 "b3771a711104b9a99711ef1a0104315ce9c7979e0206e494342c960b674a3ee6"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.16/halgent_0.0.16_linux_arm64.tar.gz"
      sha256 "2b77b4bbc56ecf3355e350417ec224b476776e7c25b87b79c962690fc1bbe1d1"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.16/halgent_0.0.16_linux_amd64.tar.gz"
      sha256 "53e7859e015e27b6adc75ef7fdbb43a769de8b3a1822df7db70ae73e11202cf7"
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
