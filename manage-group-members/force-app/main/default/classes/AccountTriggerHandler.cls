public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accts){
        for(Account a : accts){
            if(a.BillingState <> Null){
            a.ShippingState = a.BillingState;
                }
        } 
    }
}