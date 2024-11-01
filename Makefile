collatz:
	gcc collatz.c -o collatz -Wall -pedantic

test: collatz
	./collatz 7 > collatz.txt
	diff collatz.txt collatz_expected.txt > diff.txt
	[ -s diff.txt ] && false || true

clean:
	rm -f collatz collatz.txt diff.txt
