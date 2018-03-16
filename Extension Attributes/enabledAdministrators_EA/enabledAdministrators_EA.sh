#!/bin/bash

#Script to detect if a computer has a local administrator account on it with UID above 500
#Initialize array
list=()

#generate list of users with UID greater than 500
for username in $(dscl . list /Users UniqueID | awk '$2 > 500 { print $1 }'); do

# Checks to see which usernames are reported as administrators.
# The check is running dsmemberutil's check membership and listing the accounts that are being reported as administrators.
# Actual check is for accounts that are NOT not an admin (i.e. not standard users)
    if [[ $(dsmemberutil checkmembership -U "${username}" -G admin) != not ]]; then
        # Any reported accounts are added to the array list
        list+=("${username}")
    fi
done

# Prints the array's list contents
echo "<result>$(printf '%s\n' "${list[@]}")</result>"
