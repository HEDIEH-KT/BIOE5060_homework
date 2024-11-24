fizzbuzz: fizzbuzz.c
	gcc fizzbuzz.c -o fizzbuzz

fizzbuzz.txt: fizzbuzz
	./fizzbuzz > fizzbuzz.txt

test: fizzbuzz.txt
	diff fizzbuzz.txt fuzzbuzz_expected.txt > diff.txt
	[ -s diff.txt ] && false || true

