(lang dune 3.5)

(name revise)

(maintainers "Seokhyun Lee <seokhyunlee@korea.ac.kr>")
(authors "Seokhyun Lee <seokhyunlee@korea.ac.kr>")

(generate_opam_files true)

(source
 (github kupl/revise-lang))

(using menhir 2.1)

(package
 (name revise)
 (synopsis "A language define minor revision")
 (depends core))
