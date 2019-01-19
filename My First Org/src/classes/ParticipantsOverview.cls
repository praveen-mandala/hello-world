public class ParticipantsOverview{
    public list <Event_Attendees__c> host{get;set;}
    public list <Event_Attendees__c> coOrdinators{get;set;}
    public list <Event_Attendees__c> participants{get;set;}
	    public list <ParticipantWpr> host1{get;set;}
    public list <ParticipantWpr> coOrdinators1{get;set;}
    public list <ParticipantWpr> participants1{get;set;}
    public List<ParticipantWpr> lstWpr{get;set;}
    public ParticipantsOverview(){
        //This method is to retrive details from Event Attendees where 'Participation Type' field is 'Host'
        host= new list <Event_Attendees__c>();
        Map<String,Event_Attendees__c> maphost=new Map<String,Event_Attendees__c>(); 
        host=[select count__c,Employee__r.name,Employee__r.id, name, Employee__r.Employee_ID__c  
              from Event_Attendees__c  where Participation_Type__c ='Host' ORDER BY count__c DESC];
        
        //this loop is to increment value for 'count' field if the employee id is
        for(Event_Attendees__c anttendObj:host){
            if(maphost.containsKey(anttendObj.Employee__r.id)){
                Event_Attendees__c obj = maphost.get(anttendObj.Employee__r.id);
                obj.count__c+=1;
                maphost.put(anttendObj.Employee__r.id, obj);
            }else{
                anttendObj.count__c=1;
                maphost.put(anttendObj.Employee__r.id,anttendObj);
            }
        }
        host= new List<Event_Attendees__c> (maphost.values()); //Top Host List
        //This method is to retrive details from Event Attendees where 'Participation Type' field is 'co-Ordinator'
        coOrdinators= new list<Event_Attendees__c>();
        Map<String,Event_Attendees__c> mapcoOrdinators=new Map<String,Event_Attendees__c>();
        coOrdinators=[select Employee__r.name , name, Employee__r.Employee_ID__c
                      from Event_Attendees__c where Participation_Type__c ='Coordinator' ORDER BY count__c DESC ];
        system.debug('coOrdinators==='+coOrdinators);
        //this loop is to increment value for 'count' field if necessary
        for(Event_Attendees__c anttendObj:coOrdinators){
            if(mapcoOrdinators.containsKey(anttendObj.Employee__r.id)){
                Event_Attendees__c obj = mapcoOrdinators.get(anttendObj.Employee__r.id);
                obj.count__c+=1;
                mapcoOrdinators.put(anttendObj.Employee__r.id, obj);
            }else{
                anttendObj.count__c=1;
                mapcoOrdinators.put(anttendObj.Employee__r.id,anttendObj);
            }
        }
        coOrdinators= new List<Event_Attendees__c>(mapcoOrdinators.values());
        //coOrdinators.sort();
        //This method is to retrive details from Event Attendees where 'Participation Type' field is 'participants'
        participants= new list<Event_Attendees__c>();
        Map<String,Event_Attendees__c> mapparticipants=new Map<String,Event_Attendees__c>();
        participants=[select Employee__r.name , name, Employee__r.Employee_ID__c,count__c 
                      from Event_Attendees__c where Participation_Type__c ='Participant' ORDER BY count__c DESC  ];
        //this for loop is to increment value for 'count' field if necessary
        for(Event_Attendees__c anttendObj:participants){
            if(mapparticipants.containsKey(anttendObj.Employee__r.id) ){
                Event_Attendees__c obj = mapparticipants.get(anttendObj.Employee__r.id);
                obj.count__c+=1;
                mapparticipants.put(anttendObj.Employee__r.id, obj);
            }else{
                anttendObj.count__c=1;
                mapparticipants.put(anttendObj.Employee__r.id,anttendObj);
            }
        }
        participants= new List<Event_Attendees__c>(mapparticipants.values());
        system.debug('participants=='+participants);    
        host1 = buildWrapper(host);
        coOrdinators1 = buildWrapper(coOrdinators);
        participants1 = buildWrapper(participants);
        System.debug('participants1 '+participants1);
        //buildWrapper(coOrdinators);
     }
    public List<ParticipantWpr> buildWrapper(List<Event_Attendees__c> lstEventAtts){
        lstWpr = new List<ParticipantWpr>();
        for(Event_Attendees__c objEventAtt : lstEventAtts){
            ParticipantWpr objWpr = new ParticipantWpr();
            objWpr.count = objEventAtt.count__c;
            objWpr.objEventAtt = objEventAtt;
            lstWpr.add(objWpr);
        }
        System.debug('lstWpr---->'+lstWpr);
        lstWpr.sort();
        System.debug('lstWpr---->'+lstWpr);
        return lstWpr;
            
    }
    public class ParticipantWpr implements Comparable{
        public Decimal count{get;set;}
        public Event_Attendees__c objEventAtt{get;set;}          
        public Integer compareTo(Object compareTo) {
        ParticipantWpr compareToWpr = (ParticipantWpr)compareTo;
        if (count == compareToWpr.count) return 0;
        if (count < compareToWpr.count) return 1;
        return -1;        
    }
    }
    
}