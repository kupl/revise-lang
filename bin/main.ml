module Program = Ast.Lang.Program
module Source = Interpreter.Source

let main () =
  let pgm = ref "" in
  let target = ref "" in
  let opt_verbose = ref false in
  let options =
    [
      "-target", Arg.String (fun x -> target := x), "target to rescue";
      "-verbose", Arg.Set opt_verbose, "show edit step by step";
    ]
  in
  let usage = "Usage: rescue -target <target.ml> RESCUE" in
  let _ = Arg.parse options (fun x -> pgm := x) usage in
  let pgm =
    (if Sys.file_exists !pgm then Util.File.read_file_from_path !pgm else !pgm) |> Parser.parse
  in
  let target =
    (if Sys.file_exists !target then Util.File.read_file_from_path !target else !target)
    |> Source.from_string
  in
  let processed =
    if !opt_verbose then (
      Format.fprintf Format.std_formatter "\0277";
      List.fold_left
        (fun src cmd ->
          Source.pp Format.std_formatter src;
          Format.fprintf Format.std_formatter "\n";
          Format.pp_print_flush Format.std_formatter ();
          Unix.sleepf 0.1;
          Format.fprintf Format.std_formatter "\0278\027[0J";
          Interpreter.interprete [cmd] src)
        target
        pgm)
    else Interpreter.interprete pgm target
  in
  Source.pp ~with_cursor:false Format.std_formatter processed;
  Format.fprintf Format.std_formatter "\n"

let () = main ()
