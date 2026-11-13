class Dune < Formula
  desc "Circuit simulator derived from Berkeley SPICE3f5 and ngspice (`dune` command)"
  homepage "https://milkway.github.io/dune/"
  version "0.6.2"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      url "https://github.com/milkway/dune/releases/download/v0.6.2/dune-aarch64-apple-darwin.tar.gz"
      sha256 "66da5e8638288a0492d93fe6b5fc9895cdabd8dbd24c03ae484a324b9d11414f"
    end
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.6.2/dune-x86_64-apple-darwin.tar.gz"
      sha256 "f497912b2a810a0195deaa083233fb859be3910af1f44e711e9b3510f9a5abcb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/milkway/dune/releases/download/v0.6.2/dune-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b303b00e2238650be094f78fac31f77529de8f2d6b6deb9b564958cc923b9aca"
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
