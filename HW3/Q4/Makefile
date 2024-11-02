CC = gcc
CFLAGS = -Wall -g
TARGET = laplace2d

all: $(TARGET)

$(TARGET): laplace2d_func.o laplace2d_solver.o
	$(CC) $(CFLAGS) -o $(TARGET) laplace2d_func.o laplace2d_solver.o

laplace2d_func.o: laplace2d_func.c laplace2d_func.h
	$(CC) $(CFLAGS) -c laplace2d_func.c

laplace2d_solver.o: laplace2d_solver.c laplace2d_func.h
	$(CC) $(CFLAGS) -c laplace2d_solver.c

test: $(TARGET)
	./$(TARGET) 60 60 1e-5 1.6

doc:
	doxygen mydoc.cfg

clean:
	rm -f $(TARGET) *.o *.txt
	rm -rf docs

