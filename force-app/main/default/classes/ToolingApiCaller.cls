public class ToolingApiCaller {
    
    public String query(String query) {
        //?q=Select+Name,SymbolTable+from+ApexClass
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v54.0/tooling/query/?q='+query);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
		
        Http h = new Http();
        HttpResponse res = h.send(req);

        return res.getBody();
    }
}