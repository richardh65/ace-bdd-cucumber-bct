#!/bin/bash

# debug            
. /opt/ibm/ace-12/server/bin/mqsiprofile

# copied in from build-and-run-tests.sh            
# Print commands to the screen
set -x

# Exit on any error
set -e

mkdir -p /tmp/bdd
rm -rf /tmp/bdd/*

echo ""
echo "================ Building and running FridayApplication tests"
echo ""
mqsicreateworkdir /tmp/bdd/FridayApplication-work-dir
# need to locate config file to replace
ls -la /tmp/bdd/FridayApplication-work-dir
# copy in config here with debug enabled
cp /tmp/work/other/code/config/server.conf.yaml /tmp/bdd/FridayApplication-work-dir/server.conf.yaml
            
cd /tmp/work/other/code

            
ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/FridayApplication-work-dir --project FridayApplication --project FridayApplication_Test --trace trace.txt

IntegrationServer -w /tmp/bdd/FridayApplication-work-dir --no-nodejs --start-msgflows no --test-project FridayApplication_Test > test1.txt >2 test2.txt 

cat test1.txt 

cat test2.txt

if $(cat test1.txt | grep -q "org.opentest4j.AssertionFailedError"); then
    echo "found org.opentest4j.AssertionFailedError"
    exit -1

if $(cat test2.txt | grep -q "org.opentest4j.AssertionFailedError"); then
    echo "found org.opentest4j.AssertionFailedError"
    exit -1

# org.opentest4j.AssertionFailedError

# check if any artefacts appear that we can publish
ls -la 

# echo ""
# echo "================ Building and running WholeFlowApplication tests"
# echo ""

# mqsicreateworkdir /tmp/bdd/WholeFlowApplication-work-dir
# ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/WholeFlowApplication-work-dir --project WholeFlowApplication --project WholeFlowApplication_Test
# IntegrationServer -w /tmp/bdd/WholeFlowApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowApplication_Test

# echo ""
# echo "================ Building and running WholeFlowWithMockedNodeApplication tests"
# echo ""
# Could run a separate TDD test work directory if there was a danger of interference
# mqsicreateworkdir /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir
# ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --project WholeFlowWithMockedNodeApplication --project /tmp/work/other/code/WholeFlowWithMockedNodeApplication_Test --project /tmp/work/other/code/WholeFlowWithMockedNodeApplication_TDD
# IntegrationServer -w /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowWithMockedNodeApplication_TDD
# IntegrationServer -w /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowWithMockedNodeApplication_Test

# Clean up JARs left by ibmint - git will notice if we leave them around; while
# we could ignore JAR files with .gitignore, that would make it harder to upgrade
# cucumber JARs later. Maven solves this (see maven branch) . . . 
rm *_*/*_*.jar

