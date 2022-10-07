@IsTest
private class MetadataSyncTest {
    
    @IsTest
    private static void shouldGenerateMarkupAndCreateContentFile() {
        //given
        Test.setMock(HttpCalloutMock.class, new ToolingApiCallerMock());
        List<String> classes = new List<String> {'MetadataSyncTest'};

        //when
        Test.startTesT();
        System.enqueueJob(new MetadataSync(classes));
        Test.stopTest();

        //then
        List<ContentVersion> contentVersion = [SELECT VersionData FROM ContentVersion WHERE Title = 'SFUML_MARKUP'];
        String contentVersionBody = contentVersion.get(0).VersionData.toString();
        System.assert(String.isNotEmpty(contentVersionBody));
    }
}