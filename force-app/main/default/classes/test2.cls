public with sharing class test2 {
    public static void soqlMethod() {
        String s = 'Select Name from Account';
        List<SObject> acList = Database.query(s);

        String qr = 'Select Id';
        String[] fieldList = new List<String>();

        fieldList.add('Name');
        fieldList.add('NumberOfEmployees');
        fieldList.add('Phone');

        String objName = 'Account';
        for (String f : fieldList) {
            qr += ',' + f;
        }

        qr += ' From' + objName;

        String s = String.escapeSingleQuotes(qr);

        List<SObject> list2 = Database.query(qr);
    }
}
