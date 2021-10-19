// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);
System.debug(test1.getObjectAPINameToLabel());
System.debug(test1.getSObjectFields('Account'));

System.debug(test1.getSOQL('Account'));
System.debug(test1.getPicklistValuesMap('Account', 'Tpye'));
System.debug(test1.getRecordTypeIdsByName('Account'));

Schema.SObjectType currentObjectType = Account.getSObjectType();
System.debug('IS CUSTOM OBJECT =  ' + currentObjectType.fields);
Schema.DescribeSObjectResult currentSObjectResult = currentObjectType.getDescribe();
System.debug('API NAME = ' + currentSObjectResult.getName());
System.debug('IS CUSTOM OBJECT =  ' + currentSObjectResult.isCustom());
System.debug('IS Accessible = ' + currentSObjectResult.isAccessible());
System.debug('IS Creatable = ' + currentSObjectResult.isCreateable());
System.debug('IS Updateable = ' + currentSObjectResult.isCreateable());
System.debug('IS Deletable = ' + currentSObjectResult.isDeletable());
System.debug('IS Deletable = ' + Schema.SObjectType.Account.isDeletable());

String s = '\'Hello Jason\'';
system.debug(s); // Outputs 'Hello Jason'
String escapedStr = String.escapeSingleQuotes(s);
// Outputs \'Hello Jason\'
system.debug(escapedStr);
// Escapes the string \\\' to string \'
system.assertEquals('\\\'Hello Jason\\\'', escapedStr);

Map<String, Schema.SObjectField> accountFieldMap = Schema.getGlobalDescribe()
    .get('Account')
    .getDescribe()
    .fields.getMap();
System.debug(accountFieldMap);

// Get the describe result for the Name field on the Account object
Schema.DescribeFieldResult dfr = Schema.sObjectType.Account.fields.Name;
System.debug(dfr);

// Verify that the field token is the token for the Name field on an Account object
System.assert(dfr.getSObjectField() == Account.Name);

// Get the describe result from the token
dfr = dfr.getSObjectField().getDescribe();
Schema.DescribeFieldResult dfr = Schema.SObjectType.Account.fields.industry;
System.debug(dfr);
