function prepend_date_model
{
    local OLD_NAME=$1
    local NEW_NAME="${CREATION_DATE}_${MODEL}_$1"

    echo "$OLD_NAME -> $NEW_NAME"
    mv $OLD_NAME $NEW_NAME
}

for FILE in *;
do
	# Skip if it's not a file (e.g. a directory)
	if [[ ! -f "$FILE" ]];
        then continue;
    fi

    EXTENSION=${FILE##*.}

    # Skip processing XMP files directly (they are metadata files exported from photos.app)
    if [[ $EXTENSION == "XMP" ]]; then
        continue;
    fi
	
	CREATION_DATE=$(exiftool -m -p '$CreateDate' -d '%Y-%m-%d' "$FILE");

	# Skip if CREATION_DATE variable is empty
	if [[ -z "$CREATION_DATE" ]]; then
        echo "Could not get creation date for '$FILE'"
        continue;
    fi

    MODEL=$(exiftool -m -p '$Model' "$FILE")

    # Skip if MODEL variable is empty
	if [[ -z "$MODEL" ]]; then
        echo "Could not get model name for '$FILE'"
        continue;
    fi

    # Substitute spaces with dashes in model name
    MODEL=${MODEL// /-}
    
    prepend_date_model $FILE

	# Try to get and modify the corresponding XMP sidecar file
	XMP_FILENAME=${FILE%.*}.XMP;

	if [[ -f $XMP_FILENAME ]];
	then
        prepend_date_model $XMP_FILENAME
	fi
done
