# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.5/halgent_0.0.5_darwin_arm64.tar.gz"
      sha256 "7870cc56afdf2c7500e3e777db3be8dbf2e8e0a8397552f54057862b6481beca"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.5/halgent_0.0.5_darwin_amd64.tar.gz"
      sha256 "93d39284e8864232193aa7f428fd47ceb672151d02e8b24399ab5f3caac0b72a"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.5/halgent_0.0.5_linux_arm64.tar.gz"
      sha256 "69940a39b124db55fc4f8aa6b0acf93535d40a6d2ec1c698dbacbee00d1df023"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.5/halgent_0.0.5_linux_amd64.tar.gz"
      sha256 "e271eedbf5d567603541bea6ffad33747b29ccc03502865714fef94d4a367b68"
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
