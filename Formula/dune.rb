class Dune < Formula
  desc "Circuit simulator derived from Berkeley SPICE3f5 and ngspice (`dune` command)"
  homepage "https://milkway.github.io/dune/"
  version "0.8.0"
  license all_of: ["BSD-3-Clause", "ECL-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/milkway/dune/releases/download/v0.8.0/dune-aarch64-apple-darwin.tar.gz"
      sha256 "6a449b9a13ca483296bfff4691ebea282489a5ed60bfbf750702ccc42cd52fc0"
    end
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.8.0/dune-x86_64-apple-darwin.tar.gz"
      sha256 "27324c7c4c5ff9074e7f54de1ff3e6dee58e0f3ef1b047723da0be1f315ee74c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.8.0/dune-x86_64-unknown-linux-musl.tar.gz"
      sha256 "36544c600dae6cbd5a0b3ee05d78da1f9fe9ebe62e4b4a356ac81b7596b72742"
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
