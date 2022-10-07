public with sharing class MetadataSync implements Queueable, Database.AllowsCallouts {

    private List<String> classes;

    public MetadataSync(List<String> classes) {
        this.classes = classes;
    }
    
    public void execute(QueueableContext context) {
        String markup;
        
        if (this.classes.isEmpty()) {
            markup = new PlantUmlMarkupGenerator().generateMarkup(new List<String>());
        } else {
            markup = new PlantUmlMarkupGenerator().generateMarkup(this.classes);
        }   

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