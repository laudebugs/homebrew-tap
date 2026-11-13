class Laminapdf < Formula
  desc "Inspect, check, rotate and extract PDFs, with JSON output for scripts and agents"
  homepage "https://laminapdf.com"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.3.0/laminapdf-cli-aarch64-apple-darwin.tar.xz"
      sha256 "fb42bb0e9f0d2cff2378c4fea219703629ccb64e1edc62edf308c0946cf3df98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.3.0/laminapdf-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9e7c814e9d73c6f076285e786d0cbb22379a1846b35951623d1129c519fb4c75"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.3.0/laminapdf-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "56483406de3c29dd244bb5d5431164af1436db1b693b5f17e3ba64301c9500cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.3.0/laminapdf-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9eac92d7e4fa4740d777324d9724755829793e13bd69c1aead5260fa500b61e7"
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
