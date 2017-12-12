echo "Welcome! (HOSTTYPE=$HOSTTYPE)"
if [ -n $HOSTTYPE ] && [ ! $HOSTTYPE = login ]; then
    echo "ERROR: HOSTTYPE != login"
fi
