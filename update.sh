#!/bin/bash

cd $(dirname $0)
CURRENT=$(cd all; python -c 'import fispip; print(fispip.__version__)')

virtualenv tmp &>/dev/null
tmp/bin/pip install fispip &>/dev/null
NEW=$(tmp/bin/python -c 'import fispip; print(fispip.__version__)')

if [ "$CURRENT" == "$NEW" ]; then
	echo "Nothing to do here"
else
	echo "Current version: $CURRENT"
	echo "Latest version: $NEW"

	rm -fr all/fispip
	cp -a tmp/lib/python*/site-packages/fispip all/
	echo "Updated. Create tag v$NEW and push (master and tag)"
fi

rm -fr tmp

