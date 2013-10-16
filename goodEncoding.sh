#!/bin/sh
if [ $# -ne 2 ]
then
    echo "USAGE : $0 [file] [input_video mode]
    mode=x264 | x264-2pass | mpg2 | mpg4"
    exit 0
fi

mkdir transcode
targetFolder="."
mkdir -p $targetFolder
input=$1;

case $2 in

#encoding with avc mpeg4

"mpg4")
output="$targetFolder/$(basename $1)-mpeg4.mp4"
#turbo encoding with avcencoder
cmd="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-oac mp3lame
-ovc lavc
-lavcopts vcodec=mpeg4:mbd=2:trell:v4mv:turbo:vbitrate=4000:keyint=15
${1} 
-o ${output}
";;

#encoding with fast x264 1pass
"x264")

output="$targetFolder/$(basename $1)-x264.mp4"

cmd="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-oac mp3lame
-ovc x264
-x264encopts subq=4:bframes=2:b_pyramid=normal:weight_b:keyint=8:bitrate=12000
${1} 
-o ${output}
"

;;

#encoding with fast x264 fleur
"fleur")

output="$targetFolder/$(basename $1)-x264"

cmd="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-oac mp3lame
-ovc x264
-x264encopts keyint=8:bitrate=8000
${1} 
-o ${output}
"

;;

#encoding with fast x264 25 fps (conversion with no frame drops)
"x264-25")

output="$targetFolder/$(basename $1)-x264.mp4"

cmd="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-vf fixpts=fps=25
-oac mp3lame
-ovc x264
-x264encopts subq=4:bframes=2:b_pyramid=normal:weight_b:keyint=15:bitrate=12000
${1} 
-o ${output}
"

;;



#encoding with x264 2pass
"x264-2pass")

output="$targetFolder/$(basename $1)-x264-pass1.mp4"

cmd="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-oac mp3lame
-ovc x264
-x264encopts me=umh:bitrate=6000:qp_step=4:qcomp=0.7:pass=1:keyint=24:direct_pred=auto
${1} 
-o ${output}
"
output="$targetFolder/$(basename $1)-x264-pass2.mp4"

pass2="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-oac mp3lame
-ovc x264
-x264encopts me=umh:bitrate=6000:qp_step=4:qcomp=0.7:pass=2:keyint=24:direct_pred=auto
${1} 
-o ${output}
"


;;

#encoding with avc mpeg2

"mpg2")

output="$targetFolder/$(basename $1)-mpge2.mp4"
cmd="
mencoder $input -o $output
-of lavf -lavfopts format=mp4
-nosound
-ovc lavc
-lavcopts vcodec=mpeg2video:mbd=2:trell:turbo:vbitrate=5000:keyint=1
${1} 
-o ${output}
";;

*)

echo "invalid mode : *2"
exit 0;;


esac



echo $cmd
echo #####################################

eval $cmd

sleep 1
echo "##################STARTING 2nd PASS###########################"
sleep 1

echo $pass2
echo #####################################
eval $pass2

