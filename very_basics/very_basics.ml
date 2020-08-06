(* it seems the JoCaml compiler print output of synchronous channels only !!*)
def succ(x) = print_int x; print_endline "";reply x+1 to succ;;
succ(100000000);;
