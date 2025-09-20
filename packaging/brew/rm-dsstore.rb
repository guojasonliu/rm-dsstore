class RmDsstore < Formula
  desc "Recursively delete macOS .DS_Store files"
  homepage "https://github.com/<your-username>/rm-dsstore"
  # For first publish, you can keep :head; after tagging v1.0.0, replace with a tarball + sha256
  head "https://github.com/<your-username>/rm-dsstore.git", branch: "main"
  version "1.0.0"

  def install
    bin.install "bin/rm-dsstore"
  end

  test do
    # dry run should succeed
    system "#{bin}/rm-dsstore", "--dry-run", testpath.to_s
  end
end
