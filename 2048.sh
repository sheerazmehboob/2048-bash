#!/bin/bash

declare -i Score         #variable for storing score
declare -i Moves         #variable for storing moves   
declare Player_Name=""   #variable for storing player_name
declare -A Board         #array for Game Board
declare -A Temp          #temporary array for some checking conditions 


#------< Funtion To Input Player Name >------#

Initial_Display()
{
 
clear
echo -e "\t  +===========================+ "
echo -e "\t  |-------< 2048 GAME >-------| "
echo -e "\t  +===========================+ \n"  

#taking input of player name
read -p "          Enter Your Name : " Player_Name

}

#------< Funtion To Display Game Board >------#

Display_Board()
{

clear
echo -e "\t  +===========================+ "
echo -e "\t  |-------< 2048 GAME >-------| "
echo -e "\t  +===========================+ "  

echo -e "\n\t  +===========================+ " 
echo -e "\t        PLAYER NAME : " $Player_Name
echo -e "\t            SCORE : " $Score
echo -e "\t            MOVES : " $Moves
echo -e "\t  +===========================+ \n"

#generating 4x4 game's board by using loops 

#using for loop for rows
for (( i = 0; i < 4; i++ ))                    
do
	echo -e "\t+===============================+"
        
    #using for loop for columns
    for (( j = 0; j < 4; j++ ))  
	do
            #conditions to generate board accurately
	    if [[ ${Board[$i,$j]} -eq 0 ]];
	       then
		  echo -e -n "\t|   "
	    else
		  echo -e -n "\t|  ${Board[$i,$j]} "
	    fi
    done
	          echo -e "\t|"
done
echo -e "\t+===============================+\n\t\t\t\t"
}

#------< Funtion For Just First Turn Of Game >------#

First_Turn()
{
  #Generating 1st Random Number
  while true
   do 
     #Generating Random Index
     x=$((0 + RANDOM % 4))
     y=$((0 + RANDOM % 4))
     
     #if value at Generated Index is 0
     if [[ ${Board[$x,$y]} -eq 0 ]];
        then
       
       #this formula will generate only 2 or 4 
       z=$((x%2+1))
       
       #place 2 or 4 at generated random position
       Board[$x,$y]=$((2**$z))
       break
       fi
    done

  #Generating 2nd Random Number
  while true
   do 
     #Generating Random Index
     i=$((0 + RANDOM % 4))
     j=$((0 + RANDOM % 4))
     
     #if value at Generated Index is 0
     if [[ ${Board[$i,$j]} -eq 0 ]];
        then
       
       #this formula will generate only 2 or 4 
       k=$((i%2+1))
       
       #place 2 or 4 at generated random position
       Board[$i,$j]=$((2**$k))
       break
       fi
    done

}

#------< Funtion To Generate Random Number >------#

Generate_New_Number()
{
 #infinite loop
  while true
   do 
     #Generating Random Index
     i=$((0 + RANDOM % 4))
     j=$((0 + RANDOM % 4))
     
     #if value at Generated Index is 0
     if [[ ${Board[$i,$j]} -eq 0 ]];
        then
       
       #this formula will generate only 2 or 4
       k=$((i%2+1))
       
       #place 2 or 4 at generated random position
       Board[$i,$j]=$((2**$k))
       break
       fi
   done
}

#------< Funtion To Move Up >------#

Up_Move()
{

#starting from the 2nd row
#as we cant move up from the 1st (Most Upper) row
for((column=0; column<4; column++))
do
  i=0 
  j=$column

  for((row=1; row<4; row++))
  do
    #if any tile's value != 0
    if [[ ${Board[$row,$column]} -ne 0 ]];
    then
      
      #if upper tile's value = 0 || if upper tile's value = lower tile's value
      #In both cases we can move up
      if [[ ${Board[$row-1,$column]} -eq 0 || ${Board[$row-1,$column]} -eq ${Board[$row,$column]} ]];
      then 
        
         #if upper tile's value = lower tile's value
         #It means we have to add them by moving up
         if [[ ${Board[$i,$j]} -eq ${Board[$row,$column]} ]];
         then
          
          #multilply upper tile's value with 2
          Board[$i,$j]=$(( ${Board[$i,$j]} * 2 ))
          
          #do store zero in lower(previous) tile  
          Board[$row,$column]=0
          
          #store the score in variable
          Score=$(( Score + ${Board[$i,$j]} ))
          else
               #if upper tile's value = 0
               #It means we have move up simply
               if [[ ${Board[$i,$j]} -eq 0 ]];
               then 
                 
                 #equal the upper tile's value = lower tile's value
                 Board[$i,$j]=${Board[$row,$column]}

                 #do store zero in lower(previous) tile
                 Board[$row,$column]=0 
               
               #move lower tiles to possible upper positions
               elif [ ${Board[$((i+1)),$j]} -eq 0 ]
                 then
                 ((i++))
                 
                 #keep storing lower tile value in upper tile
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #keep storing zero in lower(previous) tiles
                 Board[$row,$column]=0 
                 else
                 ((i++))
               fi  
           movecheck=1
         fi
      else
      ((i++))
      fi
    fi    
  done
done

#if move occur, increment in Move variable
if [[ $movecheck -eq 1 ]];
then 
((Moves++))
fi 

}

