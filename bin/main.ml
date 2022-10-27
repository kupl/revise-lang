module Program = Ast.Lang.Program
module Source = Interpreter.Source.Source

let main () =
  let pgm = ref "" in
  let target = ref "" in
  let options = ["-target", Arg.String (fun x -> target := x), "target to rescue"] in
  let usage = "Usage: rescue -target <target.ml> RESCUE" in
  let _ = Arg.parse options (fun x -> pgm := x) usage in
  if Sys.file_exists !target then (
    let ic = open_in !target in
    let lines = ref [] in
    (try
       while true do
         lines := input_line ic :: !lines
       done
     with
    | End_of_file -> close_in ic);
    let lines = List.rev !lines in
    let target = String.concat "\n" lines in
    let target = Source.from_string target in
    let target = Source.move_down target in
    let target = Source.move_down target in
    let target = Source.move_right target in
    let target = Source.move_right target in
    let target = Source.move_right target in
    let target = Source.move_right target in
    let target = Source.move_right target in
    Source.pp Format.std_formatter target;
    Format.fprintf Format.std_formatter "\n")


let () = main ()
