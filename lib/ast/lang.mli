module PredefinedString : sig
  type t =
    (* UndefinedSemantics*)
    | UndefinedSemantics
    (* ; *)
    | Semicolon

  val undefinedSemantics : unit -> t
  val semicolon : unit -> t
  val get_string_value : t -> string
  val pp : Format.formatter -> t -> unit
end

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
