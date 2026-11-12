class Dune < Formula
  desc "Circuit simulator derived from Berkeley SPICE3f5 (the `dune` command)"
  homepage "https://milkway.github.io/dune/"
  version "0.6.1"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      url "https://github.com/milkway/dune/releases/download/v0.6.1/dune-aarch64-apple-darwin.tar.gz"
      sha256 "6d27d7b340152675886cc2c3182774df25a7b688452182efa0c2dd16901beac1"
    end
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.6.1/dune-x86_64-apple-darwin.tar.gz"
      sha256 "de2baa249f2e0f500d702a5200beec29d17c4b2dd788cb0e9eaaa796e5959cdf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.6.1/dune-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a4ee96fe972a27679922f25e2a82ad057a3836f05f8ed72f7e9a94b129020097"
    end
  end

  # homebrew-core's `dune` is the OCaml build system; both install `bin/dune`.
  conflicts_with "dune", because: "both install a `dune` binary"

  def install
    bin.install "dune"
  end

  test do
    (testpath/"rc.cir").write <<~EOS
      rc low-pass
      vin 1 0 dc 0 ac 1
      r1 1 2 1k
      c1 2 0 159.155n
      .ac dec 10 10 1meg
      .end
    EOS
    system bin/"dune", "-b", testpath/"rc.cir", "-r", testpath/"rc.raw"
    assert_path_exists testpath/"rc.raw"
  end
end
