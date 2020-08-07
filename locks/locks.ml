(* Lock structure *)

let new_lock () = 
        def free() & lock() = reply to lock
        and unlock() = free() & reply to unlock in 
        spawn free() ;
        lock, unlock
;;


(* this function outputs its string argument several time *)

let print_n n s = 
        for i = 1 to n do 
                print_string s; Thread.delay 0.01
        done
;;

spawn (print_n 21 "*" ; print_newline () ; 0) & (print_n 21 "+" ; print_newline () ; 0)
;;

let lock, unlock = new_lock()
;;

spawn begin
        (lock() ; print_n 21 "*" ; unlock() ; 0)
      & (lock() ; print_n 21 "+" ; unlock() ; 0)
end
;;

spawn begin
     (lock() ; print_n 21 "*" ; unlock() ; 0) 
   & (lock() ; print_n 21 "+" ; unlock() ; 0)  
 end
 ;;



