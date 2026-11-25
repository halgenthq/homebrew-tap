# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.24"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.24/halgent_0.0.24_darwin_arm64.tar.gz"
      sha256 "669a02d8ecc83775bbea7287d8bf99db9983fae3e6754794ff4a21830acb6436"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.24/halgent_0.0.24_darwin_amd64.tar.gz"
      sha256 "a11cd61e0e358116531c5caf77e90ef8177bcc4bc09b6522c24036af0489a683"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.24/halgent_0.0.24_linux_arm64.tar.gz"
      sha256 "ab62c637c09bc10c4feca59e0e8ec0dc215dd9ab7e8d0bc632545489d3c27f4b"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.24/halgent_0.0.24_linux_amd64.tar.gz"
      sha256 "e8ab8680fcdf333c5adaca4158352f7527135d99e726d55baa33d4e239e74c40"
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
