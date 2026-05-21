class Far2lTtyFull < Formula
  desc "Unix TTY port of FAR Manager v2 (full build with Python and NetRocks)"
  homepage "https://github.com/elfmz/far2l"
  url "https://github.com/elfmz/far2l/archive/refs/tags/v_2.8.0.tar.gz"
  sha256 "b0fddad2e3985f245f9e691e23b90fb97f7d29d9a0b131fe686aa3cbb2e4ea01"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(/^v?_?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "libarchive"
  depends_on "libnfs"
  depends_on "libssh"
  depends_on "neon"
  depends_on "openssl@3"
  depends_on "python@3.12"
  depends_on "samba"
  depends_on "uchardet"

  uses_from_macos "m4" => :build
  uses_from_macos "libxml2"

  on_linux do
    depends_on "libx11"
    depends_on "libxi"
  end

  def install
    args = %w[
      -DUSEWX=OFF
      -DUSESDL=OFF
      -DTTYX=ON
      -DNETROCKS=ON
      -DNR_AWS=ON
      -DNR_SMB=ON
      -DMULTIARC=ON
      -DPYTHON=ON
      -DCOLORER=ON
    ]

    system "cmake", "-S", ".", "-B", "build", "-GNinja", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # This is a TUI application, better tests are not possible
    assert_match version.to_s, shell_output("#{bin}/far2l --version")
    assert_match(/tty/i, shell_output("#{bin}/far2l -h 2>&1"))
  end
end
