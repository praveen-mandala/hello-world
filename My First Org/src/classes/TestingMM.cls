global class TestingMM {

    webservice String parameter { get; set; }

    public TestingMM() {
    System.debug('Testing');
        this.parameter = 'value';
    }

    webservice static String serviceName(){
        return '';
    }
}