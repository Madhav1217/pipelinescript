#!/bin/sh
pipelineid=$1
echo $pipelineid
function pipeline
while true
do
 pipeline =$(aws codepipeline get-pipeline-execution --pipeline-name fristpipeline --pipeline-execution-id $pipelineid )>> status_data.log 2>&1
   cat status_data.log
   status_value=$(grep "InProgress" status_data.log)
   echo $status_value
   if [ $status_value == InProgress ]; then
   return $pipeline
  else
    if [ $status_value == Succeeded ]; then
  echo "Succeeded ->pipelineid: $pipelineid"
        echo $(grep "status" status_data.log)
        mv status_data.log bkstatus_data.log
        exit 0
	else
      if [ $status_value == Failed ]; then
	echo "Failed ->pipelineid: $pipelineid"
        echo $(grep "status" status_data.log)
        mv status_data.log bkstatus_data.log
        exit 0
	fi
   sleep 60
   mv status_data.log bkstatus_data.log
done


  
