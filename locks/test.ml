spawn begin
        (print_string "AAAAAAAAAAAAAAAAAAAAAAAAAAA" ; 0)
      end
;;

flush stdout
;;

def count () = print_string "HHHHHHHHHHHHHHHHH"; 0
;;
spawn count()
;;
