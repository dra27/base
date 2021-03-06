(** Functions for ordered collections. *)

open! Import

(** [get_pos_len], [get_pos_len_exn], and [validate_pos_len_exn] are intended to be used
    by functions that take a sequence (array, string, bigstring, ...) and an optional
    [pos] and [len] specifying a subrange of the sequence.  Such functions should call
    [get_pos_len] with the length of the sequence and the optional [pos] and [len], and it
    will return the [pos] and [len] specifying the range, where the default [pos] is zero
    and the default [len] is to go to the end of the sequence.

    It should be the case that:

    {[
      pos >= 0 && len >= 0 && pos + len <= length
    ]}

    Note that this allows [pos = length] and [len = 0], i.e., an empty subrange
    at the end of the sequence.

    [get_pos_len] returns [(pos', len')] specifying a subrange where:

    {v
      pos' = match pos with None -> 0 | Some i -> i
      len' = match len with None -> length - pos | Some i -> i
    v} *)

val get_pos_len     : ?pos:int -> ?len:int -> length:int -> (int * int, string) Result.t
val get_pos_len_exn : ?pos:int -> ?len:int -> length:int -> int * int

(** [check_pos_len_exn ~pos ~len ~length] raises unless [pos >= 0 && len >= 0 && pos + len
    <= length]. *)
val check_pos_len_exn : pos:int -> len:int -> length:int -> unit

(*_ See the Jane Street Style Guide for an explanation of [Private] submodules:

  https://opensource.janestreet.com/standards/#private-submodules *)
module Private : sig
  val slow_check_pos_len_exn : pos:int -> len:int -> length:int -> unit
end
