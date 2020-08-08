(* one of synchronization mechanizms *)

def join1 () & join2 () = reply to join1 & reply to join2
 ;;

spawn begin
        (print_string "(" ; join1 () ; print_string "a" ; join1() ;
        print_string ")" ; print_newline (); 0)
      & (join2 (); print_string "b" ; join2 () ; 0)
end
;;


(* without the statement the code above does not execute all print statements *)(* because the programm is finished before it *)  
let () = Thread.delay 10.0
;;
