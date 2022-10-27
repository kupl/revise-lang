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
    let col = 0 in
    let row = 0 in
    let cursor = { col; row } in
    let source = String.split_on_char '\n' source in
    let source = List.map (fun line -> String.to_seq line |> List.of_seq) source in
    { source; cursor }

  let get_current_row (source : t) : char list = List.nth source.source source.cursor.row

  let split (source : t) : string * string =
    let front =
      Core.List.take source.source source.cursor.row
      |> List.map List.to_seq
      |> List.map String.of_seq
      |> String.concat "\n"
    in
    let front =
      front
      ^ (if String.length front > 0 then "\n" else "")
      ^ (Core.List.take (get_current_row source) source.cursor.col |> List.to_seq |> String.of_seq)
    in
    let rear =
      Core.List.drop (get_current_row source) source.cursor.col |> List.to_seq |> String.of_seq
    in
    let rear =
      rear
      ^ "\n"
      ^ (Core.List.drop source.source (source.cursor.row + 1)
        |> List.map List.to_seq
        |> List.map String.of_seq
        |> String.concat "\n")
    in
    front, rear

  let trim_row_loc (source : t) (row : int) : int = row |> max 0 |> min (List.length source.source)

  let trim_col_loc (source : t) (col : int) : int =
    col |> max 0 |> min (List.length (get_current_row source))

  let trim_loc (source : t) (loc : loc) : loc =
    { row = trim_row_loc source loc.row; col = trim_col_loc source loc.col }

  let move_up (source : t) : t =
    { source with cursor = { source.cursor with row = source.cursor.row - 1 } |> trim_loc source }

  let move_down (source : t) : t =
    { source with cursor = { source.cursor with row = source.cursor.row + 1 } |> trim_loc source }

  let move_left (source : t) : t =
    { source with cursor = { source.cursor with col = source.cursor.col - 1 } |> trim_loc source }

  let move_right (source : t) : t =
    { source with cursor = { source.cursor with col = source.cursor.col + 1 } |> trim_loc source }


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