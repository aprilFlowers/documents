#!/bin/bash
for id in `seq -f %03g 0 63`
do
	mysql -uroot -ptest -htest -e "use databases; create table giftcode_record_$id like giftcode_record;"
	echo gift_$id done!
done


