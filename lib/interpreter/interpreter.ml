module Source = Source.Source

let rec interprete (pgm : Ast.Lang.Program.t) (src : Source.t) : Source.t =
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
         | Insert str -> Source.insert (Ast.Lang.PredefinedString.get_string_value str))
      |> interprete tl
