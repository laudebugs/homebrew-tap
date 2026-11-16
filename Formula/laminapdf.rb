class Laminapdf < Formula
  desc "Inspect, check, rotate and extract PDFs, with JSON output for scripts and agents"
  homepage "https://laminapdf.com"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.5.0/laminapdf-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e06ede0454bdf2c29a68216a71af0d7c1298c1f28db4cbfc1f0eda7a5658e20e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.5.0/laminapdf-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a26f9a8b65c5b8422b225657444d30f1abb5799c72389d4851a4653c35d5c0b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.5.0/laminapdf-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f67e5b9dc336520ca9a9fc2f2d1b74879fe0a9b4cef4960a734dbef81eaa48cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.5.0/laminapdf-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f1d4a99bad3beb06455375258ab3b6b84c143828539f063e5d7c6a7156c1696"
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
