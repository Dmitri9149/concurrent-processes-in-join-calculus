(* this is simple counter(n) which keeps an integer and we can *
 * increment it by inc() and get the saved value by get() *)

def count(n) & inc() = count(n+1) & reply to inc
        or count(n) & get() = count(n) & reply n to get
;;

spawn count(0)
;;

spawn (inc() ; inc() ; 0) & (inc() ; 0)
;;

def wait () =
     let x = get () in
     if x < 3 then wait ()
     else begin
             print_string "three is enough !!!" ; print_newline () ; 0
     end
;;

spawn wait ()
;;

let create_counter () =
        def count(n) & inc0() = count(n+1) & reply to inc0
                or count(n) & get0() = count(n) & reply n to get0 in
        spawn count(0) ;
        inc0, get0
;;

let inc,get = create_counter ()
;;

inc()
;;
inc()
;;
inc()
;;
inc()
;;

print_int( get())
;;
print_endline ""
;;


