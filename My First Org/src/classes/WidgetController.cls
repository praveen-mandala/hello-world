@RestResource(urlMapping='/Widgets/*')
global class WidgetController {

    @HttpGet
    global static List<Opportunity > getWidgets() {
        List<Opportunity> widgets = [SELECT Name from Opportunity];
        return widgets;
    }

    @HttpPost 
    global static String createNewWidget(String Name) {
        Opportunity  w = new Opportunity ();
        w.Name = Name;
        insert w;

        return 'Done';
   }

    @HttpDelete
    global static String deleteWidgetById() {
        String Id = RestContext.request.params.get('Id');
        List<Opportunity > w = [ Select ID from Opportunity  where Id= :Id];

        delete w;

        return 'Deleted Widget';
    }

    @HttpPut
    global static String updateWidget(String Id) {
        Opportunity  w = [ Select ID, Name from Opportunity  where Id= :Id];

        w.Description = 'Order updated sucessfully';
        w.LeadSource='Web';
        update w;

        return 'Widget Updated';
    }
}