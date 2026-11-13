class Laminapdf < Formula
  desc "Inspect, check, rotate and extract PDFs, with JSON output for scripts and agents"
  homepage "https://laminapdf.com"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0/laminapdf-cli-aarch64-apple-darwin.tar.xz"
      sha256 "680858a2b5698ad791edf25ccaa4c09b9caedb26deaa69fe58d7cd36e64f0c53"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0/laminapdf-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1fe1c0d6272805ac35cac3669937861e1d21a98fed344edbca9eb6c7f511137c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0/laminapdf-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4a4630a78aac909f86c3d82c381cfdb8aca489be9b3736d9c42d6adb115554a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/laudebugs/laminapdf/releases/download/laminapdf-cli-v0.2.0/laminapdf-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f871bbb31cd1032ac151ee314f835c2c6a4f3cec2c91d314916f53287e8f1805"
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
