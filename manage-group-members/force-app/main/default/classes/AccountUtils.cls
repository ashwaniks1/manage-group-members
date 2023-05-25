public class AccountUtils {
    public static List<Account> accountsByState(String state){
       List<Account> acctList = [SELECT Id, Name FROM Account WHERE billingState = :state];
	   return acctList;
	}
}