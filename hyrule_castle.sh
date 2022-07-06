#!/bin/bash



#variables

link_hp="60"
hp_max="60"
link_str="15"

boko_hp="30"
boko_str="5"

ganon_hp="150"
ganon_str="20"

position=1
var=$1


#introduction
echo "
Welcome in the Hyrule Castle, you have 10 
ennemies to defeat, good luck.
"


#actions de combat

function attack () {
    if [[ $position -lt 10 ]]; then
       boko_hp=$(($boko_hp-$link_str))
    elif [[ $position -eq 10 ]]; then
       ganon_hp=$(($ganon_hp-$link_str))
    fi
}

function heal () {
    link_hp=$(($link_hp+30))
    if [[ $link_hp -gt $hp_max ]]; then
	link_hp=$hp_max
    fi
}

function attack_suffered () {
    if [[ $position -lt 10 ]]; then
	link_hp=$(($link_hp-$boko_str))
    elif [[ $position -eq 10 ]]; then
	link_hp=$(($link_hp-$ganon_str))
    fi
}



#fonctions texte

function boko () {
echo "

You are against a Bokoblin with" $boko_hp" HP."
}

function ganon () {
echo "
GANON is in front of you, he has" $ganon_hp "HP !"
}

function choice () {
echo "You have" $link_hp "HP.

What do you want to do ?
1. Attack	2. Heal"
}

 
#commandes combat

while [[ $position -lt 10 ]]; do
    echo "
========== FIGHT" $(($position)) "=========="
    while [[ $boko_hp -gt 0 && $link_hp -gt 0 ]]; do
	boko
	choice
	read var
	echo $var
	if [[ $var -eq 1 ]]; then
	    attack
	    echo "You attacked and dealt 15 damages!"
	elif [[ $var -eq 2 ]]; then
	    heal
	    echo "You used heal"
	fi
	if [[ boko_hp -gt 0 ]]; then
	    attack_suffered
	    echo "Bokoblin hit you, you suffered 5 damages."
	fi
    done
	
    if [[ $boko_hp -le 0 ]];then
	echo "GG, you defeated your ennemy !"
	position=$(($position+1))
	echo "You move to the next floor."
	boko_hp=30
    fi
done

#comabt final

while [[ $position -eq 10 ]]; do
echo "
========== GANON =========="
    ganon
    choice
    read var
    echo $var
    if [[ $var -eq 1 ]]; then
	attack
	echo "You attacked and dealt 15 damages"
    elif [[ $var -eq 2 ]]; then
	heal
	echo "You used heal"
    fi
    if [[ $ganon_hp -gt 0 ]]; then
	attack_suffered
	echo "Ouch! Ganon has inflicted 20 damages on you."
    fi
    if [[ $ganon_hp -le 0 ]]; then
	echo "Congratulations ! You defeated the boss !"
	position=$(($position+1))
    elif [[ $link_hp -le 0 ]]; then
	echo "You are dead."
	position=$(($position+1))
    fi
done


