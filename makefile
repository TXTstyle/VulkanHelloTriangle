CXX		:=	clang++
FLAGS	:=	-Wall -Wextra -std=c++17 -O2

INCLUDE	:=	include
SRC		:=	src
BIN		:=	bin

LIBS	:=	-lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
EXE		:=	main 

all: $(BIN)/$(EXE)

run: clean all
		./$(BIN)/$(EXE)

$(BIN)/$(EXE): $(SRC)/*.cpp
	$(CXX) $(FLAGS) -I $(INCLUDE) $^ -o $@ $(LIBS)

start:
		./$(BIN)/$(EXE)

clean:
		-rm $(BIN)/*
