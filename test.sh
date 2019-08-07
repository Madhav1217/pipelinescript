#!/bin/sh
aws codepipeline start-pipeline-execution --name fristpipeline >> fristpipeline.log 2>&1
data=$(grep "pipelineExecutionId" fristpipeline.log)
pipelineid=$(echo "$data" | sed 's/.*| \(.*\)|/\1/')
echo $pipelineid
chmod a+x status.sh
./status.sh
rm -rf fristpipeline.log


