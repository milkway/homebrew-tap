class Dune < Formula
  desc "Circuit simulator derived from Berkeley SPICE3f5 and ngspice (`dune` command)"
  homepage "https://milkway.github.io/dune/"
  version "0.7.0"
  license all_of: ["BSD-3-Clause", "ECL-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/milkway/dune/releases/download/v0.7.0/dune-aarch64-apple-darwin.tar.gz"
      sha256 "a75c8d3ca773dc22323ed8d69dba5734817db3686dadf91376ea3eb86b953049"
    end
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.7.0/dune-x86_64-apple-darwin.tar.gz"
      sha256 "9e48322ca65ebaa09d34a2f6a36c156d4dad0813be807d4ff304de189340cd8a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.7.0/dune-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cc386033e81c1fa803e19fd9e3ddd2bf1189c18aed02cb03805e7583f8924bca"
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
