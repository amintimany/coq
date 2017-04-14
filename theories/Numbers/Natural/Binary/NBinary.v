(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)
(*                      Evgeny Makarov, INRIA, 2007                     *)
(************************************************************************)

Unset Universe Polymorphism.

Require Import BinPos.
Require Export BinNat.
Require Import NAxioms NProperties.

Local Open Scope N_scope.

(** * [BinNat.N] already implements [NAxiomSig] *)

Module N <: NAxiomsSig := N.

(*
Require Import NDefOps.
Module Import NBinaryDefOpsMod := NdefOpsPropFunct NBinaryAxiomsMod.

(* Some fun comparing the efficiency of the generic log defined
by strong (course-of-value) recursion and the log defined by recursion
on notation *)

Time Eval vm_compute in (log 500000). (* 11 sec *)

Fixpoint binposlog (p : positive) : N :=
match p with
| xH => 0
| xO p' => N.succ (binposlog p')
| xI p' => N.succ (binposlog p')
end.

Definition binlog (n : N) : N :=
match n with
| 0 => 0
| Npos p => binposlog p
end.

Time Eval vm_compute in (binlog 500000). (* 0 sec *)
Time Eval vm_compute in (binlog 1000000000000000000000000000000). (* 0 sec *)

*)
