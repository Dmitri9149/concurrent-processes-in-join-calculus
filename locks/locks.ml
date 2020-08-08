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

(* * and + are intermitted *)
spawn (print_n 10 "*" ; print_newline () ; 0) & (print_n 10 "+" ; print_newline () ; 0)
;;

(* need the code to execute  all processes above before the
 * programm will finish *)
let () = Thread.delay 10.0
;;


let lock, unlock = new_lock()
;;

(* firstly is printed one letter then the second *)
spawn begin
        (lock() ; print_n 10 "z" ; unlock() ; 0)
      & (lock() ; print_n 10 "x" ; unlock() ; 0)
end
;;

(* need the code to execute  all processes above before the 
 * programm will finish *)
let () = Thread.delay 10.0
;;





