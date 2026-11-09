# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.15"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.15/halgent_0.0.15_darwin_arm64.tar.gz"
      sha256 "e55c975f8a406c6611ec2d3ac2d7751705e4e7eb41c060413592ce2a6e184828"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.15/halgent_0.0.15_darwin_amd64.tar.gz"
      sha256 "48151fa4dddf1d3b53353815cf015d1954871e35ad0e13c6b71c243966c6a7c9"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.15/halgent_0.0.15_linux_arm64.tar.gz"
      sha256 "c2cb534852d3e27c5f586920b594e9845ee70edc41e61b435448469f2ee8193d"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.15/halgent_0.0.15_linux_amd64.tar.gz"
      sha256 "65f68780f6ba671fe2512065c2f69fcb0f2b3a09d87067642b54616e311dd746"
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
