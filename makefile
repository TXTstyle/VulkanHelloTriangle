CXX		:=	clang++
FLAGS	:=	-Wall -Wextra -std=c++17 -O3

INCLUDE	:=	include
SRC		:=	src
BIN		:=	bin
SHADERS	:=	shaders

LIBS	:=	-lglfw -lvulkan -ldl -lpthread
EXE		:=	main

DEPS	:=	$(wildcard $(SRC)/*.c*)
OBJ		:=	$(patsubst $(SRC)/%.c*, $(BIN)/%.o, $(DEPS))

DEPS_F	:=	$(wildcard $(SHADERS)/*.frag)
OBJ_F	:=	$(patsubst $(SHADERS)/%.frag, $(BIN)/%.f.spv, $(DEPS_F))
DEPS_V	:=	$(wildcard $(SHADERS)/*.vert)
OBJ_V	:=	$(patsubst $(SHADERS)/%.vert, $(BIN)/%.v.spv, $(DEPS_V))

$(BIN)/%.o: $(SRC)/%.cpp
	mkdir -p $(BIN)
	$(CXX) -c -o $@ $< $(FLAGS) -I$(INCLUDE)

$(BIN)/$(EXE): $(OBJ)
	$(CXX) $(FLAGS) -I$(INCLUDE) -o $@ $^ $(LIBS) -fuse-ld=mold

$(BIN)/%.f.spv: $(SHADERS)/%.frag
	glslc -o $@ $^

$(BIN)/%.v.spv: $(SHADERS)/%.vert
	glslc -o $@ $^

shaders: $(OBJ_F) $(OBJ_V)
		

run: shaders $(BIN)/$(EXE)
		./$(BIN)/$(EXE)

start:
		clear
		./$(BIN)/$(EXE)

clean:
		rm -rf $(BIN)/*

setup:
	mkdir -p $(BIN)
	mkdir -p $(SRC)
	mkdir -p $(INCLUDE)
	mkdir -p $(SHADERS)
	touch $(SRC)/main.cpp
	echo '-Iinclude/' > compile_flags.txt
	echo -e "IndentWidth: 4\nBasedOnStyle: LLVM\nPointerAlignment: Left\nSortIncludes: false" > .clang-format
	clear
