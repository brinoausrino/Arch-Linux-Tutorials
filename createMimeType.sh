MIME_FOLDER=~/.local/share/mime/packages

#check parameters
while getopts ":hn:p:c:" option; do
	case "${option}" in
		h) 
			echo "This script creates a new mime type";
			echo ""
			echo "You need to define some parameters"
			echo ""
			echo "-n [name]  example: -n application/json"
			echo "-p [pattern]  example: -p \"*.json\""
			echo "-c [comment]  example: -c \a really nice mime type\""
			exit;;
		n) NAME=${OPTARG};;
		p) PATTERN=${OPTARG};;
		c) COMMENT=${OPTARG};;
	esac
done


if [ ! -n "$NAME" ]; then
    echo 'please enter a name    -n [name]  '
    exit 1
fi

if [ ! -n "$PATTERN" ]; then
    echo 'please enter a pattern    -p [pattern]'
    exit 1
fi

if [ ! -n "$COMMENT" ]; then
    echo 'please enter a comment    -c [comment]'
    exit 1
fi


#check folder existence
if [ ! -d "$MIME_FOLDER" ] 
then
	echo "mime folder $MIME_FOLDER does not exist"
	exit 1
else
	echo "creating xml-file" 
fi


FILENAME=${NAME//['/']/_}

PATH="$MIME_FOLDER/$FILENAME.xml"

if [ -e "$PATH" ] 
then
	echo "File $PATH already exist. Should it be overwritten?"
	select yn in "Yes" "No"; do
	    case $yn in
	        Yes ) break;;
	        No ) exit;;
	    esac
	done
fi

#write xml
echo '<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
    <mime-type type="'$NAME'">
        <comment>'$COMMENT'</comment>
        <icon name="'$FILENAME'"/>
        <glob-deleteall/>
        <glob pattern="'$PATTERN'"/>
    </mime-type>
</mime-info>' > "$PATH"

echo "updating mime database"

update-mime-database ~/.local/share/mime

echo "mime type $NAME ready to use"
