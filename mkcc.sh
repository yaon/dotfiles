#! /bin/sh

touch $1.cc
touch $1.hh

chmod 640 $1.cc
chmod 640 $1.hh

CAPS=`echo $1 | tr [a-z-] [A-Z_]`
#Class=`echo ${1:0:1} | tr [a-z] [A-Z]`
echo "#ifndef $CAPS"_HH_ >> $1.hh
echo "# define $CAPS"_HH_ >> $1.hh
echo >> $1.hh
echo >> $1.hh
echo >> $1.hh
echo "#endif /* !$CAPS""_HH_ */" >> $1.hh

echo "#include \"$1.hh\"" >> $1.cc
