public class AnimalLocator {

    public static String getAnimalNameById(Integer IdVal) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+IdVal);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        //request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('Body-->'+response.getBody());
        }
        AnimalResult result = (AnimalResult) JSON.deserialize(response.getBody(), AnimalResult.class);
        
        //Map<String,Object> testMap = (Map<String,Object>)JSON.deserialize(response.getBody(), Map<String,Object>.class);
        //Map<String,String> animalMap = (Map<String,String>)testMap.get('animal');
        //System.debug('Animal Name-->'+animalMap.get('name'));
        //System.debug('obj-->'+obj);
        return result.animal.name;
    }
    public class Animal {
        public Integer id;
        public String name;
        public String eats;
        public String says;
    }
    
    public class AnimalResult {
        public Animal animal;
    }
}