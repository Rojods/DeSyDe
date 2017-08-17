#!/bin/bash
Experiment="--- Experiments for DATE 2018 ---"
echo $Experiment
echo $Experiment > log.txt
#number of experiments
total_experiments=1

echo -n "Insert the experiment number or first-exp last-exp (Enter for all experiments) > "
read first_experiment exp_no
if [ "$exp_no" == ""]
then
    if [ "$first_experiment" == ""]
	then
	    echo "Running all experiments"
	    first_exp=1
	    last_exp=$total_experiments
    else
        first_exp=$first_experiment
        last_exp=$first_experiment
        echo "Running experiment "$first_experiment
    fi
else
    first_exp=$first_experiment
    last_exp=$exp_no
    echo "Running experiments "$first_exp" to "$last_exp
fi


for (( i=$first_exp;i<=$last_exp;i++)); do
    printf "\n" >> log.txt
    echo "--- Experiment "$i" MCR ..." >> log.txt
    date >> log.txt
    ls exp_$i/sdfs >> log.txt
    SECONDS=0
    #sudo chrt --rr 99 ./../../bin/adse --config exp_$i/config.cfg --dse.th_prop MCR --output exp_$i/MCR/
    ./../../bin/adse --config exp_$i/config.cfg --dse.th_prop MCR --output exp_$i/MCR/
    duration=$SECONDS
    echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed." >> log.txt
    echo "end of experiment "$i >> log.txt
    date >> log.txt

done
exit 