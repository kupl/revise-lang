module type S = sig
  module Lang : Lang.S

  val interprete : Lang.Program.t -> Source.t -> Source.t
end

module Make (A : Lang.S) : S with module Lang = A = struct
  module Lang = A

  let rec interprete (pgm : Lang.Program.t) (src : Source.t) : Source.t =
    match pgm with
    | [] -> src
    | cmd :: tl ->
        src
        |> (match cmd with
           | Up -> Source.move_up
           | Down -> Source.move_down
           | Left -> Source.move_left
           | Right -> Source.move_right
           | Origin -> Source.move_to_origin
           | Backspace -> Source.delete
           | Insert str -> Source.insert (Lang.PredefinedString.get_string_value str))
        |> interprete tl
end
