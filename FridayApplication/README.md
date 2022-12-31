# FridayApplication

Simple example using ACE with Cucumber BDD, building on the ideas (and initial feature) 
from https://cucumber.io/docs/guides/10-minute-tutorial/ using a very simple flow to 
implement the requirements:

![Flow overview](bdd-flow.png)

## Usage 

Import into the ACE v12 toolkit, and run the test project. This should cause the cucumber BDD tests to run 
and pass (checked on Windows and Linux).

Can also be run from the command line:
```
tdolby@IBM-PF3K066L:~$ mqsicreateworkdir ~/tmp/ace-bdd-cucumber-work-dir
mqsicreateworkdir: Copying sample server.config.yaml to work directory
1 file(s) copied.
Successful command completion.

tdolby@IBM-PF3K066L:~$ mqsibar -c -w ~/tmp/ace-bdd-cucumber-work-dir -a /mnt/c/Users/684084897/IBM/ACET12/ace-bdd-cucumber-workspace/BARfiles/FridayApplication.bar
Generating runtime objects: '/home/tdolby/tmp/ace-bdd-cucumber-work-dir/run' ...

BIP8071I: Successful command completion.

tdolby@IBM-PF3K066L:~$ IntegrationServer -w ~/tmp/ace-bdd-cucumber-work-dir --test-project FridayApplication_Test --start-msgflows no --no-nodejs
2022-06-03 08:14:46.950160: BIP1990I: Integration server 'ace-bdd-cucumber-work-dir' starting initialization; version '12.0.4.0' (64-bit)
2022-06-03 08:14:46.954188: BIP9905I: Initializing resource managers.
2022-06-03 08:14:47.946236: BIP9906I: Reading deployed resources.
2022-06-03 08:14:47.953792: BIP9907I: Initializing deployed resources.
2022-06-03 08:14:47.954760: BIP2155I: About to 'Initialize' the deployed resource 'FridayApplication' of type 'Application'.
2022-06-03 08:14:47.955696: BIP2155I: About to 'Initialize' the deployed resource 'FridayApplication_Test' of type 'TestProjectType'.
2022-06-03 08:14:48.091808: BIP2155I: About to 'Start' the deployed resource 'FridayApplication' of type 'Application'.
2022-06-03 08:14:48.092132: BIP9910I: Running tests in test project 'FridayApplication_Test'.
2022-06-03 08:14:49.501      1 STARTING TEST:Sunday isn't Friday
2022-06-03 08:14:49.533      1 FINISHED TEST:Sunday isn't Friday SUCCESSFUL
2022-06-03 08:14:49.533      1 STARTING TEST:Friday is Friday
2022-06-03 08:14:49.539      1 FINISHED TEST:Friday is Friday SUCCESSFUL
2022-06-03 08:14:49.544      1
TEST RESULTS:

TOTALS:
  PASSED    :2
  FAILED    :0
  ABORTED   :0
  TIME(secs):0.089
2022-06-03 08:14:49.545068: BIP9911I: Running tests in test project 'FridayApplication_Test' completed successfully.
```
