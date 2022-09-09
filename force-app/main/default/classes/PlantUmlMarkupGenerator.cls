public class PlantUmlMarkupGenerator {

    public void generateMarkup(List<String> generateForClasses) {
        QueryService queryService = new QueryService()
            .initiateQuery()
            .withFields(new List<String>{'Name,SymbolTable'})
            .withObject('ApexClass');
        
        
        if(!generateForClasses.isEmpty()) {
            
        } else {
            
        }
    }
}