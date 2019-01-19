public class ConListController {

    public List<Contact> conList{get;set;}
    public ConListController(ApexPages.StandardSetController controller) {
        conList = controller.getSelected();
        System.debug('conList size-->'+conList.size());
    }
}