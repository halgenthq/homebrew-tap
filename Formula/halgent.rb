# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.9/halgent_0.0.9_darwin_arm64.tar.gz"
      sha256 "2e2a4b03b750b84735010271f952004a388901d3fe9fbfcbb1198e49889c0d86"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.9/halgent_0.0.9_darwin_amd64.tar.gz"
      sha256 "d0c7190c2baef82a729b03b78a7ea7b93065f48a8b293e0c53755a2202b08a5a"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.9/halgent_0.0.9_linux_arm64.tar.gz"
      sha256 "741f8de3eff913a29f1e26e1e875cff8d029f3a80031213a256ecefe99231a78"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.9/halgent_0.0.9_linux_amd64.tar.gz"
      sha256 "b1f3d855a3553162ec22ff2e89ad324bd1d91386b7abadb91fdade67c0055968"
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
