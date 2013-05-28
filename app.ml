let f _ic oc =
  let resps = 
    [ "HTTP/1.1 200 OK\r\n";
      "Content-Type: text/plain\r\n";
      "\n";
      "hello heroku ocaml app!\r\n"
    ]
  in
  List.iter print_string resps;
  List.iter (output_string oc) resps

let port =
  let port = ref None in
  Arg.parse [] (fun x -> port := Some (int_of_string x)) "app port";
  
  match !port with
  | None -> assert false
  | Some port -> port

let sockaddr = Unix.ADDR_INET (Unix.inet_addr_any, port)

let () = Unix.establish_server f sockaddr
