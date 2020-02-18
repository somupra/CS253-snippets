CC=gcc
INC=include
SRC=src
OBJ=obj
LIB=lib
BIN=bin
.PHONY: all clean realclean

HDRS=$(shell ls $(INC)/*.h)
all: $(BIN)/geometry

$(BIN)/geometry: $(OBJ)/geometry.o $(LIB)/libGeom.so $(OBJ)/donut.o
	$(CC) -o $@ -I$(INC) $< $(OBJ)/donut.o -L$(LIB) -lGeom -lm

$(OBJ)/geometry.o: $(SRC)/geometry.c $(HDRS)
	$(CC) -c -I$(INC) $< -o $@

$(OBJ)/%.o: $(SRC)/%.c $(INC)/%.h 
	$(CC) -fPIC -c -I$(INC) $< -o $@

$(LIB)/libGeom.so: $(OBJ)/circle.o $(OBJ)/triangle.o
	gcc -shared -o $@ $^ -lm

clean:
	$(RM) $(OBJ)/*.o $(LIB)/libGeom.*

realclean: clean
	$(RM) $(BIN)/geometry
