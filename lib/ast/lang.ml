module PredefinedString = struct
  type t =
    (* raise UndefinedSemantics*)
    | RaiseUndefinedSemantics
    (* ; *)
    | Semicolon

  let raise_UndefinedSemantics () : t = RaiseUndefinedSemantics
  let semicolon () : t = Semicolon

  let get_string_value (str : t) : string =
    match str with
    | RaiseUndefinedSemantics -> "raise UndefinedSemantics"
    | Semicolon -> ";"

  let pp (formatter : Format.formatter) (str : t) : unit =
    get_string_value str |> Format.fprintf formatter "%s"
end

module Command = struct
  type t =
    (* Move *)
    | Up
    | Down
    | Left
    | Right
    (* Special *)
    | Backspace
    | Insert of PredefinedString.t

  (* Move *)
  let up () : t = Up
  let down () : t = Down
  let left () : t = Left
  let right () : t = Right

  (* Special *)
  let backspace () : t = Backspace
  let insert (str : PredefinedString.t) : t = Insert str

  let pp (formatter : Format.formatter) (cmd : t) : unit =
    match cmd with
    | Up -> Format.fprintf formatter "^"
    | Down -> Format.fprintf formatter "v"
    | Left -> Format.fprintf formatter "<"
    | Right -> Format.fprintf formatter ">"
    | Backspace -> Format.fprintf formatter "backspace"
    | Insert str ->
        Format.fprintf formatter "insert(";
        PredefinedString.pp formatter str;
        Format.fprintf formatter ")"
end

module Program = struct
  type t = Command.t list

  let empty () : t = []
  let add_command (pgm : t) (cmd : Command.t) : t = pgm @ [cmd]
  let add_commands (pgm : t) (cmds : Command.t list) : t = pgm @ cmds

  let rec pp (formatter : Format.formatter) (pgm : t) : unit =
    match pgm with
    | [] -> ()
    | cmd :: tl ->
        Command.pp formatter cmd;
        pp formatter tl
end
