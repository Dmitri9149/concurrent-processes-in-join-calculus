(* the code is from here https://en.wikipedia.org/wiki/JoCaml     *)
type coins = Nickel | Dime
and drinks = Coffee | Tea
and buttons = BCoffee | BTea | BCancel;;
 
(* def defines a Join-pattern alternatives set clause
   * '&' in the left side of '=' means join (channel synchronism)
   * '&' in the right hand side is parallel processing
   * synchronous_reply :== "reply" [x] "to" channel_name
   * synchronous channels have function-like types (`a -> `b)
   * while asynchronous ones have type `a Join.chan
   * only the last statement in a pattern rhs expression can be an asynchronous message
   * 0 in an asynchronous message position means STOP ("no sent message" in CSP terminology).
   *)
 
def put(s) = print_endline s ; 0 (* STOP *) 
  ;; (* put: string Join.chan *)
 
def give(d) = match d with
                 Coffee -> put("Coffee")
                 | Tea -> put("Tea")
              ;; (* give: drink Join.chan *)
 
def refund(v) = let s = Printf.sprintf "Refund %d" v in put(s) 
    ;; (* refund: int Join.chan *)
 
let new_vending give refund =
  let vend (cost:int) (credit:int) = if credit >= cost
                      then (true, credit - cost)
                      else (false, credit)
  in
  def coin(Nickel) & value(v) = value(v+5) & reply to coin
  or coin(Dime) & value(v) = value(v+10) & reply to coin
 
  or button(BCoffee) & value(v) = 
     let should_give, remainder = vend 10 v in
     (if should_give then give(Coffee) else 0 (* STOP *)) 
             & value(remainder) & reply to button
 
  or button(BTea) & value(v) = 
     let should_give, remainder = vend 5 v in
     (if should_give then give(Tea) else 0 (* STOP *)) 
             & value(remainder) & reply to button
 
  or button(BCancel) & value(v) = refund( v) & value(0) & reply to button
  in spawn value(0) ;
  coin, button  (* coin, button: int -> unit *)
  ;; (* new_vending: drink Join.chan -> int Join.chan -> (int->unit)*(int->unit) *)
 
let ccoin, cbutton = new_vending give refund in
  ccoin(Nickel); ccoin(Nickel); ccoin(Dime); 
  Unix.sleep(1); cbutton(BCoffee); 
  Unix.sleep(1); cbutton(BTea); 
  Unix.sleep(1); cbutton(BCancel);
  Unix.sleep(1) (* let the last message show up *)
  ;;
