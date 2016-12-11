# frozen_string_literal: true

APP_ENV = ENV["APP_ENV"]
APP_VERSION = `git describe --abbrev=0 --tags 2>&1`.chop

# enable verbose logging for external services
def verbose?
  !!ENV["DEBUG"]
end

module GemLoader
  GEM_PATH = "../.gems"
  GEM_TEST_PATH = "../.gems-test"

  def self.load!(gemfile_path = GEM_PATH)
    # Lock in specific versions for all runtime gem dependencies.
    File.read(File.expand_path(gemfile_path, File.dirname(__FILE__))).each_line do |line|
      name, _, version = line.split
      gem name, version
    end
  end
end

GemLoader.load!
GemLoader.load!(GemLoader::GEM_TEST_PATH) if APP_ENV == "test"
