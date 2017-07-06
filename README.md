## A: Project: WebServiceAccountCreation

Contains 2 files:

### GenX_DataCreationHelper.cls
- Need to deploy this Salesforce Org.
- Follow these steps:
  Login to Salesforce Org
  Setup -> Build -> Develop -> Apex Classes -> New
  Copy and paste the contents of this .cls file
  Save

### DataCreation.script
- This is a sample script using the above Apex class file to create an Account in Salesforce Org
- Login to https://workbench.developerforce.com/login.php
- Navigate to Utilities -> Apex Execute
- Copy and paste this in text area 'Enter Apex code to be executed as an anonymous block:' and click on 'Execute' button.
- Additional Objects can be created as well by simply leveraging on this concept.


## B: Project: OrderCloner

Contains 1 file:

### OrderCloner-ApexScript
- This is a sample apex script to clone an Order from an existing Order in Salesforce Org
- Login to https://workbench.developerforce.com/login.php
- Navigate to Utilities -> Apex Execute
- Copy and paste this in text area 'Enter Apex code to be executed as an anonymous block:'
- Make edits as needed, especially, provide which order number you want to clone.
String orderNum = '08065827';
- If not changing default values, this script will clone the above order by creating a new Contract and Order and activate Contract and Order under same account as source Order being cloned
- If want to clone it under a different Account, use the 
Map <String,Object> overRideValuesMap.

See commented lines for usage

- Once done customizing, click on 'Execute' button.
- Additional Objects can be created as well by simply leveraging on this concept.


