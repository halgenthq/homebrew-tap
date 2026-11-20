# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.19"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.19/halgent_0.0.19_darwin_arm64.tar.gz"
      sha256 "81ae7e40d8f01bd553b2f1fb9a6ee7ce6283d51ae6543736f35b595b185a5b25"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.19/halgent_0.0.19_darwin_amd64.tar.gz"
      sha256 "bed904693019c5959ce9566dfa82aaaa8234c0f1781185c78028bcac6157acdf"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.19/halgent_0.0.19_linux_arm64.tar.gz"
      sha256 "bb272957d6df9713edce9da691913657813405431fc3c4d5ec6109864d8ece2c"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.19/halgent_0.0.19_linux_amd64.tar.gz"
      sha256 "a119335ad30300ef61858cb7dd97e94965605e52045adf50b39f2f7f92029695"
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
