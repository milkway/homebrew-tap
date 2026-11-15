class Dune < Formula
  desc "Circuit simulator derived from Berkeley SPICE3f5 and ngspice (`dune` command)"
  homepage "https://milkway.github.io/dune/"
  version "0.8.1"
  license all_of: ["BSD-3-Clause", "ECL-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/milkway/dune/releases/download/v0.8.1/dune-aarch64-apple-darwin.tar.gz"
      sha256 "16b87547411ecec5174ba68d427b55247ad5f6fa10a271aa00c73db864052707"
    end
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.8.1/dune-x86_64-apple-darwin.tar.gz"
      sha256 "80a45b9293e15f49e3202e9d8932de537c4363f984e6bddd89f022131d85212b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.8.1/dune-x86_64-unknown-linux-musl.tar.gz"
      sha256 "082962dc647b4878c8f3e8259819d3d24b5de951f4a81cb9449b127096161155"
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
