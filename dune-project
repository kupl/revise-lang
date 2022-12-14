(lang dune 3.5)

(name rescue)

(maintainers "Seokhyun Lee <seokhyunlee@korea.ac.kr>")
(authors "Seokhyun Lee <seokhyunlee@korea.ac.kr>")

(generate_opam_files true)

(source
 (github kupl/rescue-lang))

(using menhir 2.1)

(package
 (name rescue)
 (synopsis "a language define minor revision")
 (depends core))