#------< Funtion To Move Down >------#

Down_Move()
{

#starting from the 3rd row
#as we cant move down from the 4rth (last) row
for((column=0; column<4; column++))
do
  i=3 
  j=$column

  for((row=2; row>=0; row--))
  do
    #if any tile's value != 0
    if [[ ${Board[$row,$column]} -ne 0 ]];
    then
      
      #if lower tile's value = 0 || if lower tile's value = upper tile's value
      #In both cases we can move down
      if [[ ${Board[$row+1,$column]} -eq 0 || ${Board[$row+1,$column]} -eq ${Board[$row,$column]} ]];
      then 

         #if lower tile's value = upper tile's value
         #It means we have to add them by moving down
         if [[ ${Board[$i,$j]} -eq ${Board[$row,$column]} ]];
         then

          #multilply lower tile's value with 2
          Board[$i,$j]=$(( ${Board[$i,$j]} * 2 ))
          
          #do store zero in upper(previous) tile 
          Board[$row,$column]=0

          #store the score in variable
          Score=$(( Score + ${Board[$i,$j]} ))
          else
               #if lower tile's value = 0
               #It means we have move down simply
               if [[ ${Board[$i,$j]} -eq 0 ]];
               then 
                 
                 #equal the lower tile's value = upper tile's value
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #do store zero in upper(previous) tile
                 Board[$row,$column]=0 
              
               #move lower tiles to possible lower positions
               elif [ ${Board[$((i-1)),$j]} -eq 0 ]
                 then
                 ((i--))
                 
                 #keep storing upper tile value in lower tile
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #keep storing zero in upper(previous) tiles
                 Board[$row,$column]=0
                 else
                 ((i--)) 
               fi    
           movecheck=1
           fi
      else
      ((i--))
      fi
    fi    
  done
done

#if move occur, increment in Move variable
if [[ $movecheck -eq 1 ]];
then 
((Moves++))
fi 

}

#------< Funtion To Move Left >------#

Left_Move()
{

#starting from the 2nd Column
#as we cant move left from the 1st (left border) column

for((row=0; row<4; row++))
do
  i=$row 
  j=0

  for((column=1; column<4; column++))
  do
    #if any tile's value != 0
    if [ ${Board[$row,$column]} -ne 0 ];
    then
      
      #if left tile's value = 0 || if left tile's value = right tile's value
      #In both cases we can move left
      if [ ${Board[$row,$((column-1))]} -eq 0 ] || [ ${Board[$row,$(( column-1 ))]} -eq ${Board[$row,$column]} ];
      then 

         #if left tile's value = right tile's value
         #It means we have to add them by moving left
         if [ ${Board[$i,$j]} -eq ${Board[$row,$column]} ];
         then
          
          #multilply left tile's value with 2
          Board[$i,$j]=$(( ${Board[$i,$j]} * 2 ))
          
          #do store zero in right(previous) tile
          Board[$row,$column]=0
        
          #store the score in variable
          Score=$(( Score + ${Board[$i,$j]} ))
          else
               #if left tile's value = 0
               #It means we have move left simply
               if [[ ${Board[$i,$j]} -eq 0 ]];
               then 
               
                 #do equal the left tile's value = right tile's value
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #do store zero in right(previous) tile
                 Board[$row,$column]=0
               
               #move left tiles to possible left positions
               elif [ ${Board[$i,$((j+1))]} -eq 0 ]
               then
                 ((j++))
                 
                 #keep storing right tile value in left tile
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #keep storing zero in right(previous) tiles
                 Board[$row,$column]=0 
                 else
                 ((j++))
               fi    
           movecheck=1
           fi
      else
      ((j++))
      fi
    fi    
  done
done

#if move occur, increment in Move variable
if [[ $movecheck -eq 1 ]];
then 
((Moves++))
fi 

}

