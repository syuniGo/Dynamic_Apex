public with sharing class test1 {
    public static Map<String, String> getObjectAPINameToLabel() {
        //Initializing Map
        Map<String, String> objectAPINameToLableMap = new Map<String, String>();
        // Getting all sObjects.metadate
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();
        for (String globalDescribeKey : globalDescribeMap.keySet()) {
            //getting the current sobject type
            Schema.SObjectType currentSObjectType = globalDescribeMap.get(
                globalDescribeKey
            );
            //getting the current sobject description result from sobject type
            Schema.DescribeSObjectResult currentSObjectResult = currentSObjectType.getDescribe();
            // getting the api name and value of current sobject and adding it to the map
            objectAPINameToLableMap.put(
                currentSObjectResult.getName(),
                currentSObjectResult.getLabel()
            );
        }
        return objectAPINameToLableMap;
    }

    public static Set<String> getSObjectFields(String sObjectName) {
        // Initializing fieldName set
        Set<String> fieldNames = new Set<String>();
        //getting metadata of all sobjects
        Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe();
        // getting the  reference to current sObject
        Schema.SObjectType sObjectTypeInstance = sObjectMap.get(sObjectName);

        if (sObjectTypeInstance != null) {
            // Getting fields for current sobject
            Map<String, Schema.SObjectField> fieldMap = sObjectTypeInstance.getDescribe()
                .fields.getMap();

            // checking each field one by one  if it s accessible adding its name to fieldname set
            for (Schema.SObjectField field : fieldMap.values()) {
                Schema.DescribeFieldResult fieldResult = field.getDescribe();
                if (fieldResult.isAccessible()) {
                    fieldNames.add(fieldResult.getName());
                }
            }
        }
        return fieldNames;
    }

    //this method is used to return soql query consisting of all fields for
    // an  object thact are accessible by the current user
    public static String getSOQL(String objectName) {
        //getting the field names using the object name
        Set<String> fieldNames = getSObjectFields(objectName);
        //forming the soql query
        String query = 'SELECT';
        for (String fieldName : fieldNames) {
            query += fieldName + ',';
        }

        //removing last from the soql query stirng
        query = query.substring(0, query.lastIndexOf(','));
        //adding the object name to soql
        query += ' From ' + objectName;
        //returing the soql
        return query;
    }

    /* this method is going to return the picklist field values and the associated label for
     an object and a field which are passed in as parameters */
    public static Map<String, String> getPicklistValuesMap(
        String objectAPIName,
        String fieldAPIName
    ) {
        //initializing picklist field map to store value and label of picklist entries
        Map<String, String> picklistFieldMap = new Map<String, String>();
        //getting  the field result for the current field
        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe()
            .get(objectAPIName)
            //（let a = b == null ? null : b.a）问号点用于判断是否null
            ?.getDescribe()
            ?.fields
            ?.getMap()
            ?.get(fieldAPIName)
            ?.getDescribe();

        // check if the field type is a picklist
        if (
            (fieldResult != null) &&
            (fieldResult.getType() == Schema.DisplayType.PICKLIST)
        ) {
            //get all picklist entries
            List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
            //loop over all picklist entries
            for (Schema.PicklistEntry picklistEntry : picklistEntries) {
                // if the picklist entry is active getting the label and value and putting those in map
                if (picklistEntry.isActive()) {
                    String picklistLabel = picklistEntry.getLabel();
                    String picklistValue = picklistEntry.getValue();
                    picklistFieldMap.put(picklistLabel, picklistValue);
                }
            }
            return picklistFieldMap;
        }
    }

    public static Map<String, Id> getRecordTypeIdsByName(String objectName) {
        Map<String, Id> RecordTypesMap = new Map<String, Id>();
        Schema.DescribeSObjectResult objectResult = Schema.getGlobalDescribe()
            .get(objectName)
            ?.getDescribe();

        if (objectResult != null) {
            List<Schema.RecordTypeInfo> recordTpeInfos = objectResult.getRecordTypeInfos();

            for (Schema.RecordTypeInfo recordTpeInfo : recordTpeInfos) {
                if (recordTpeInfo.isActive() && recordTpeInfo.isAvailable()) {
                    RecordTypesMap.put(
                        recordTypeInfo.getName(),
                        recordTpeInfo.getRecordTypeId()
                    );
                }
            }
        }
        return RecordTypesMap;
    }
}
