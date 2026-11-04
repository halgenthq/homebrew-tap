# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.11"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.11/halgent_0.0.11_darwin_arm64.tar.gz"
      sha256 "9cef93becb4a186f8a90ffeb63dea96478d0f9955de57862d97d545ca530f27d"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.11/halgent_0.0.11_darwin_amd64.tar.gz"
      sha256 "dc4ca5fe3564b590a8d97e139838d49374ae71dd2688062d9ceefaa5107c8b11"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.11/halgent_0.0.11_linux_arm64.tar.gz"
      sha256 "b2e9cbba596a9ab31a748a5d63770478edf3ae61609ac1b753bebb37427b3c50"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.11/halgent_0.0.11_linux_amd64.tar.gz"
      sha256 "9945f8164d5168b8527e99bd82d3fdb76415f873749580781e2591ab27af5c43"
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
