open Core.Std

(** A collection of string frequency counts *)
type t

(** An empty collection of string frequency counts *)
val empty : t

(** Converts a collection of string frequence counts to an associative list of string and ints *)
val to_list : t -> (string *int) list

(** Bump the frequency count for the given string *)
val touch : t -> string -> t
