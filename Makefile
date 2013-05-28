all: app

app: app.ml
	ocamlopt -o $@ unix.cmxa app.ml

clean:
	rm app app.cm*

install: app
	/bin/rm -rf target
	mkdir -p target/bin/
	cp app target/bin/app

