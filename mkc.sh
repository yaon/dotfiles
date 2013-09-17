#! /bin/sh

touch $1.c
touch $1.h

chmod 640 $1.c
chmod 640 $1.h

CAPS=`echo $1 | tr [a-z] [A-Z]`

echo "#ifndef $CAPS"_H_ >> $1.h
echo "# define $CAPS"_H_ >> $1.h
echo >> $1.h
echo >> $1.h
echo >> $1.h
echo "#endif /* !$CAPS""_H_ */" >> $1.h
echo "#include \"$1.h\"" >> $1.c
