Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}" }

gemspec

gem "gem-release"

# The citation facade lives in jis main until its next release
gem "metanorma-cli", git: "https://github.com/metanorma/metanorma-cli", branch: "main" # fleet pins for the 1.3-era flavors
gem "metanorma-core", git: "https://github.com/metanorma/metanorma-core", branch: "main"
gem "html2doc", git: "https://github.com/metanorma/html2doc", branch: "main"
gem "isodoc-i18n", git: "https://github.com/metanorma/isodoc-i18n", branch: "main"
gem "isodoc", git: "https://github.com/metanorma/isodoc", branch: "main"
gem "metanorma-standoc", git: "https://github.com/metanorma/metanorma-standoc", branch: "main" # #1269 merged: GC budget + partial-load preprocessor registration
gem "metanorma-document", git: "https://github.com/metanorma/metanorma-document", branch: "main"
gem "metanorma-utils", git: "https://github.com/metanorma/metanorma-utils", branch: "main" # utils#55 merged (GcBudget + table cell buffer); #56 pending
gem "mn-requirements", git: "https://github.com/metanorma/mn-requirements", branch: "main"
gem "metanorma-iso", github: "metanorma/metanorma-iso", branch: "main" # CitationStyle facade; unreleased
gem "metanorma-ogc", github: "metanorma/metanorma-ogc",
    ref: "3e27e9f87b4300d8995ea9a3d98b10b8d82d0c17"
gem "metanorma-itu", github: "metanorma/metanorma-itu",
    ref: "eceb3fbd7720c179ad534c3a26b5a762fbde0f6f"
gem "metanorma-ieee", github: "metanorma/metanorma-ieee",
    ref: "6af0ea64a4444c7b201dedb7eb06e5bbceaa4f70"
gem "metanorma-iho", github: "metanorma/metanorma-iho",
    ref: "dfcc029ab2e83a1fe4248d382e71b85998275225" # metanorma-iho#547
gem "metanorma-bipm", github: "metanorma/metanorma-bipm",
    ref: "43b63a2346d4d9b22c966e0d7a5e0e3c7251ec60" # metanorma-bipm#694
gem "metanorma-ietf", github: "metanorma/metanorma-ietf", branch: "main" # main replaced its relaton-render stack natively
# cli pulls iec transitively at 2.9.0, whose front.rb requires the removed
# standalone pubid-iec; iec main loads IEC identifiers through the pubid
# monogem instead
gem "metanorma-iec", github: "metanorma/metanorma-iec",
    ref: "79d56ed6f969f5b52e9240a42ed77ee230e158c1" # metanorma-iec#594

gem "metanorma-jis", github: "metanorma/metanorma-jis", ref: "0319570295c5266f594865f17189033bddcfa15c" # the tree jis#523 merges; flip to main in the cg3 de-branch
gem "relaton-render", "= 3.0.0.pre.alpha.19" # released: #111, #115, 1.x renderings contract
gem "relaton", "= 3.0.0.pre.alpha.4"
gem "relaton-bib", "2.1.9"
gem "relaton-cli", ">= 3.0.0.pre.alpha.1"
gem "pubid", "2.0.0.pre.alpha.13" # pairs with relaton 3.0.0.pre.alpha.4 (pre-rename base) # released line: #111 i18n fallback + kind title-form emphasis

eval_gemfile("Gemfile.devel") rescue nil
