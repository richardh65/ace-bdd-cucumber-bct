#!/bin/bash

# Assumes a shell with the ACE profile already loaded

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
ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/FridayApplication-work-dir --project FridayApplication --project FridayApplication_Test
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
ibmint deploy --input-path $PWD --output-work-directory /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --project WholeFlowWithMockedNodeApplication --project WholeFlowWithMockedNodeApplication_Test --project WholeFlowWithMockedNodeApplication_TDD
IntegrationServer -w /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowWithMockedNodeApplication_TDD
IntegrationServer -w /tmp/bdd/WholeFlowWithMockedNodeApplication-work-dir --no-nodejs --start-msgflows no --test-project WholeFlowWithMockedNodeApplication_Test

# Clean up JARs left by ibmint - git will notice if we leave them around; while
# we could ignore JAR files with .gitignore, that would make it harder to upgrade
# cucumber JARs later. Maven solves this (see maven branch) . . . 
rm *_*/*_*.jar
