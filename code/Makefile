WSMC = wat2wasm

SRC = $(wildcard *.wat)
WSM = ${SRC:.wat=.wasm}

.PHONY: all
all: $(WSM)

.PHONY: build
build: all

%.wasm: %.wat
	$(WSMC) $<

.PHONY: run
run: all
	@echo "Starting local server on port 8000"
	python3 -m http.server 8000

.PHONY: clean
clean:
	rm -f $(WSM)
