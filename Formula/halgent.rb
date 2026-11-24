# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb.
# A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.23"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.23/halgent_0.0.23_darwin_arm64.tar.gz"
      sha256 "7b4e50ae56bfdf6c543b7811f3a228b9931ca4e58553b69a62fa702fede2ccf9"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.23/halgent_0.0.23_darwin_amd64.tar.gz"
      sha256 "f095a4fc17a70023da8632da677b24b3dd7d0398e1f6778aaf947d86759f6004"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.23/halgent_0.0.23_linux_arm64.tar.gz"
      sha256 "af893395b3479f0360722a6ffc57d27031e659378bdbe8fc0791505f9f13b4b9"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.23/halgent_0.0.23_linux_amd64.tar.gz"
      sha256 "04ce6062b60c90ba3fe3dc9c348d3661b34dc27a40afe4ba8f9d6c7372fd7f69"
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
