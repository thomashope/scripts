
re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

defaults write -g com.apple.mouse.scaling $1

echo "Mouse sensitivity set to $(defaults read -g com.apple.mouse.scaling)"
