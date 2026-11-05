# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.12"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.12/halgent_0.0.12_darwin_arm64.tar.gz"
      sha256 "11d83f5869ad4ef5a917e576938980fdcdbaa583de0f95b5afbf42af0b727610"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.12/halgent_0.0.12_darwin_amd64.tar.gz"
      sha256 "59aa7e9b261d422358a57071b1f5cf696de511a71adcf8ab06975740dfb7cf2d"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.12/halgent_0.0.12_linux_arm64.tar.gz"
      sha256 "b4840823aa61810eda080156e104ec1f89fe424d0605f56b06de4cccdfefae83"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.12/halgent_0.0.12_linux_amd64.tar.gz"
      sha256 "885357d0775aed637fab97913ce78192fb74ccd9db9caa2142eeb0fcbbc5fb1b"
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
