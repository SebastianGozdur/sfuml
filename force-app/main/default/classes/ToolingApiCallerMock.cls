@IsTest
public class ToolingApiCallerMock implements HttpCalloutMock {
    
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new httpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"size":1,"totalSize":1,"done":true,"queryLocator":null,"entityTypeName":"ApexClass","records":[{"attributes":{"type":"ApexClass","url":"/services/data/v54.0/tooling/sobjects/ApexClass/01p7Q00000NxPyQQAV"},"Name":"PlantUmlViewerController","SymbolTable":{"constructors":[],"externalReferences":[],"id":"PlantUmlViewerController","innerClasses":[],"interfaces":[],"key":"PlantUmlViewerController","methods":[{"annotations":[{"name":"AuraEnabled"}],"location":{"column":26,"line":4},"modifiers":["static","public"],"name":"getMarkup","parameters":[],"references":[],"returnType":"String","type":null},{"annotations":[{"name":"AuraEnabled"}],"location":{"column":24,"line":15},"modifiers":["static","public"],"name":"generateMarkup","parameters":[{"name":"classesSerialized","type":"String"}],"references":[],"returnType":"void","type":null}],"name":"PlantUmlViewerController","namespace":null,"parentClass":"","properties":[],"tableDeclaration":{"annotations":[],"location":{"column":27,"line":1},"modifiers":["public","with sharing"],"name":"PlantUmlViewerController","references":[],"type":"PlantUmlViewerController"},"variables":[{"annotations":[],"location":{"column":34,"line":6},"modifiers":[],"name":"contentVersion","references":[],"type":"List<ContentVersion>"},{"annotations":[],"location":{"column":20,"line":7},"modifiers":[],"name":"contentVersionBody","references":[],"type":"String"},{"annotations":[],"location":{"column":46,"line":15},"modifiers":[],"name":"classesSerialized","references":[],"type":"String"},{"annotations":[],"location":{"column":26,"line":17},"modifiers":[],"name":"classes","references":[],"type":"List<String>"}]}}]}');
        response.setStatusCode(200);
        return response;
    }
}
