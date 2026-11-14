class Laminapdf < Formula
  desc "Inspect, check, rotate and extract PDFs, with JSON output for scripts and agents"
  homepage "https://laminapdf.com"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.4.0/laminapdf-cli-aarch64-apple-darwin.tar.xz"
      sha256 "107c1f4025f34a74dec1ff613871827383b33629a473458f9d762f3d1bbcd101"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.4.0/laminapdf-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fcc32b53dbeb91f8d47ef8357aba08e87ad668ec61894d0b5de5605ec7ce1aed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.4.0/laminapdf-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4a9353c5a119ac7bf3feeeec9fb81301e502d9ad26b624bc1458aadf689c85a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.4.0/laminapdf-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ebdc82e63eaf36e46fb5fc5e8db03e2bac9884fe788dc7be86963d8a2bf45ff"
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
