(* using collectors which are provided by JoinCount.Collerctor *)
(* and we use here the records type of JoCaml*)

module Collector = JoinCount.Collector

let n = 1000
;;

let collector = Collector.create (+) 0 n
;;

spawn for i = 0 to n-1 do collector.Collector.collect (i) done
;;

let res = collector.Collector.wait()
;;

Printf.printf "The result is %d\n" res
;;
