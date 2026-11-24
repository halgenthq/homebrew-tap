# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.22"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.22/halgent_0.0.22_darwin_arm64.tar.gz"
      sha256 "c6ff0d259936e312581addf9f6346c07cdb977aa29e085bdc86c847006d2f0b3"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.22/halgent_0.0.22_darwin_amd64.tar.gz"
      sha256 "8555073ccb0607752951daee7ab643ca02a5334cdf633b9031d309969e1a697f"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.22/halgent_0.0.22_linux_arm64.tar.gz"
      sha256 "bac17a28b9e29631c31613e5bf69d1c7d39a153e98a7e372ef0eb8fa441d9001"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.22/halgent_0.0.22_linux_amd64.tar.gz"
      sha256 "f0ddd0a035945390b3c2c0636dfd139573741a5f7fbd6da32e850e5df1405e6f"
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
