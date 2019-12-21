#!/bin/sh
tar cf ./payload.tar ./data/*
gzip payload.tar
cat ./patch.sh ./payload.tar.gz > osxpatcher
rm payload.tar.gz
chmod +x ./osxpatcher
