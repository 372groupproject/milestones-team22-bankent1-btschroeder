WSMC = wat2wasm

SRC = $(wildcard *.wat)
TARGET = ${SRC:.wat=.wasm}

.PHONY: build
build: $(TARGET)

$(TARGET): $(SRC)
	$(WSMC) $(SRC)

.PHONY: run
run: build
	@echo "Starting local server on port 8000"
	python3 -m http.server 8000

.PHONY: clean
clean:
	rm -f $(TARGET)
