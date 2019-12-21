#!/bin/sh

export TMPDIR=`mktemp -d /tmp/selfextract.XXXXXX`

ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`

tail -n+$ARCHIVE $0 | tar xzv -C $TMPDIR

echo "Patching data"
cp -r $TMPDIR/data/Contents/ ./Doukutsu.app/Contents/
echo "patching executable"
cp ./Doukutsu.app/Contents/MacOS/Doukutsu ./Doukutsu.app/Contents/MacOS/Doukutsu.bak
dd if=./Doukutsu.app/Contents/MacOS/Doukutsu.bak of=./Doukutsu.app/Contents/MacOS/Doukutsu bs=1 count=408864
cat $TMPDIR/data/stage.dat >> ./Doukutsu.app/Contents/MacOS/Doukutsu
dd if=./Doukutsu.app/Contents/MacOS/Doukutsu.bak skip=427579 bs=1 >> ./Doukutsu.app/Contents/MacOS/Doukutsu
codesign -f -s - ./Doukutsu.app/Contents/MacOS/Doukutsu

rm -rf $TMPDIR

exit 0

__ARCHIVE_BELOW__
