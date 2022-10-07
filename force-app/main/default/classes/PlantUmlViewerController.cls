public with sharing class PlantUmlViewerController {
    
    @AuraEnabled
    public static String getMarkup() {
        try {
            List<ContentVersion> contentVersion = [SELECT VersionData FROM ContentVersion WHERE Title = 'SFUML_MARKUP'];
            String contentVersionBody = contentVersion.get(0).VersionData.toString();
            return contentVersionBody;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void generateMarkup(String classesSerialized) {
        try {
            List<String> classes = (List<String>) JSON.deserialize(classesSerialized, List<String>.class);
            System.enqueueJob(new MetadataSync(classes));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}