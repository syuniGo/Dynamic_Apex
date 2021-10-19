public with sharing class PullLookupexample {
    private Apexpages.StandardController stdCtrl;

    public PullLookupexample(Apexpages.StandardController controller) {
        stdCtrl = controller;
    }

    public void AccountSelected() {
        Case cs = (Case) stdCtrl.getRecord();
        if (!String.isBlank(cs.AccountId)) {
            cs.Account = [
                SELECT Website, Phone
                FROM Account
                WHERE id = :cs.AccountId
            ];
        } else {
            cs.Account = null;
        }
    }
}
