#!/bin/bash
# debug            
echo "============================ root /  ========================================"
ls -la /
echo "============================ /tmp/work/other/code ========================================"
ls -la /tmp/work/other/code
echo "============================ /tmp/work/other/code/config ========================================"
ls -la /tmp/work/other/code/config
echo "============================ setup profile ========================================"
# make
# cat  /opt/ibm/ace-12/server/bin/mqsiprofile
. /opt/ibm/ace-12/server/bin/mqsiprofile
# build-and-run-tests.sh            
# Print commands to the screen
set -x

# Exit on any error
# set -e

mkdir -p /tmp/bdd
rm -rf /tmp/bdd/*

echo ""
echo "================ Building and running FridayApplication tests"
echo ""
mqsicreateworkdir /tmp/bdd/FridayApplication-work-dir
# need to locate config file
ls -la /tmp/bdd/FridayApplication-work-dir
# copy in config here
cp /tmp/work/other/code/config/server.conf.yaml /tmp/bdd/FridayApplication-work-dir/server.conf.yaml
            
cd /tmp/work/other/code

ls -la
pwd
            
ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/FridayApplication-work-dir --project FridayApplication --project FridayApplication_Test --trace trace.txt
ls -la
cat trace.txt
IntegrationServer -w /tmp/bdd/FridayApplication-work-dir --no-nodejs --start-msgflows no --test-project FridayApplication_Test

echo ""
echo "================ Building and running WholeFlowApplication tests"
echo ""
mqsicreateworkdir /tmp/bdd/WholeFlowApplication-work-dir
ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/WholeFlowApplication-work-dir --project WholeFlowApplication --project WholeFlowApplication_Test
IntegrationServer -w /tmp/bdd/WholeFlowApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowApplication_Test

            echo ""
            echo "================ Building and running WholeFlowWithMockedNodeApplication tests"
            echo ""
            # Could run a separate TDD test work directory if there was a danger of interference
            mqsicreateworkdir /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir
            ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --project WholeFlowWithMockedNodeApplication --project /tmp/work/other/code/WholeFlowWithMockedNodeApplication_Test --project /tmp/work/other/code/WholeFlowWithMockedNodeApplication_TDD
            IntegrationServer -w /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowWithMockedNodeApplication_TDD
            IntegrationServer -w /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowWithMockedNodeApplication_Test

            # Clean up JARs left by ibmint - git will notice if we leave them around; while
            # we could ignore JAR files with .gitignore, that would make it harder to upgrade
            # cucumber JARs later. Maven solves this (see maven branch) . . . 
            rm *_*/*_*.jar

            # run the trace collection
            /usr/local/ant/apache-ant-1.10.12/bin/ant -f trace_build.xml            
            ls -la /tmp/work/other/code/coveragetemp
            /usr/local/sonar-scanner/sonar-scanner-4.7.0.2747-linux/bin/sonar-scanner -Dproject.settings=./sonar-project-tracing.properties
            ls -la 
            cat BCT_report.sarif