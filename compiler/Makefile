all: compiler.js

compiler.js:
	waxc compiler.wax --ts compiler.ts
	tsc compiler.ts

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
test_js: compiler.js $(WAX_TEST_JS)
test_cpp: compiler.js $(WAX_TEST_CPP)

%.out : %.wax
	waxc $< --ts tmp.ts && tsc tmp.ts && node tmp.js > $@

%.test.waxc.ts.out : %.wax
	waxc $< --ts tmp.ts && tsc tmp.ts && node tmp.js > out.tmp

%.test.waxc.c.out : %.wax
	waxc $< --c tmp.c && gcc tmp.c -o tmp.bin && ./tmp.bin > out.tmp

%.test.waxc.cpp.out : %.wax
	waxc $< --cpp tmp.cpp && g++ tmp.cpp -o tmp.bin && ./tmp.bin > out.tmp

%.test.js.out : %.wax
	node compiler.js --target=js $< > tmp.js && node tmp.js > out.tmp && diff $*.out out.tmp

%.test.cpp.out : %.wax
	node compiler.js --target=cpp $< > tmp.cpp && g++ tmp.cpp -o tmp.bin && ./tmp.bin > out.tmp && diff $*.out out.tmp

clean:
	rm -f *.c *.cpp *.ts *.js *.bin a.out *.tmp