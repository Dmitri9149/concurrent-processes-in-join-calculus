def tick () = print_string "AAA!!!"; reply to tick
;;

print_string "(";
         tick() ;
print_string ")"
;;


let print_n n s =
        for i = 1 to n do
               print_string s; Thread.delay 0.01
        done
;;

spawn  (print_n 21 "*" ; print_newline () ; 0) 
& (print_n 1 "+" ; print_newline (); 0)
;;

