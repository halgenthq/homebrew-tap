# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.25"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.25/halgent_0.0.25_darwin_arm64.tar.gz"
      sha256 "dc8b178a1601591473b917309908451070287437c2dfe48c42981a9800dc9086"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.25/halgent_0.0.25_darwin_amd64.tar.gz"
      sha256 "5fece3e37af4a8ebd0e9a1a65594e025d4082e6e011869e30557698604c1e530"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.25/halgent_0.0.25_linux_arm64.tar.gz"
      sha256 "b2a7c23fde7c72bc2d77a494b194a9a185d0f25344a255b3c87b5eb708315f67"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.25/halgent_0.0.25_linux_amd64.tar.gz"
      sha256 "3e88228048f17cdc21d6df1d216318d2604a47827a8c1b11a8a0daf551ff19d3"
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
