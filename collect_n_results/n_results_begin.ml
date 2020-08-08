(* to wait for n events means to collect n results *)

let create_collector f y0 n =
        def count(y,n) & collect(x) = count(f x y,n-1)
        or  count(y,0) & wait() = reply y to wait in
        spawn count(y0,n) ;
        collect, wait
;;

(* using collector we can create countdown n *) 

let countdown n = create_collector (fun () () -> ()) () n
;;

(* ollect_as_sum will collect n integers on channel add and send their sum as the result of synchronous wait *) 

let collect_as_sum n =
  let collect_sum, wait = create_collector (+) 0 n in
  collect_sum,wait
;;

let n = 100
;;

let collect_sum, wait = collect_as_sum n 
;;

spawn for i = 0 to n-1 do collect_sum(i) done
;;

Printf.printf "the result of the reaction is integer %d\n" (wait())
;;


