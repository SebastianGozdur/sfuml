public with sharing class MetadataSync implements Queueable, Database.AllowsCallouts {
    
    public void execute(QueueableContext context) {
        System.debug('QUEUEABLE');
        String markup = new PlantUmlMarkupGenerator().generateMarkup(new List<String>());

        //RecordType rt = [SELECT Id from RecordType WHERE DeveloperName = 'UML_Markup'];
        List<ContentDocument> existingContentDocuments = [SELECT Id FROM ContentDocument WHERE LatestPublishedVersion.Title = 'SFUML_MARKUP']; 
        if (!existingContentDocuments.isEmpty()) {
            delete existingContentDocuments;
        }
    
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S';
        cv.VersionData = Blob.valueOf(markup);
        cv.Title = 'SFUML_MARKUP';
        cv.PathOnClient = 'SFUML_MARKUP.txt';
        
        insert cv;
    }
}