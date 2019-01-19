@RestResource(urlMapping='/getOrderInformation/*')
global class OrderInformation {
  
    /*
* Description:calculate tax for amount in invoice.
* return:tax
* 
*/
    /*@HttpPost
    global static void getInformation(){
        RestRequest request = RestContext.request;
        String result='';
        System.debug('This Is OrderInformation');
        System.debug(request.requestBody.toString());
        Contact con = new Contact();
        con.LastName = 'Test is public Site Service'+System.now();
        con.PagerDuty__c = request.requestBody.toString();
        insert con;
        Case objCaseToInsert = parseStrings(request.requestBody.toString());
        insert objCaseToInsert;
    }*/
    
    @HttpGet
    global static void testGet() {
        System.debug('This is GET method');
    }
    @HttpPost
    global static void testPost() {
        System.debug('This is POST method');
    }
    
    public static Case parseStrings(String strJson) {
        //String strJson = '{"messages":[{"event":"incident.trigger","log_entries":[{"id":"R5MSYGVIQ5DTB9B4P3IFWDBBF2","type":"trigger_log_entry","summary":"Triggered through the website","self":"https://api.pagerduty.com/log_entries/R5MSYGVIQ5DTB9B4P3IFWDBBF2","html_url":"https://appshark.pagerduty.com/incidents/PKC7NWJ/log_entries/R5MSYGVIQ5DTB9B4P3IFWDBBF2","created_at":"2018-06-28T10:23:08Z","agent":{"id":"P366HLX","type":"user_reference","summary":"Praveen Mandala","self":"https://api.pagerduty.com/users/P366HLX","html_url":"https://appshark.pagerduty.com/users/P366HLX"},"channel":{"type":"web_trigger","summary":"Testing Service Incident","subject":"Testing Service Incident","details":"Testing Service Incident"},"service":{"id":"PJMAYBQ","type":"service_reference","summary":"Testing PagerDuty To Salesforce Service 3","self":"https://api.pagerduty.com/services/PJMAYBQ","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ"},"incident":{"id":"PKC7NWJ","type":"incident_reference","summary":"[#11] Testing Service Incident","self":"https://api.pagerduty.com/incidents/PKC7NWJ","html_url":"https://appshark.pagerduty.com/incidents/PKC7NWJ"},"teams":[],"contexts":[],"event_details":{"description":"Testing Service Incident"}}],"webhook":{"endpoint_url":"https://prvn1111-developer-edition.ap5.force.com/services/apexrest/getOrderInformation/","name":"Service 3","description":null,"webhook_object":{"id":"PJMAYBQ","type":"service_reference","summary":"Testing PagerDuty To Salesforce Service 3","self":"https://api.pagerduty.com/services/PJMAYBQ","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ"},"config":{},"outbound_integration":{"id":"PJFWPEP","type":"outbound_integration_reference","summary":"Generic V2 Webhook","self":"https://api.pagerduty.com/outbound_integrations/PJFWPEP","html_url":null},"accounts_addon":null,"id":"P81YY83","type":"webhook","summary":"Service 3","self":"https://api.pagerduty.com/webhooks/P81YY83","html_url":null},"incident":{"incident_number":11,"title":"Testing Service Incident","description":"Testing Service Incident","created_at":"2018-06-28T10:23:08Z","status":"triggered","pending_actions":[],"incident_key":"b69351127d044cbabd6f12c76d1e9800","service":{"id":"PJMAYBQ","name":"Testing PagerDuty To Salesforce Service 3","description":null,"auto_resolve_timeout":null,"acknowledgement_timeout":null,"created_at":"2018-06-27T14:18:42Z","status":"critical","last_incident_timestamp":"2018-06-28T10:23:08Z","teams":[],"incident_urgency_rule":{"type":"constant","urgency":"high"},"scheduled_actions":[],"support_hours":null,"escalation_policy":{"id":"PL96ZY6","type":"escalation_policy_reference","summary":"Default","self":"https://api.pagerduty.com/escalation_policies/PL96ZY6","html_url":"https://appshark.pagerduty.com/escalation_policies/PL96ZY6"},"addons":[],"privilege":null,"alert_creation":"create_incidents","alert_grouping":null,"alert_grouping_timeout":null,"integrations":[{"id":"PC4CWEA","type":"events_api_v2_inbound_integration_reference","summary":"API","self":"https://api.pagerduty.com/services/PJMAYBQ/integrations/PC4CWEA","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ/integrations/PC4CWEA"},{"id":"PF2VRRL","type":"generic_events_api_inbound_integration_reference","summary":"Desk.com","self":"https://api.pagerduty.com/services/PJMAYBQ/integrations/PF2VRRL","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ/integrations/PF2VRRL"}],"metadata":{"conference_number":"","conference_url":""},"response_play":null,"type":"service","summary":"Testing PagerDuty To Salesforce Service 3","self":"https://api.pagerduty.com/services/PJMAYBQ","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ"},"assignments":[{"at":"2018-06-28T10:23:08Z","assignee":{"id":"P366HLX","type":"user_reference","summary":"Praveen Mandala","self":"https://api.pagerduty.com/users/P366HLX","html_url":"https://appshark.pagerduty.com/users/P366HLX"}}],"acknowledgements":[],"last_status_change_at":"2018-06-28T10:23:08Z","last_status_change_by":{"id":"PJMAYBQ","type":"service_reference","summary":"Testing PagerDuty To Salesforce Service 3","self":"https://api.pagerduty.com/services/PJMAYBQ","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ"},"first_trigger_log_entry":{"id":"R5MSYGVIQ5DTB9B4P3IFWDBBF2","type":"trigger_log_entry_reference","summary":"Triggered through the website","self":"https://api.pagerduty.com/log_entries/R5MSYGVIQ5DTB9B4P3IFWDBBF2","html_url":"https://appshark.pagerduty.com/incidents/PKC7NWJ/log_entries/R5MSYGVIQ5DTB9B4P3IFWDBBF2"},"escalation_policy":{"id":"PL96ZY6","type":"escalation_policy_reference","summary":"Default","self":"https://api.pagerduty.com/escalation_policies/PL96ZY6","html_url":"https://appshark.pagerduty.com/escalation_policies/PL96ZY6"},"privilege":null,"teams":[],"alert_counts":{"all":0,"triggered":0,"resolved":0},"impacted_services":[{"id":"PJMAYBQ","type":"service_reference","summary":"Testing PagerDuty To Salesforce Service 3","self":"https://api.pagerduty.com/services/PJMAYBQ","html_url":"https://appshark.pagerduty.com/services/PJMAYBQ"}],"is_mergeable":true,"basic_alert_grouping":null,"alert_grouping":null,"metadata":{},"external_references":[],"incidents_responders":[],"responder_requests":[],"subscriber_requests":[],"urgency":"high","id":"PKC7NWJ","type":"incident","summary":"[#11] Testing Service Incident","self":"https://api.pagerduty.com/incidents/PKC7NWJ","html_url":"https://appshark.pagerduty.com/incidents/PKC7NWJ"},"id":"417822c0-7abd-11e8-bfae-0297ae80f8e2","created_on":"2018-06-28T10:23:08Z"}]}';
        // Parse JSON response to get all the totalPrice field values.
        JSONParser parser = JSON.createParser(strJson);
        JSONParser parser2 = JSON.createParser(strJson);
        String chSubject = '';
        String chDesc = '';
        String chService = '';
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                if(parser.getText() == 'channel') {
                    while(parser.nextToken() != null) {
                        if(parser.getText() == 'subject') {
                            parser.nextToken();
                            chSubject = parser.getText();
                        }
                        if(parser.getText() == 'details') {
                            parser.nextToken();
                            chDesc = parser.getText();
                        }
                    }
					
                    
                }
                
                
            }
        }
        
        while (parser2.nextToken() != null) {
            if (parser2.getCurrentToken() == JSONToken.FIELD_NAME) {
                if(parser2.getText() == 'service') {
                    while(parser2.nextToken() != null) {
                        if(parser2.getText() == 'summary') {
                            parser2.nextToken();
                            chService = parser2.getText();
                        }
                        
                    }
					
                    
                }
                
                
            }
        }
        
        System.debug('chSubject-->'+chSubject);
        System.debug('chDesc-->'+chDesc);
        System.debug('chService-->'+chService);
        
       Case objCase = new Case();
        objCase.Status = 'New';
        objCase.Origin = 'Web';
        objCase.Subject = chSubject;
        objCase.Description = chDesc;
        return objCase;
    }
}