module type S = sig
  module Lang : Lang.S

  val interprete : Lang.Program.t -> Source.t -> Source.t
end

module Make (A : Lang.S) : S with module Lang = A