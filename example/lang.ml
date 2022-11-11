module ExamplePredefinedString = struct
  type t =
    (* UndefinedSemantics*)
    | UndefinedSemantics
    (* ; *)
    | Semicolon
    (* _ *)
    | Underscore

  let from_string (str : string) : t =
    match str with
    | "raise UndefinedSemantics" -> UndefinedSemantics
    | ";" -> Semicolon
    | "_" -> Underscore
    | _ -> raise (Rescue.Lang.NotINPredefinedStringSet str)

  let get_string_value (value : t) : string =
    match value with
    | UndefinedSemantics -> "raise UndefinedSemantics"
    | Semicolon -> ";"
    | Underscore -> "_"

  let pp (formatter : Format.formatter) (str : t) : unit =
    get_string_value str |> Format.fprintf formatter "%s"
end

module Lang = Rescue.Lang.Make (ExamplePredefinedString)
module PredefinedString = Lang.PredefinedString
module Command = Lang.Command
module Program = Lang.Program
module Interpreter = Rescue.Interpreter.Make (Lang)
