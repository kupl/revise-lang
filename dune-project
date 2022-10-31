(lang dune 3.5)

(name rescue)

(generate_opam_files true)

(source
 (github kupl/rescue-lang))

(using menhir 2.1)

(package
 (name rescue)
 (depends core))
