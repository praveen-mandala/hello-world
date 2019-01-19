@isTest
global class GOPMockClass {
	global HttpResponse respondToGOP(HTTPRequest request)
    {
     	System.assertEquals('POST', request.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/xml');
        res.setHeader('UserAgent', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36');        
        res.setbody('<?xml version="1.0"?><!DOCTYPE cXML SYSTEM "http://xml.cxml.org/schemas/cXML/1.1.007/cXML.dtd"><cXML version="1.1.007" payloadID="1513587932570.558123.2744@sediamazon.com"timestamp="2017-12-18T01:05:32-08:00"><Response><Status code="200" text="OK"/></Response></cXML>');
        return res; 
    }
}