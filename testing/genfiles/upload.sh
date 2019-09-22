#!/bin/bash

ls x* > masterlist
list=$(ls x* | wc -l)
echo $list

function subprocess {
  for f in $(cat $k)
         do
	swiftly put --input=./objects/$f cfdelete/$f
  done
}


for i in {1..$list}
 do
    for k in $(cat masterlist)
     do
            subprocess &
     done
 done
