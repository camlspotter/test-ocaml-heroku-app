let f ic oc =
  begin try while let s = input_line ic in s <> "\r" && s <> "" do () done with _ -> () end;
  let () = Random.self_init () in
  let n = Random.int 1000 in
  Printf.printf "started %d!\n%!" n;
  let resps = 
    [ "HTTP/1.1 200 OK\r\n";
      "Content-Type: text/plain\r\n";
      "\r\n";
      Printf.sprintf "hello heroku ocaml app! %d\r\n" n
    ]
  in
  List.iter (output_string oc) resps;
  flush oc;
  Printf.printf "written %d!\n%!" n

let port =
  let port = ref None in
  Arg.parse [] (fun x -> port := Some (int_of_string x)) "app port";
  
  match !port with
  | None -> assert false
  | Some port -> port

let sockaddr = Unix.ADDR_INET (Unix.inet_addr_any, port)

let () = Unix.establish_server f sockaddr
