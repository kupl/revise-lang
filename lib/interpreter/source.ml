module Source = struct
  type loc = {
    col: int;
    row: int;
  }

  type t = {
    source: char list list;
    cursor: loc;
  }

  let from_string (source : string) : t =
    let col = 1 in
    let row = 1 in
    let cursor = { col; row } in
    let source = String.split_on_char '\n' source in
    let source = List.map (fun line -> String.to_seq line |> List.of_seq) source in
    { source; cursor }


  (* let get_number_of_rows (source : t) : int = let rows = String.split_on_char '\n' source.source
     in List.length rows *)

  let get_current_row (source : t) : char list = List.nth source.source (source.cursor.row - 1)

  let split (source : t) : string * string =
    let front =
      Core.List.take source.source (source.cursor.row - 1)
      |> List.map List.to_seq
      |> List.map String.of_seq
      |> String.concat "\n"
    in
    let front =
      front
      ^ "\n"
      ^ (Core.List.take (get_current_row source) (source.cursor.col - 1)
        |> List.to_seq
        |> String.of_seq)
    in
    let rear =
      Core.List.drop (get_current_row source) (source.cursor.col - 1)
      |> List.to_seq
      |> String.of_seq
    in
    let rear =
      rear
      ^ "\n"
      ^ (Core.List.drop source.source source.cursor.row
        |> List.map List.to_seq
        |> List.map String.of_seq
        |> String.concat "\n")
    in
    front, rear



  (* let front = String.concat "\n" @@ let lines = String.split_on_char '\n' source.source in let
     front = List.filteri (fun i _ -> i < source.cursor.row - 1) lines in let front = String.concat
     "\n" front in let front = front ^ "\n" ^ String.sub (get_current_row source) in let back =
     List.filteri (fun i _ -> i > source.cursor.row - 1) lines in let back = String.concat "\n" back
     in front, back *)

  (* let current_row (source : t) : string = source.source *)
  let move_up (source : t) : t = source

  let move_down (source : t) : t =
    { source with cursor = { source.cursor with row = source.cursor.row + 1 } }


  let move_left (source : t) : t =
    { source with cursor = { source.cursor with col = max (source.cursor.col - 1) 1 } }


  let move_right (source : t) : t =
    { source with cursor = { source.cursor with col = max (source.cursor.col + 1) 1 } }


  let delete (source : t) : t = source

  let insert (source : t) (str : string) : t =
    let _ = str in
    source


  let pp (formatter : Format.formatter) (source : t) : unit =
    let front, back = split source in
    let current_char = String.get back 0 in
    let back = String.sub back 1 (String.length back - 1) in
    Format.fprintf formatter "%s" front;
    if current_char = '\n' then Format.fprintf formatter "\027[30;47m \027[m\n"
    else Format.fprintf formatter "\027[30;47m%c\027[m\n" current_char;
    Format.fprintf formatter "%s" back
end