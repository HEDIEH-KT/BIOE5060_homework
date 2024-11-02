collatz:
	gcc collatz.c -o collatz

collatz_output.txt: collatz
	./collatz 7 > collatz_output.txt

test: collatz_output.txt
	diff collatz_output.txt collatz_expected.txt > diff.txt
	[ -s diff.txt ] && false || true

