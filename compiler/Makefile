# overall targets
all: compiler.js wax.js wax

test: test_unit_js test_wax_js test_unit_cpp test_wax_cpp 

clean:
	rm -f wax *.c *.cpp *.ts *.js *.bin a.out *.tmp

# Compiler target 
compiler.js:
	waxc compiler.wax --ts compiler.ts
	tsc compiler.ts

# Sef hosted compiler targets
wax.js: compiler.js
	node compiler.js --target=js compiler.wax > wax.js

wax.cpp: compiler.js
	node compiler.js --target=cpp compiler.wax > wax.cpp

wax: compiler.js
	g++ wax.cpp -o wax

# Wax Language tests for tests
WAX_JS_WAXC = node compiler.js # waxc js build
WAX_JS_WAX = node wax.js # self hosted, js
WAX_CPP_WAX = ./wax # self hosted, c++
WAX = $(WAX_CPP_WAX)

# Compiler unit tests
UNIT_TEST = $(wildcard *_test.wax)
UNIT_TEST_JS = $(patsubst %.wax, %.test.js, $(UNIT_TEST))
UNIT_TEST_CPP = $(patsubst %.wax, %.test.cpp, $(UNIT_TEST))

test_unit_js: compiler.js wax.js wax $(UNIT_TEST_JS)
test_unit_cpp: compiler.js wax.js wax $(UNIT_TEST_CPP)

%.test.js : %.wax
	$(WAX) --target=js $< > tmp.js && node tmp.js

%.test.cpp : %.wax
	$(WAX) --target=cpp $< > tmp.cpp && g++ tmp.cpp -o tmp.bin && ./tmp.bin

WAX_TEST = $(wildcard test/*.wax)
WAX_TEST_SNAPSHOT = $(patsubst %.wax, %.out, $(WAX_TEST))
WAX_TEST_WAXC_TS = $(patsubst %.wax, %.test.waxc.ts.out, $(WAX_TEST))
WAX_TEST_WAXC_C = $(patsubst %.wax, %.test.waxc.c.out, $(WAX_TEST))
WAX_TEST_WAXC_CPP = $(patsubst %.wax, %.test.waxc.cpp.out, $(WAX_TEST))
WAX_TEST_JS = $(patsubst %.wax, %.test.js.out, $(WAX_TEST))
WAX_TEST_CPP = $(patsubst %.wax, %.test.cpp.out, $(WAX_TEST))

test_snapshot: compiler.js $(WAX_TEST_SNAPSHOT)
test_waxc_ts: compiler.js $(WAX_TEST_WAXC_TS)
test_waxc_c: compiler.js $(WAX_TEST_WAXC_C)
test_waxc_cpp: compiler.js $(WAX_TEST_WAXC_CPP)
test_wax_js: compiler.js wax.js $(WAX_TEST_JS)
test_wax_cpp: compiler.js wax.js $(WAX_TEST_CPP)

%.out : %.wax
	waxc --ts tmp.ts $< && tsc tmp.ts && node tmp.js > $@

%.test.waxc.ts.out : %.wax
	waxc --ts tmp.ts $< && tsc tmp.ts && node tmp.js > out.tmp

%.test.waxc.c.out : %.wax
	waxc --c tmp.c $< && gcc tmp.c -o tmp.bin && ./tmp.bin > out.tmp

%.test.waxc.cpp.out : %.wax
	waxc --cpp tmp.cpp $< && g++ tmp.cpp -o tmp.bin && ./tmp.bin > out.tmp

%.test.js.out : %.wax
	$(WAX) --target=js $< > tmp.js && node tmp.js > out.tmp && diff $*.out out.tmp

%.test.cpp.out : %.wax
	$(WAX) --target=cpp $< > tmp.cpp && g++ tmp.cpp -o tmp.bin && ./tmp.bin > out.tmp && diff $*.out out.tmp
