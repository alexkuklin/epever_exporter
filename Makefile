CC=clang
RM=rm -f
CFLAGS=$(shell pkg-config --cflags libbsd libmodbus)
LIBS=$(shell pkg-config --libs libbsd libmodbus) -pthread

SRCS=src/epever.c src/*.h

all: epever lint

epever: $(SRCS)
	$(CC) $(CFLAGS) $(LIBS) -Wall -Werror -pedantic -O3 -o epever src/epever.c

lint:
	clang-format --verbose --Werror -i --style=file src/*
	clang-tidy --checks='*,-altera-id-dependent-backward-branch,-altera-unroll-loops,-cert-err33-c,-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling,-llvm-header-guard,-llvmlibc-restrict-system-libc-headers,-readability-function-cognitive-complexity' --format-style=llvm src/* -- $(CFLAGS)
.PHONY: lint

clean:
	$(RM) epever
