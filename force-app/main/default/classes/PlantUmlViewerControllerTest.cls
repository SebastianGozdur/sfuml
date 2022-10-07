@IsTest
private class PlantUmlViewerControllerTest {

    @IsTest
    private static void shouldGenerateAndRetrieveMarkup() {
        //given
        Test.setMock(HttpCalloutMock.class, new ToolingApiCallerMock());
        String classses = JSON.serialize(new List<String> {'PlantUmlViewerControllerTest'});

        //when
        Test.startTest();
        PlantUmlViewerController.generateMarkup(classses);
        String markup = PlantUmlViewerController.getMarkup();
        Test.stopTest();

        //then
        System.assert(String.isNotEmpty(markup));
    }
}