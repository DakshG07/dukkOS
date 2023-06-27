#!/bin/bash

x=1

while [ $x -le 1 ]

do

        echo "Sleeping" | tee -a  /home/USERNAME/SweetDreams.log

        # Wait 5 seconds
        sleep 5

        echo "Waking" | tee -a  /home/USERNAME/SweetDreams.log

        x=$(( $x + 1 ))

done
