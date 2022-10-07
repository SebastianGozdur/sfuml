@IsTest
private class ToolingApiCallerTest {

    @IsTest
    private static void shouldCallToolingApi() {
        //given
        Test.setMock(HttpCalloutMock.class, new ToolingApiCallerMock());
        List<String> generateForClasses = new List<String> {'ToolingApiCallerTest'};
        String query = new QueryService()
            .withWhere()
            .withFieldCondition('Name')
            .withListFilters(generateForClasses)
            .getUrlyFormattedQuery();

        //when
        Test.startTest();
        String toolingApiResponse = new ToolingApiCaller().query(query);
        Test.stopTest();

        //then
        System.assert(String.isNotEmpty(toolingApiResponse));
    }
}