#------< Funtion To Move Right >------#

Right_Move()
{

#starting from the 3rd Column
#as we cant move right from the 4rth (right border) column

for((row=0; row<4; row++))
do
  i=$row 
  j=3

  for((column=2; column>=0; column--))
  do
    #if any tile's value != 0
    if [[ ${Board[$row,$column]} -ne 0 ]];
    then
       
      #if right tile's value = 0 || if right tile's value = left tile's value 
      #In both cases we can move right
      if [[ ${Board[$row,$column+1]} -eq 0 || ${Board[$row,$column+1]} -eq ${Board[$row,$column]} ]];
      then 

         #if right tile's value = left tile's value
         #It means we have to add them by moving right
         if [[ ${Board[$i,$j]} -eq ${Board[$row,$column]} ]];
         then

          #multilply right tile's value with 2
          Board[$i,$j]=$(( ${Board[$i,$j]} * 2 ))
          
          #do store zero in left(previous) tile
          Board[$row,$column]=0
          
          #store the score in variable 
          Score=$(( Score + ${Board[$i,$j]} ))
          else
               #if right tile's value = 0
               #It means we have move left simply
               if [[ ${Board[$i,$j]} -eq 0 ]];
               then 
                 
                 #equal the right tile's value = left tile's value
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #do store zero in left(previous) tile
                 Board[$row,$column]=0

                 #move right tiles to possible right positions 
                 elif [ ${Board[$i,$((j-1))]} -eq 0 ]
                 then
                 ((j--))
                  
                 #keep storing left tile value in right tile
                 Board[$i,$j]=${Board[$row,$column]}
                 
                 #keep storing zero in left(previous) tiles
                 Board[$row,$column]=0 
                 else
                 ((j--))
               fi    
           movecheck=1
           fi
      else
      ((j--))
      fi
    fi    
  done
done

#if move occur, increment in Move variable
if [[ $movecheck -eq 1 ]];
then 
((Moves++))
fi 

}

#------< Funtion To Compare Current Board With The Previous One >------#

Check()
{

#we have saved previous board in Temp Array In Main Function

check=1
for ((i=0;i<4;i++))
do
        
    for ((j=0;j<4;j++))
    do
         #if values at previous board != values at current board
         #it means no move occur
         if [[ ${Temp[$i,$j]} -ne ${Board[$i,$j]} ]];
         then
         check=0
         break
         fi
    done
done

}

#------< Funtion For The Checking Win Condition >------#

Check_Win()
{

for ((i=0;i<4;i++))
do
        
    for ((j=0;j<4;j++))
    do
         #if any tile of board == 2048
         if [[ ${Board[$i,$j]} -eq 2048 ]];
         then
         echo "\t\t  You Won The Game!"
         exit
         fi
    done
done

}

#------< Funtion For The Checking Game Over Conditions >------#

