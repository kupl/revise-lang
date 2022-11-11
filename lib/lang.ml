exception NotINPredefinedStringSet of string

module type PredefinedString = sig
  type t

  val from_string : string -> t
  val get_string_value : t -> string
  val pp : Format.formatter -> t -> unit
end

module type S = sig
  module PredefinedString : PredefinedString

  module Command : sig
    type t =
      (* Move *)
      | Up
      | Down
      | Left
      | Right
      (* Special *)
      | Origin
      | Backspace
      | Insert of PredefinedString.t

    val up : unit -> t
    val down : unit -> t
    val left : unit -> t
    val right : unit -> t
    val origin : unit -> t
    val backspace : unit -> t
    val insert : PredefinedString.t -> t
    val pp : Format.formatter -> t -> unit
  end

  module Program : sig
    type t = Command.t list

    val empty : unit -> t
    val add_command : t -> Command.t -> t
    val add_commands : t -> Command.t list -> t
    val pp : Format.formatter -> t -> unit
  end
end

module Make (P : PredefinedString) : S with module PredefinedString = P = struct
  module PredefinedString = P

  module Command = struct
    type t =
      (* Move *)
      | Up
      | Down
      | Left
      | Right
      (* Special *)
      | Origin
      | Backspace
      | Insert of PredefinedString.t

    (* Move *)
    let up () : t = Up
    let down () : t = Down
    let left () : t = Left
    let right () : t = Right

    (* Special *)
    let origin () : t = Origin
    let backspace () : t = Backspace
    let insert (str : PredefinedString.t) : t = Insert str

    let pp (formatter : Format.formatter) (cmd : t) : unit =
      match cmd with
      | Up -> Format.fprintf formatter "^"
      | Down -> Format.fprintf formatter "v"
      | Left -> Format.fprintf formatter "<"
      | Right -> Format.fprintf formatter ">"
      | Origin -> Format.fprintf formatter "origin"
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
end
