# Exercises

## Lesson 02 - Variables and functions

1. Write a function that multiplies the value plus 10, what is its type?

```ocaml
let multiply_by_ten x =
    x * 10
;;
```

type is `val multiply_by_ten: int -> int = <fun>`

2. Write a function which returns true if both of its arguments are non-zero, and false otherwise. What is the type of your function?

```ocaml
let are_non_zero x y =
    if x = 0 && y = 0
    then true
    else false
;;
```

type is `val are_non_zero: int -> int -> bool = <fun>`

3. Write a recursive function which, given a number n, calculates the sum 1 + 2 + 3 + … + n. What is its type?

```ocaml
let rec sum_up_to n =
    if n = 1 then 1
    else n + sum_up_to (n - 1)
;;
```

type is `val sum_up_to: int -> int = <fun>`

4. Write a function power x n which raises x to the power n. Give its type.

```ocaml
let power x n =
    if x = 1 then x
    else x * power x (n - 1)
;;
```

type is `val power: int -> int -> int`

5. Write a function isconsonant which, given a lower-case character in the range 'a'…'z', determines if it is a consonant.

```ocaml
let is_consonant x =
    if x < 'a' || (x = 'a' || x = 'e' || x = 'i' || x = 'o' || x = 'u')
    then true
    else false
;;
```

type is `val is_consonant: char -> bool = <fun>`

6. What is the result of the expression let x = 1 in let x = 2 in x + x ?
number 4, first `x` is not used.

## Lesson 3 - Pattern matching

1. Rewrite the not function from the previous chapter in pattern matching style

```ocaml
let my_not x =
    match x with
    | true -> false
    | false -> true
;;
```

2. Use pattern matching to write a recursive function which, given a positive integer n, returns the sum of all the integers from 1 to n.

```ocaml
let rec sum_up_to n =
    match n with
    | 1 -> 1
    | x -> x + sum_up_to (x - 1)
;;
```

3. Use pattern matching to write a function which, given two numbers x and n, computes x ^ n.

```ocaml
let rec power_match x n =
    match n with
    | 0 -> 1
    | 1 -> x
    | _ -> x * power_match x (n - 1)
;;
```

6. There is a special pattern x..y to denote continuous ranges of characters, for example 'a'..'z' will match all lowercase letters. Write functions islower and isupper, each of type char → bool, to decide on the case of a given letter.

```ocaml
let is_upper x =
    match x with
    |'a'..'z' -> false
    | _ -> true
;;

let is_lower x =
    match x with
    | 'A'..'Z' -> false
    | _ -> true
;;
```

## Lesson 4 - Lists

1. Write a function evens which does the opposite to odds, returning the even numbered elements in a list. For example, evens [2; 4; 2; 4; 2] should return [4; 4]. What is the type of your function?

```ocaml
let rec even_elements l =
  match l with
  | [] | [_] -> []
  | hd :: even :: tl -> even :: even_elements tl
```

type will be, of course `val even_elements: 'a list -> 'a list`

2. Write a function *count\_true* which counts the number of true elements in a list. For example, count\_true [true; false; true] should return 2\. What is the type of your function? Can you write a tail recursive version?

```ocaml
let rec count_true l =
  match l with
  | [] -> 0 (* empty list is nothing *)
  | hd :: tl -> if hd then 1 + count_true tl else count_true tl
;;
```

The type of the function is `bool list -\> int`

The tail recursive version would look like this:

```ocaml
let rec count_true l =
  let inner_count x n =
    match x with
    | [] -> 0
    | hd :: tl if hd then inner_count tl (n + 1) else inner_count tl n
  in
  inner_count l 0
;;
```

3. Write a function which, given a list, builds a palindrome from it. A palindrome is a list which equals its own reverse. You can assume the existence of rev and @. Write another function which determines if a list is a palindrome.

