a.out: utils/dictionary.s inclusions.s
	gcc repl.s -lm

utils/dictionary.s: lispfuncs/*.s
	./generate_dictionary lispfuncs/*.s > utils/dictionary.s

inclusions.s: utils/*.s lispfuncs/*.s
	./generate_inclusions utils/*.s lispfuncs/*.s > inclusions.s

clean:
	rm a.out utils/dictionary.s inclusions.s
