#waxc --ts /tmp/out.ts test/define.wax >/dev/null && tsc /tmp/out.ts && node /tmp/out.js
waxc --c /tmp/out.c test/define.wax >/dev/null && gcc /tmp/out.c -o /tmp/out.out && /tmp/out.out