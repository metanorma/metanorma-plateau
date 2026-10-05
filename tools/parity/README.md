# Citation render parity harness

Renders the same references through relaton-render 1.3.0 and
3.0.0.pre.alpha.8 for the render-3x port. Run each side in its own
bundle (they require conflicting relaton-bib lines):

    BUNDLE_GEMFILE=Gemfile13 bundle install && \
      BUNDLE_GEMFILE=Gemfile13 bundle exec ruby render13.rb > out-1.3.txt
    BUNDLE_GEMFILE=Gemfile38 bundle install && \
      BUNDLE_GEMFILE=Gemfile38 bundle exec ruby render3.rb > out-3.x.txt
    diff out-1.3.txt out-3.x.txt

Golden 1.3 output captured 2026-10-05 (refs.xml):
  iso19115: ISO 19115-1:2014|ISO 19115-1:2014(en): Geographic information —
  Metadata. International Organization for Standardization. 2014。
(with the author_date/title per-style fields; see out-1.3.txt once saved)
