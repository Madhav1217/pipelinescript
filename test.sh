#!/bin/sh
aws codepipeline start-pipeline-execution --name fristpipeline >> fristpipeline.log 2>&1
data=$(grep "pipelineExecutionId" fristpipeline.log)
pipelineid=$(echo "$data" | sed 's/.*| \(.*\)|/\1/')
echo $pipelineid
pipelineid=$1
echo $pipelineid
while true
do
   aws codepipeline get-pipeline-state --name fristPipeline >> status_data.log 2>&1
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


