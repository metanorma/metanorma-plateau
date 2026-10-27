Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}" }

gemspec

# The ja-en availability delta needs the fixed extends merge
# (delta labels win per key) shipped in relaton-render alpha.32;
# resolve in CI; relaton-render 3.0.0 final carries it
gem "relaton-render", "~> 3.0"

gem "gem-release"

eval_gemfile("Gemfile.devel") rescue nil
