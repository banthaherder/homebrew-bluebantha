# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class HomebrewBluebantha < Formula
  desc "A simple daemon to turn off bluetooth when a Macbook's lid is closed."
  homepage "https://github.com/banthaherder/homebrew-bluebantha"
  url "https://github.com/banthaherder/homebrew-bluebantha/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "bff361f377a45838d73ce153f5f7a824aaf02a3864c6ea61554fa84c76968739"
  license "MIT"

  depends_on "jq"
  depends_on "blueutil"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    #system "make install"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    bin.install "./src/bluebantha.sh"
    prefix.install_symlink "com.banthabot.bluebantha.plist" => "#{plist_name}.plist"
    system "brew services start"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test homebrew-bluebantha`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
