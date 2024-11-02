for:
	gcc forloop.c -o forloop -Wall -pedantic

while:
	gcc whileloop.c -o whileloop -Wall -pedantic

for.txt: for
	./forloop > for.txt

while.txt: while
	./whileloop > while.txt

test: for.txt while.txt
	diff for.txt while.txt > diff.txt
	[ -s diff.txt ] && false || true

clean:
	rm -f forloop whileloop for.txt while.txt diff.txt

