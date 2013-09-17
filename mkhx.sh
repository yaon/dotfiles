#! /bin/sh

touch $1.hxx
touch $1.hh

chmod 640 $1.hxx
chmod 640 $1.hh

CAPS=`echo $1 | tr [a-z-] [A-Z_]`

echo "#ifndef $CAPS"_HH_ >> $1.hh
echo "# define $CAPS"_HH_ >> $1.hh
echo >> $1.hh
echo >> $1.hh
echo >> $1.hh
echo "# include \"$1.hxx\"" >> $1.hh
echo "#endif /* !$CAPS""_HH_ */" >> $1.hh


echo "#ifndef $CAPS"_HXX_ >> $1.hxx
echo "# define $CAPS"_HXX_ >> $1.hxx
echo "# include \"$1.hh\"" >> $1.hxx
echo >> $1.hxx
echo >> $1.hxx
echo >> $1.hxx
echo "#endif /* !$CAPS""_HXX_ */" >> $1.hxx
