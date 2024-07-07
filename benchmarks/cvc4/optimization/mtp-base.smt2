  (declare-datatypes () ((MyBool (MyTrue) (MyFalse))))
  (declare-datatypes () ((Unit (Null))))
  (declare-datatypes () ((Nat (Zero) (Succ (proj_Succ_0 Nat)))))
  (declare-datatypes () ((List (Nil (proj_Nil_0 Unit)) (Cons (proj_Cons_0 Nat) (proj_Cons_1 List)))))
  (declare-datatypes () ((NList (Nnil (proj_Nnil_0 Unit)) (Ncons (proj_Ncons_0 List) (proj_Ncons_1 NList)))))
  (declare-fun lq (Nat Nat) MyBool)
  (declare-fun ite2 (MyBool Nat Nat) Nat)
  (declare-fun max (Nat Nat) Nat)
  (declare-fun tf1 (List) Nat)
  (declare-fun tf0 (List) Nat)
  (declare-fun maximum (List) Nat)
  (declare-fun plus (Nat Nat) Nat)
  (declare-fun times (Nat Nat) Nat)
  (declare-fun tf3 (List) Nat)
  (declare-fun tf2 (List) Nat)
  (declare-fun product (List) Nat)
  (declare-fun tf5 (NList) List)
  (declare-fun tf4 (NList) List)
  (declare-fun map (NList) List)
  (declare-fun tf7 (List List) NList)
  (declare-fun tf6 (List) NList)
  (declare-fun tails (List) NList)
  (declare-fun main (List) Nat)
  (declare-datatypes () ((Tuple3 (MakeTuple3 (proj_MakeTuple3_0 Nat) (proj_MakeTuple3_1 Nat)))))
  (declare-fun fst3 (Tuple3) Nat)
  (declare-fun snd3 (Tuple3) Nat)
  (declare-fun step (Nat Tuple3) Tuple3)
  (declare-fun tf9 (Tuple3 List) Tuple3)
  (declare-fun tf8 (List Tuple3) Tuple3)
  (declare-fun fold (List) Tuple3)
  (declare-fun mainNew (List) Nat)
  (assert (= (max Zero Zero) Zero))
  (assert (forall ((x Nat)) (= (max Zero (Succ x)) (Succ x))))
  (assert (forall ((x Nat)) (= (max (Succ x) Zero) (Succ x))))
  (assert (forall ((x Nat) (y Nat)) (= (max (Succ x) (Succ y)) (Succ (max x y)))))
  (assert (forall ((tv5 Unit)) (= (tf1 (Nil tv5)) Zero)))
  (assert (forall ((tv7 List) (tv6 Nat)) (= (tf1 (Cons tv6 tv7)) (max tv6 (tf0 tv7)))))
  (assert (forall ((tv3 List)) (= (tf0 tv3) (tf1 tv3))))
  (assert (forall ((tv2 List)) (= (maximum tv2) (tf0 tv2))))
  (assert (forall ((x Nat)) (= (plus Zero x) x)))
  (assert (forall ((y Nat) (x Nat)) (= (plus (Succ x) y) (Succ (plus x y)))))
  (assert (forall ((x Nat)) (= (times Zero x) Zero)))
  (assert (forall ((y Nat) (x Nat)) (= (times (Succ x) y) (plus (times x y) y))))
  (assert (forall ((tv11 Unit)) (= (tf3 (Nil tv11)) (Succ Zero))))
  (assert (forall ((tv13 List) (tv12 Nat)) (= (tf3 (Cons tv12 tv13)) (times tv12 (tf2 tv13)))))
  (assert (forall ((tv9 List)) (= (tf2 tv9) (tf3 tv9))))
  (assert (forall ((tv8 List)) (= (product tv8) (tf2 tv8))))
  (assert (forall ((tv17 Unit)) (= (tf5 (Nnil tv17)) (Nil Null))))
  (assert (forall ((tv19 NList) (tv18 List)) (= (tf5 (Ncons tv18 tv19)) (Cons (product tv18) (tf4 tv19)))))
  (assert (forall ((tv15 NList)) (= (tf4 tv15) (tf5 tv15))))
  (assert (forall ((tv14 NList)) (= (map tv14) (tf4 tv14))))
  (assert (forall ((tv24 Unit) (tv22 List)) (= (tf7 tv22 (Nil tv24)) (Ncons (Nil Null) (Nnil Null)))))
  (assert (forall ((tv25 Nat) (tv26 List) (tv22 List)) (= (tf7 tv22 (Cons tv25 tv26)) (Ncons tv22 (tf6 tv26)))))
  (assert (forall ((tv21 List)) (= (tf6 tv21) (tf7 tv21 tv21))))
  (assert (forall ((tv20 List)) (= (tails tv20) (tf6 tv20))))
  (assert (forall ((tv27 List)) (= (main tv27) (maximum (map (tails tv27))))))
  (assert (forall ((x1 Nat) (x0 Nat)) (= (fst3 (MakeTuple3 x0 x1)) x0)))
  (assert (forall ((x1 Nat) (x0 Nat)) (= (snd3 (MakeTuple3 x0 x1)) x1)))
  (assert (forall ((tv29 Tuple3) (tv28 Nat)) (= (step tv28 tv29) (MakeTuple3 (max (fst3 tv29) (times tv28 (snd3 tv29))) (times tv28 (snd3 tv29))))))
  (assert (forall ((tv36 Unit) (tv35 Tuple3)) (= (tf9 tv35 (Nil tv36)) tv35)))
  (assert (forall ((tv38 List) (tv37 Nat) (tv35 Tuple3)) (= (tf9 tv35 (Cons tv37 tv38)) (step tv37 (tf8 tv38 tv35)))))
  (assert (forall ((tv33 Tuple3) (tv32 List)) (= (tf8 tv32 tv33) (tf9 tv33 tv32))))
  (assert (forall ((tv30 List)) (= (fold tv30) (tf8 tv30 (MakeTuple3 (Succ Zero) (Succ Zero))))))
  (assert (forall ((tv39 List)) (= (mainNew tv39) (fst3 (fold tv39)))))
  (assert (not (forall ((inp0 List)) (= (main inp0) (mainNew inp0)))))
  (check-sat)