```ocaml
let palindrome_2 l = 
  let r = List.rev l in
  match r with
  | [] | [_] as x -> x
  | hd :: tl -> l @ tl
;;

let is_palindrome l = (l = (List.rev l)) ;;
```

4. Write a function drop\_last which returns all but the last element of a list. If the list is empty, it should return the empty list. So, for example, drop\_last [1; 2; 4; 8] should return [1; 2; 4]. What about a tail recursive version?

```ocaml
let rec drop_last l =
  match l with
  | [] | [_] -> []
  | hd :: tl -> hd :: (drop_last tl)
;;

(* The tail recursive functions could be *)
let drop_last_tr l =
  let rec inner_drop a b =
    match b with
    | [] | [_] -> List.rev a
    | hd :: tl -> inner_drop ( hd :: a ) tl
  in
  inner_drop [] l
```

5. Write a function member of type α → α list → bool which returns true if an element exists in a list, or false if not. For example, member 2 [1; 2; 3] should evaluate to true, but member 3 [1; 2] should evaluate to false.

```ocaml
let rec is_in_list x l =
  match l with
  | [] -> false
  | hd :: tl -> hd = x || is_in_list x tl
;;
```

6. Use your member function to write a function make\_set which, given a list, returns a list which contains all the elements of the original list, but has no duplicate elements. For example, make\_set [1; 2; 3; 3; 1] might return [2; 3; 1]. What is the type of your function?

```ocaml
let rec make_set l =
  match l with
  | [] | [_] as x -> x
  | hd :: (hd' :: _ as tl) ->
    if hd = hd' then make_set x else hd :: (make_set tl)
;;

(* That version doesn't work, because it depends on position, so it won't return the expected answer *)
let rec make_set l =
  let rec is_in a b =
    match b with
    | [] -> false
    | hd :: tl -> hd = a || is_in a tl
  in
  match l with
  | [] | [_] as x -> x
  | hd :: (hd' :: _ as tl) ->
    if 'is_in hd tl then make_set tl else hd :: (make_set tl)
;;
```

## Lesson 5 - Sorting

1. In msort, we calculate the value of the expression length l / 2 twice. Modify msort to remove this inefficiency. (see [this gist](https://gist.github.com/cprieto/bb9f9b251845b5a0be413d60ed90030f))

```ocaml
let rec msort items =
  (* I am pretty sure this can be tail recursive *)
  let rec take n x =
    match x with
    | [] -> []
    | hd :: tl -> 
      if n = 0 then [] 
      else hd :: take (n - 1) tl
  in
  (* Now this is a tail recursive function! yay! *)
  let length l =
    let rec inner_length counter items =
      match items with
      | [] -> counter
      | hd :: tl -> inner_length (counter + 1) tl
    in
    inner_length 0 l
  in
  let rec drop n items =
    if n = 0 then items else 
    match items with
    | [] -> []
    | hd :: tl -> drop (n - 1) tl
  in
  let rec merge x y =
    match x, y with
    | [], i -> i
    | i, [] -> i
    | hx :: tx, hy :: ty ->
      if hx < hy then hx :: merge tx (hy :: ty)
      else hy :: merge (hx :: tx) ty
  in
  match items with
  | [] | [_] as x -> x
  | _ -> 
    let items_length = (length items / 2) in
    let left, right = take items_length items, drop items_length items in
    merge (msort left) (msort right)
;;

msort [4;1;0;9;3;2;5];;
```

3. Write a version of insertion sort which sorts the argument list into reverse order. (see my original insert sort in [this gist](https://gist.github.com/cprieto/5e1d6ea2d1d20a84da9bc13a455d4c2b))

4. Write a function to detect if a list is already in sorted order.

```ocaml
let rec is_sorted l =
  match l with
  | [] | [_] -> true (* empty list is sorted *)
  | hd :: hd' :: tl -> hd <= hd' && (is_sorted tl)
;;

is_sorted [0;1;2;3;4];;
is_sorted [0;1;2;3;4;0];;
```



## Lesson 6 - Functions







