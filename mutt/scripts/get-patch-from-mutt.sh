#!/bin/bash

MAIL_DIR="$HOME/Documents/redhat/mail"

[ ! -d "$MAIL_DIR" ] || mkdir -p $MAIL_DIR
[ ! -d "$MAIL_DIR/received" ] || mkdir "$MAIL_DIR/received"
[ ! -d "$MAIL_DIR/tmp" ] || mkdir "$MAIL_DIR/tmp"

PATCH_FILE=$(mktemp --tmpdir="$MAIL_DIR/tmp"  mutt-patch.XXXXXX)

cat > $PATCH_FILE

MAILBOX=$(cat $PATCH_FILE | formail -c -xSubject: | tr "'" "." | sed -e '{ s@\[@@g; s@\]@@g; s@[*()" \t]@_@g; s@[/:]@-@g;
s@^ \+@@; s@\.\.@.@g; s@-_@_@g; s@__@_@g; s@\.$@@; }' | cut -c 1-70).patch

mv "$PATCH_FILE" "$MAIL_DIR/received/$MAILBOX"

