public class NewCaseListController {

    public List<Case> getNewCases() {
        List<Case> cases =  new List<Case>();
        cases = [Select Id,CaseNumber from Case Where Status = 'New'];
        return cases;
    }
}