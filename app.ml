let f ic oc =
  output_string oc "HTTP/1.0 200 OK\r\n\r\n";
  output_string oc "hello heroku ocaml app!\n"

let port =
  let port = ref None in
  Arg.parse [] (fun x -> port := Some (int_of_string x)) "app port";
  
  match !port with
  | None -> assert false
  | Some port -> port

let sockaddr = Unix.ADDR_INET (Unix.inet_addr_any, port)

let () = Unix.establish_server f sockaddr
