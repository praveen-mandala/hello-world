public class AccountQueryAction {
  @InvocableMethod(label='Sample Flow' description='Returns the list of account names corresponding to the specified account IDs.')
  public static List<String> getAccountNames() {
      List<String> lstReturn = new List<String>();
      lstReturn.add('Test');
      return lstReturn;
  }
}