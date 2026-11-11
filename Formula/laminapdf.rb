class Laminapdf < Formula
  desc "Inspect, check, rotate and extract PDFs, with JSON output for scripts and agents"
  homepage "https://laminapdf.com"
  version "0.2.0-alpha.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0-alpha.6/laminapdf-cli-aarch64-apple-darwin.tar.xz"
      sha256 "729209aa369bba187023c390b78bced0874ee4b658728a49ce862021b052661b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0-alpha.6/laminapdf-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a4a71a5ed69f05fcb6cf06e76ce117300d7374dda15a354d5925fbc664fb02e4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0-alpha.6/laminapdf-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09a09ebc1f43611a5a593eb398cbdeb373a359a98a8ccd848f4cb490b4244f62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0-alpha.6/laminapdf-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c8d399ca744fc476755c5fe0faebc9b1567856b31d57ded454f0fd762e57c63"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "laminapdf"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "laminapdf"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "laminapdf"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "laminapdf"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
