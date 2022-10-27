let read_file_from_channel (ic : in_channel) : string =
  let lines = ref [] in
  (try
     while true do
       lines := input_line ic :: !lines
     done
   with
  | End_of_file -> ());
  List.rev !lines |> String.concat "\n"

let read_file_from_path (path : string) : string =
  let ic = open_in path in
  let content = read_file_from_channel ic in
  close_in ic;
  content