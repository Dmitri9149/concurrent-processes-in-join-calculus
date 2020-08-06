def count(n) & inc() = count(n+1) & reply to inc
        or count(n) & get() = count(n) & reply n to get
;;

spawn count(0)
;;


