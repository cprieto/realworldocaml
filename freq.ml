open Core.Std

let build_count () =
  In_channel.fold_lines stdin
    ~init:[]
    ~f:(fun counts line ->
        let count = match List.Assoc.find counts line with
          | None -> 0
          | Some x -> x
        in
        List.Assoc.add counts line (count + 1))

let () =
  build_count ()
  |> List.sort ~cmp:(fun (_, x) (_, y) -> Int.descending x y)
  |> (fun x -> List.take x 10)
  |> List.iter ~f:(fun line, count ->  printf "%3d: %s\n" count line)
