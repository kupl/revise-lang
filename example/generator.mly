%token UP
%token DOWN
%token LEFT
%token RIGHT

%token LPAREN
%token RPAREN

%token ORIGIN
%token BACKSPACE
%token INSERT

%token <string> PREDEFINED 

%token EOF

%start <Lang.Program.t> parse

%%

parse:
  | program = program ; EOF { program }

program:
  | { Lang.Program.empty () }
  | pgm=program ; cmd=command { Lang.Program.add_command pgm cmd }

command:
  | UP { Lang.Command.up () }
  | DOWN { Lang.Command.down () }
  | LEFT { Lang.Command.left () }
  | RIGHT { Lang.Command.right () }
  | ORIGIN { Lang.Command.origin () }
  | BACKSPACE { Lang.Command.backspace () }
  | INSERT; LPAREN; str=PREDEFINED; RPAREN { Lang.PredefinedString.from_string str |> Lang.Command.insert }

