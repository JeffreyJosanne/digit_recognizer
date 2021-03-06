#!/usr/local/bin/bash
for INDUSER in `cat scripts/complete_users`
do
echo ${INDUSER} > resources/user_list
echo ${INDUSER} > resources/test_users
shopt -s extglob

######

#remove rec directory files for new test users
rm -f rec/*.rec 

######

# USER="s0231469"
DATA="/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser"

# 1) copy waveforms into common file space
# 2) copy label files into common file space
# 3) make mfcc files from waveforms
for USER in `cat resources/user_list`
do
# first, process the training data, which must be called something like "simonk_train.wav"
F=${DATA}/wav/train/${USER}_train.wav
if test -f $F
then
	echo Converting $F "to correct waveform format and saving in" ${DATA}/wav/train/`basename $F`
	ch_wave -F 16000 -otype nist -c 0 -o ${DATA}/wav/train/`basename $F` $F

	echo "Making MFCCs for" ${DATA}/wav/train/`basename $F`
	HCopy -T 1 -C resources/CONFIG_for_coding \
	       ${DATA}/wav/train/`basename $F`\
	       ${DATA}/mfcc/train/`basename $F .wav`.mfcc

else
	echo Cannot find $F
	exit
fi


# copy the train and test label files
F=lab/train/${USER}_train.lab
if test -f $F
then
	cp $F lab/train/
else
	echo "Cannot find your training labels, which should be in" $F
	exit
fi

F=lab/test/${USER}_test.mlf
if test -f $F
then
	cp $F lab/test/
else
	echo "Cannot find your test labels, which should be in" $F
	exit
fi


# first, process the training data, which must be called something like "simonk_test01.wav"
for F in `ls wav/test/${USER}_test?(_)??.wav`
do

	if test -f $F
	then

		echo Converting $F "to correct waveform format and saving in" ${DATA}/wav/test/`basename $F`
		ch_wave -F 16000 -otype nist -c 0 -o ${DATA}/wav/test/`basename $F` $F

		echo Making MFCCs for $F
		HCopy -T 1 -C resources/CONFIG_for_coding \
       		${DATA}/wav/test/`basename $F`\
       		${DATA}/mfcc/test/`basename $F .wav`.mfcc
	else
		echo "Cannot find the test waveform" $F
		exit
	fi
done

# now make them readable by everybody
echo "Changing file permissions"
chmod go+r ${DATA}/*/*/${USER}_*

done



#!/usr/local/bin/bash

# USER="s0231469"
DATA="/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser"

# how many states is determined by the choice of prototype model
# remember - two of these states are dummy, so the 3state model only 
# has a single emitting state

PROTO=5state
set -x
for USER in `cat resources/user_list`
do
# initialise each model
for WORD in `cat resources/word_list`
do

 echo Initialising model of $WORD

 HInit -T 1 \
	-G ESPS \
        -m 1 \
        -C resources/CONFIG \
        -l $WORD \
        -M models/hmm0 \
        -o $WORD \
        -L lab/train \
	models/proto/$PROTO \
	mfcc/train/${USER}_train.mfcc
done

done






#!/usr/local/bin/bash

# USER="s0231469"
DATA="/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser"

rm TrainFiles
touch TrainFiles

for USER in `cat resources/user_list`
do
echo "$USERLIST ${DATA}/mfcc/train/${USER}_train.mfcc" >> TrainFiles
done

cat TrainFiles
# # train each initialised model
for WORD in `cat /Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/resources/word_list`
do

 echo training model of $WORD

 HRest -T 1 \
	-G ESPS \
        -m 1 \
        -C resources/CONFIG \
        -l $WORD \
        -M models/hmm1 \
        -S TrainFiles \
        -L lab/train/ \
	models/hmm0/$WORD

done

#######################################  Testing starts  ####################################

#!/usr/local/bin/bash

# USER="s0231469"
DATA="/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser"

shopt -s extglob
for USER in `cat resources/test_users`
do
for F in `ls mfcc/test/${USER}_test?(_)??.mfcc`
do
 FF=`basename $F .mfcc`

 echo
 echo Doing $F

 HVite -T 1 -C resources/CONFIG \
	-d models/hmm1 \
	-l rec \
	-w resources/grammar_as_network \
	resources/dictionary \
	resources/word_list \
	$F

done
done


#!/usr/local/bin/bash


# USER="s0231469"
DATA="/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser"
touch outputFile.txt

shopt -s extglob

# for USER in `cat resources/test_users`
# do
HResults -p \
 -I everyone.mlf \
 resources/word_list \
 rec/*.rec >> output/outputFile.txt

# done

# to do results for more than one speaker you need to load more than
# one MLF and more than one set of .rec files. Do it like this:
#
# HResults -p \
#  -I ${DATA}/lab/test/simonk_test.mlf \
#  -I ${DATA}/lab/test/scottn_test.mlf \
#  resources/word_list \
#  rec/simonk_test*.rec \
#  rec/scottn_test*.rec


done