Game_Over()
{

#this count will become 1 if any tile is still zero
count=0

#this count will become 1 if there's still any possibility of adding tiles
count1=0

#first check if all the tiles fill or not
for ((i=0;i<4;i++))
do      
    for ((j=0;j<4;j++))
    do
         #if any tile of board == 0
         #it means there's still some space left 
         if [[ ${Board[$i,$j]} -eq 0 ]];
         then
         ((count++))
         fi
    done
done 

#Now check if there's any possibility of adding tiles
for ((i=0;i<4;i++))
do     
    for ((j=0;j<4;j++))
    do
          
         #------< Conditions For All 4 Corner Tiles >------#         

         #condition for the Upper-Left Corner Tile
         if [[ i -eq 0 && j -eq 0 ]];
         then
           #if it can add with right or lower tile 
           if [[ ${Board[$i,$j]} -eq ${Board[$i,$((j+1))]} || ${Board[$i,$j]} -eq ${Board[$((i+1)),$j]} ]];
           then
              ((count1++))  
           fi
         fi
         
         #condition for the Bottom-Left Corner Tile
         if [[ i -eq 3 && j -eq 0 ]]
         then
           #if it can add with upper or right tile 
           if [[ ${Board[$i,$j]} -eq ${Board[$((i-1)),$j]} || ${Board[$i,$j]} -eq ${Board[$i,$((j+1))]} ]];
           then
              ((count1++))  
           fi
         fi

         #condition for the Upper-Right Corner Tile
         if [[ i -eq 0 && j -eq 3 ]];
         then
           #if it can add with left or lower tile 
           if [[ ${Board[$i,$j]} -eq ${Board[$i,$((j-1))]} || ${Board[$i,$j]} -eq ${Board[$((i+1)),$j]} ]];
           then
              ((count1++))  
           fi
         fi
 
         #condition for the Bottom-Right Corner Tile
         if [[ i -eq 3 && j -eq 3 ]];
         then
           #if it can add with right or upper tile 
           if [[ ${Board[$i,$j]} -eq ${Board[$((i-1)),$j]} || ${Board[$i,$j]} -eq ${Board[$i,$((j-1))]} ]];
           then
              ((count1++))  
           fi
         fi

         #------< Conditions For Other Than Corner Tiles >------#   

         if [[ i -eq 1 && j -eq 1 || i -eq 1 && j -eq 2 || i -eq 2 && j -eq 1 || i -eq 2 && j -eq 2 ]];
         then
           #if other than corner tiles can add or not
           if [[ ${Board[$i,$j]} -eq ${Board[$((i-1)),$j]} || ${Board[$i,$j]} -eq ${Board[$i,$((j-1))]} || ${Board[$i,$j]} -eq ${Board[$((i+1)),$j]} || ${Board[$i,$j]} -eq ${Board[$i,$((j+1))]} ]];
           then
              ((count1++))  
           fi
         fi
    done
done 

       #if both counts remains zero, means game over!
       if [[ count -eq 0 && count1 -eq 0 ]];
       then 
       Game_End=1
       fi

}


#------< Main Function Starts >------#

#In Start Initializing Both Arrays with zero
for ((i=0;i<4;i++))
do        
    for ((j=0;j<4;j++))
    do
        Temp[$i,$j]=0
        Board[$i,$j]=0
    done
done

#calling Display Function For Input Player Name
Initial_Display

#clear the screen
clear

#calling First_Turn Function For The Only First Time 
#As 1st time we have to generate two random numbers
First_Turn

#calling Display Board FUnction
Display_Board

#Code of Escape character, Used In Input Arrow Keys 
escape_char=$(printf "\u1b")

#infinit loop 
while true;
do

#store Board's Initial Value In Temporary Array
for ((i=0;i<4;i++))
do        
    for ((j=0;j<4;j++))
    do
        Temp[$i,$j]=${Board[$i,$j]}
    done
done

#---< Procedure for taking Input of Arrow Keys >---#

#whenever we press Arrow key as an input. 
#Input box becomes equal to '\u1b[A'

#where '\u1b' is code of ESC (Escape)
# '[A' For Arrow-Up
# '[B' For Arrow-Down
# '[C' For Arrow-Right
# '[D' For Arrow-Left  

#So, as user press the arrow key, we'll check first character of it

#Get First Character Of Input
read -rsn1 Key 

#if it's equal to escape key code (which we saved in escape_char variable)
if [[ $Key == $escape_char ]];
    then
    
    #then Get the next two characters of input 
    read -rsn4 -t 0.001 Key
fi

#Switch Cases to check arrow keys
#And Call Move Functions Accordingly
case $Key in

    '[A')  Up_Move;;      # if '[A' -> Arrow-Up  
    '[B')  Down_Move;;    # if '[B' -> Arrow-Down
    '[C')  Right_Move;;   # if '[C' -> Arrow-Right
    '[D')  Left_Move;;    # if '[D' -> Arrow-Left

esac

#first call Check Function to check wether's there's any move occur or not
Check

#if yes 
if [[ $check -eq 0 ]];
then

#then call Generate Number Function
Generate_New_Number

#call Display Board Function
Display_Board  
fi

#call Game Over Function to check Game is Over Or Not 
Game_Over

#if yes
if [[ $Game_End -eq 1 ]];
then

#then break the infinite loop come out of the game. 
echo -e "\t\t    Game Over!\n\n"
break
fi
done   

