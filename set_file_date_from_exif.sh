# Taken from this stack exchange post
# https://apple.stackexchange.com/questions/256837/export-from-mac-photos-app-while-keeping-date-created-data
#
# TODO:
#		- use this technique to make a script to use the exif creation time to modify the filename,
#		should also get input to write the of the camera into the filename
#
#		- don't check files that aren't video or photo files (have some list of good extensions and only use those?)

for FILE in *;
do
	# Skip if it's not a file (e.g. a directory)
	if [[ ! -f "$FILE" ]]; then continue; fi

    EXTENSION=${FILE##*.}

    # Skip processing XMP files directly (they are metadata files exported from photos.app)
    if [[ $EXTENSION == "XMP" ]]; then
        continue;
    fi
	
	CREATION_DATE=$(exiftool -p '$CreateDate' -d '%m/%d/%Y %H:%M:%S' "$FILE");

	# Skip if CREATION_DATE variable is empty
	if [[ -z "$CREATION_DATE" ]]; then continue; fi

	SetFile -d "$CREATION_DATE" -m "$CREATION_DATE" "$FILE";

	# Try to get and modify the corresponding XMP sidecar file
	# NOTE: this assumes the files have MOV extensions
	XMP_FILENAME=${FILE%.*}.XMP;

	if [[ -f $XMP_FILENAME ]];
	then
		SetFile -d "$CREATION_DATE" -m "$CREATION_DATE" "$XMP_FILENAME";
	fi
done
