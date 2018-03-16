#!/bin/bash

localAccts=$(dscl . list /Users UniqueID | awk '$2>500{print $1}' | grep -v localadmin)

while read account; do
    echo "Verifying $account is not in the local administrator group"
    dseditgroup -o edit -d $account admin
done < <(echo "$localAccts")

exit
