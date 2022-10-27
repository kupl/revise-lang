{
    open Generator
    exception LexingError
}

let backspace = ['b' 'B']['a' 'A']['c' 'C']['k' 'K']['s' 'S']['p' 'P']['a' 'A']['c' 'C']['e' 'E']
let insert = ['i' 'I']['n' 'N']['s' 'S']['e' 'E']['r' 'R']['t' 'T']
let down = ['v' 'V']

rule read =
    parse
        | "^" { UP }
        | down { DOWN }
        | "<" { LEFT }
        | ">" { RIGHT }
        | "(" { LPAREN }
        | ")" { RPAREN }
        | backspace { BACKSPACE }
        | insert { INSERT }
        | "raise UndefinedSemantics" { RAISE_UNDEFINEDSEMANTICS }
        | ";" { SEMICOLON }
        | eof { EOF }
        | _ { raise LexingError }
