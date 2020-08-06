print_endline "hello world!";;

def echo() = print_endline "hello world from echo !!!"; 0;;

spawn echo();;
spawn echo();;

def succ(x) = print_endline "hello from succ !!"; reply to succ;;

succ(10);;
