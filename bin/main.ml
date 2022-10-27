module Program = Ast.Lang.Program
module Source = Interpreter.Source

let main () =
  let pgm = ref "" in
  let target = ref "" in
  let options = ["-target", Arg.String (fun x -> target := x), "target to rescue"] in
  let usage = "Usage: rescue -target <target.ml> RESCUE" in
  let _ = Arg.parse options (fun x -> pgm := x) usage in
  let pgm = Parser.parse !pgm in
  if Sys.file_exists !target then (
    let target = Util.File.read_file_from_path !target |> Source.from_string in
    let target = Interpreter.interprete pgm target in
    Source.pp Format.std_formatter target;
    Format.fprintf Format.std_formatter "\n")

let () = main ()
