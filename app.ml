let f ic oc =
  let resps = 
    [ "HTTP/1.1 200 OK\r\n";
      "Content-Type: text/plain\r\n";
      "\r\n";
      "hello heroku ocaml app!\r\n"
    ]
  in
  close_in ic;
  List.iter (output_string oc) resps;
  flush oc;
  print_endline "written!"

let port =
  let port = ref None in
  Arg.parse [] (fun x -> port := Some (int_of_string x)) "app port";
  
  match !port with
  | None -> assert false
  | Some port -> port

let sockaddr = Unix.ADDR_INET (Unix.inet_addr_any, port)

let () = Unix.establish_server f sockaddr
