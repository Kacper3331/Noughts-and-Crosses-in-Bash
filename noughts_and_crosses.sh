#!/bin/bash

array=(0 0 0 0 0 0 0 0 0)
check=0
count=0

function check_same_row_first {

  for i in `seq 1 3 7`; do
    first=${array[$i]}
    second=${array[$i-1]}
    third=${array[$i+1]}

    #sprawdzin warunki brzegowe
    if [ $first != 0 ] && [ $second != 0 ] && [ $third != 0 ]; then
      if [ $first == $second ] && [ $second == $third ]; then
        check=1
        break
      fi
    fi
  done
  return $check
}

function check_same_column {
  for i in {3..5}
  do
    first=${array[$i]}
    second=${array[$i-3]}
    third=${array[$i+3]}

    if [ $first != 0 ] && [ $second != 0 ] && [ $third != 0 ]; then
      if [ $first == $second ] && [ $second == $third ]; then
        check=1
        break
      fi
    fi
  done
  return $check
}

function check_left_cross {
  first=${array[0]}
  second=${array[4]}
  third=${array[8]}

  if [ $first != 0 ] && [ $second != 0 ] && [ $third != 0 ]; then
    if [ $first == $second ] && [ $second == $third ]; then
      check=1
    fi
  fi

  return $check
}

function check_right_cross {
  first=${array[2]}
  second=${array[4]}
  third=${array[6]}
  if [ $first != 0 ] && [ $second != 0 ] && [ $third != 0 ]; then
    if [ $first == $second ] && [ $second == $third ]; then
      check=1
    fi
  fi

  return $check
}

#granie aż wszystkie pola nie zostaną zapełnione
#

for i in "${array[@]}"
do

 echo "Player A input your position from 0 to 8:"
 read pos_x
 echo

 if [ "${array[$pos_x]}" == 0 ]; then
  array[$pos_x]=X
 else
  while : ; do
   echo "This place is already taken please choose different position from 0 to 8:"
   read pos_x
   echo
   [ "${array[$pos_x]}" != 0 ] || break
  done
  array[$pos_x]=X
 fi

 count=$[$count+1]

 echo ${array[0]} ${array[1]} ${array[2]}
 echo ${array[3]} ${array[4]} ${array[5]}
 echo ${array[6]} ${array[7]} ${array[8]}
 echo

 check_same_row_first array
 check_same_column array
 check_left_cross array
 check_right_cross array

 if [ $check == 1 ]; then
   echo "You win player A"
   break
 fi

 if [ $count == 9 ]; then
   break
 fi

 echo "Player B input your position from 0 to 8:"
 read pos_y
 echo

 if [ "${array[$pos_y]}" == 0 ]; then
  array[$pos_y]=O
 else
  while : ; do
   echo "This place is already taken please choose different position from 0 to 8:"
   read pos_y
   echo
   [ "${array[$pos_y]}" != 0 ] || break
  done
  array[$pos_y]=O
 fi

 count=$[$count+1]

 echo ${array[0]} ${array[1]} ${array[2]}
 echo ${array[3]} ${array[4]} ${array[5]}
 echo ${array[6]} ${array[7]} ${array[8]}

 check_same_row_first array
 check_same_column array
 check_left_cross array
 check_right_cross array

 if [ $check == 1 ]; then
   echo "You win player B"
   break
 fi
done
