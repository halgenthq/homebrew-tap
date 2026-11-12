# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.17"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.17/halgent_0.0.17_darwin_arm64.tar.gz"
      sha256 "67e4dadce334fa69f60b94328ca1a6a4ab1b4f290eee7263547a5aeda7a834d7"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.17/halgent_0.0.17_darwin_amd64.tar.gz"
      sha256 "a4e5b6d743377eea09395b9615c9e9035faa9c716a1c1dc7cfc720492d486f77"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.17/halgent_0.0.17_linux_arm64.tar.gz"
      sha256 "6e3437cec7e49196cbddad7b3e5b25574a27a165fe7c8eabf889ca3c13e16a12"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.17/halgent_0.0.17_linux_amd64.tar.gz"
      sha256 "d07df7205faa7a8540966de4124c4c6b225fbc6a500c5507d6aa9e963d21e4e5"
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
