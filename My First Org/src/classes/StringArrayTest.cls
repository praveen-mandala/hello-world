public class StringArrayTest {

    public static String[] generateStringArray(Integer n) {
        
        List<String> l =  new  List<String>();
       	
        for(Integer j=0;j<n;j++){
			l.add('Test '+j);
            system.debug(l.get(j));
        }
        return l;
        
    }
}