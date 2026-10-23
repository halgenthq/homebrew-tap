# Rendered by scripts/release.sh into halgenthq/homebrew-tap Formula/halgent.rb. A formula, never a cask: brew does not quarantine formula downloads, and the binaries are not notarized.
class Halgent < Formula
  desc "Control layer between AI agents and the tools they use"
  homepage "https://halgent.com"
  version "0.0.2"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.2/halgent_0.0.2_darwin_arm64.tar.gz"
      sha256 "8b502085e49dc7000975d51cc1044551804402df9657b7c7a16474a05647b908"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.2/halgent_0.0.2_darwin_amd64.tar.gz"
      sha256 "669c276d4d8a5b8e63674da4ee9995530d467378807ee23e161552a226299a5a"
    end
  end

  on_linux do
    depends_on "socat"

    on_arm do
      url "https://dl.halgent.com/halgent/v0.0.2/halgent_0.0.2_linux_arm64.tar.gz"
      sha256 "c72823a9202ba268c27c1725976539791844dd86527e5351193f63940d5dc829"
    end
    on_intel do
      url "https://dl.halgent.com/halgent/v0.0.2/halgent_0.0.2_linux_amd64.tar.gz"
      sha256 "558221ce341dc65579ddb52cac8501d4787ba2d99743cd77f8016076079c91a5"
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
