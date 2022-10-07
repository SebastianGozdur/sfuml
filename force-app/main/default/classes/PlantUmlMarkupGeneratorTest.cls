@IsTest
private  class PlantUmlMarkupGeneratorTest {
  
    @IsTest
    private static void shouldGenerateUmlMarkup() {
        //given
        Test.setMock(HttpCalloutMock.class, new ToolingApiCallerMock());

        //when
        Test.startTest();
        String markup = new PlantUmlMarkupGenerator().generateMarkup(new List<String>());
        Test.stopTest();

        //then
        System.assert(String.isNotEmpty(markup));
    }
}
