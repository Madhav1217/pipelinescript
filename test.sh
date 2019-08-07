#!/bin/sh
aws codepipeline start-pipeline-execution --name fristpipeline >> fristpipeline.log 2>&1
data=$(grep "pipelineExecutionId" fristpipeline.log)
pipelineid=$(echo "$data" | sed 's/.*| \(.*\)|/\1/')
echo $pipelineid
<<<<<<< HEAD
pipelineid=$1
while true
do
   aws codepipeline get-pipeline-execution --pipeline-name fristpipeline --pipeline-execution-id $pipelineid >> status_data.log 2>&1
   cat status_data.log
   status_value=$(grep "InProgress" status_data.log)
   echo $status_value
   if [ -z "$status_value" ]; then
        echo "successfully completed ->pipelineid: $pipelineid"
        echo $(grep "status" status_data.log)
        mv status_data.log bkstatus_data.log
        break
   fi
   sleep 60
   mv status_data.log bkstatus_data.log
done
rm -rf fristpipeline.log



=======
chmod -R 777 status.sh
./status.sh $pipelineid
rm -rf fristpipeline.log
>>>>>>> f2542c8486de05a5f1f69c66235658575c8e5004
