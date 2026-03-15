#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)     #`` echo "$currentTS"

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd "$destinationDirectory" || exit # <- added the exit in case it fails
destDirAbsPath=$(pwd) 

# [TASK 7]
cd "$origAbsPath" || exit # <-
cd "$targetDirectory" || exit # <-
echo "PWD: $(pwd)"
ls -la
# [TASK 8]
yesterdayTS=$((currentTS - 24 * 60 * 60))

declare -a toBackup

for file in * # [TASK 9]
do
    # [TASK 10]
    if [[ $(date -r "$file" +%s) -gt $yesterdayTS ]]
    then
        # [TASK 11]
        toBackup+=("$file")
    fi
done

# echo "Array contents: ${toBackup[@]}"
# echo "Array size: ${#toBackup[@]}"
# [TASK 12]
tar -czvf $backupFileName ${toBackup[@]}

# [TASK 13]
mv "$backupFileName" "$destDirAbsPath"
# Congratulations! You completed the final project for this course!



theia@theia-vascovlourei:/home/project$ ls -l backup.sh
-rwxr--r-- 1 theia users 1624 Mar 13 01:31 backup.sh


theia@theia-vascovlourei:/home/project$ ls -l
total 60
-rw-r--r-- 1 theia users 4423 Mar 13 01:34 backup-1773380076.tar.gz
-rw-r--r-- 1 theia users 4423 Mar 13 01:45 backup-1773380725.tar.gz
-rw-rw-r-- 1 theia users 4423 Mar 13 01:48 backup-1773380881.tar.gz
-rw-rw-r-- 1 theia users 4423 Mar 13 01:49 backup-1773380941.tar.gz
-rw-r--r-- 1 theia users   66 Mar 13 01:38 backup-script-copy
-rwxr--r-- 1 theia users 1624 Mar 13 01:31 backup.sh
drwxr-sr-x 2 theia users 4096 Mar 13 01:49 important-documents
-rw-r--r-- 1 theia users 4995 Sep 28  2022 important-documents.zip
drwxr-sr-x 2 theia users 4096 Mar 13 01:31 test_destination
drwxr-sr-x 2 theia users 4096 Mar 13 01:41 test_target


theia@theia-vascovlourei:/home/project$ sudo cp backup.sh /usr/local/bin/
theia@theia-vascovlourei:/home/project$ ls -l /usr/local/bin/backup.sh
-rwxr-xr-x 1 root root 1624 Mar 13 01:56 /usr/local/bin/backup.sh