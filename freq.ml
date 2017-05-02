open Core.Std

let build_count () =
  In_channel.fold_lines stdin
    ~init:Counter.empty
    ~f:Counter.touch

let () =
  build_count ()
  |> Counter.to_list
  |> List.sort ~cmp:(fun (_, x) (_, y) -> Int.descending x y)
  |> (fun x -> List.take x 10)
  |> List.iter ~f:(fun (line, count) ->  printf "%3d: %s\n" count line)
