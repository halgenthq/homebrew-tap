# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.20"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.20/halgent_0.0.20_darwin_arm64.tar.gz"
      sha256 "4210001228bc114ccfd0c270f3f2d301278e3b8147fb6723615f67c2660510bf"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.20/halgent_0.0.20_darwin_amd64.tar.gz"
      sha256 "4d08bc0a814966868a43ae474fba33e221f54fde763af4b85fe039d89a1d4bfb"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.20/halgent_0.0.20_linux_arm64.tar.gz"
      sha256 "679383d14a7e862e5e89783770a786795c00b8e78ff0a1b50b0bf44c43429df0"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.20/halgent_0.0.20_linux_amd64.tar.gz"
      sha256 "174565c08d75d9a422ef179b2a7e752cf31d24443476519981b2cbd462595256"
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
