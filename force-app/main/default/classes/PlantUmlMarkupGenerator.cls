public class PlantUmlMarkupGenerator {

    public String generateMarkup(List<String> generateForClasses) {
        QueryService queryService = new QueryService()
            .initiateQuery()
            .withFields(new List<String>{'Name,SymbolTable'})
            .withObject('ApexClass');
        String query;
        
        if(!generateForClasses.isEmpty()) {
            query = queryService
                .withWhere()
                .withFieldCondition('Name')
                .withListFilters(generateForClasses)
                .getUrlyFormattedQuery();
        } else {
            query = queryService.getUrlyFormattedQuery();
        }

        String bodyJson = new ToolingApiCaller().query(query);
        System.debug('JSON');
        System.debug(bodyJson);

        ToolingApiResponse toolingApiResponse = (ToolingApiResponse) JSON.deserialize(bodyJson, ToolingApiResponse.class);

        System.debug('SEBG');
        System.debug(toolingApiResponse);

        return this.processToolingApiResponse(toolingApiResponse);
    }

    private String processToolingApiResponse(ToolingApiResponse toolingApiResponse) {
        Set<String> interfaces = this.extractInterfaces(toolingApiResponse);
        Map<String, List<InnerClass>> innerClasses = this.extractInnerClasses(toolingApiResponse);
        String body = this.generatePlantUmlBody(toolingApiResponse, interfaces, innerClasses);

        System.debug('BODY');
        System.debug(body);
        return body;
    }

    private Set<String> extractInterfaces(ToolingApiResponse toolingApiResponse) {
        List<String> interfacesFromResponse = new List<String>();

        for(Record element : toolingApiResponse.records) {
            if (element?.SymbolTable?.interfaces != null && element?.SymbolTable?.interfaces?.size() > 0) {
                interfacesFromResponse.addAll(element.SymbolTable.interfaces);
            }
        }

        return new Set<string>(interfacesFromResponse);
    }

    private Map<String, List<InnerClass>> extractInnerClasses(ToolingApiResponse toolingApiResponse) {
        Map<String, List<InnerClass>> innerClassesByParentName = new Map<String, List<InnerClass>>();


        for (Record element : toolingApiResponse.records) {
            if (element?.SymbolTable?.innerClasses != null && element?.SymbolTable?.innerClasses?.size() > 0) {
                if (!innerClassesByParentName.containsKey(element.Name)) {
                    innerClassesByParentName.put(element.Name, element?.SymbolTable?.innerClasses);
                }
            }
        }

        return innerClassesByParentName;
    }

    public String generatePlantUmlBody(ToolingApiResponse toolingApiResponse, Set<String> interfaces, Map<String, List<InnerClass>> innerClasses) {
        String body = this.generateForRegularClasses(toolingApiResponse, interfaces);
        body += this.generateForInnerClasses(innerClasses);
        return body;
    }

    private String generateForRegularClasses(ToolingApiResponse toolingApiResponse, Set<String> interfaces) {
        String body = this.startUml();

        for (Record element : toolingApiResponse.records) {
            if (element.SymbolTable != null) {
                body += this.addClassOrInterface(interfaces, element.SymbolTable.name) + element.SymbolTable.name;
                body += this.processExtension(element.SymbolTable.parentClass);
                body += this.processInterfaces(element.SymbolTable.interfaces);
                body += this.openBracket();
                body += this.processProperties(element.SymbolTable.properties);
                body += this.processMethods(element.SymbolTable.methods);
                body += this.closeBracket();
            }
        }

        return body;
    }

    private String generateForInnerClasses(Map<string, List<InnerClass>> innerClasses) {
        String body = '';

        if (innerClasses.size() > 0) {
            for (String key : innerClasses.keySet()) {
                List<InnerClass> value = innerClasses.get(key);

                for (InnerClass singleInnerClass : value) {
                    body += this.addClassOrInterface(new Set<String>(), singleInnerClass.name) + singleInnerClass.name;
                    body += this.openBracket();
                    body += this.processProperties(singleInnerClass.properties);
                    body += this.processMethods(singleInnerClass.methods);
                    body += this.closeBracket();
                    body += this.addParentChildRelation(key, singleInnerClass.name);
                }
            }
        }
        body += this.finishUml();

        return body;
    }

    private String addClassOrInterface(Set<String> interfaces, String entityName) {
        if (interfaces.contains(entityName)) {
            return 'interface ';
        }

        return 'class ';
    }

    private String openBracket() {
        return '{' + this.newLine();
    }

    private String processProperties(List<Property> properties) {
        String body = '';

        if (properties.size() > 0) {
            for (Property property : properties) {
               // body += property.modifiers.sort(this.sortModifiers).join(' ') + ' ';
                body += String.join(new SortService().customSort(property.modifiers), ' ') + ' ';
                body += property.type + ' ' + property.name;
                body += '\n';
            }
        }

        return body;
    }

    private String processMethods(List<Method> methods) {
        String body = '';

        for (Method method : methods) {
          //  body += method.modifiers.sort(this.sortModifiers).join(' ') + ' ';
            body += String.join(new SortService().customSort(method.modifiers), ' ') + ' ';
            body += method.returnType + ' ';
            body += method.name + '(';
            if (method.parameters.size() > 0) {
                body += this.processParameters(method.parameters);
            }
            body += ')\n';
        }

        return body;
    }

    private string closeBracket() {
        return '}' + this.newLine();
    }

    private String addParentChildRelation(String parentName, String childName) {
        return parentName + '+--' + childName + this.newLine();
    }

    // private Integer sortModifiers(String a, String b) {
    //     if ((a == 'public' || a == 'private') && (b == 'static' || b == 'final')) {
    //         return -1;
    //     } else if ((b == 'public' || b == 'private') && (a == 'static' || a == 'final')) {
    //         return 1;
    //     } else if ((a == 'final') && (b == 'static')) {
    //         return 1;
    //     } else if ((a == 'static') && (b == 'final')) {
    //         return -1;
    //     }
    //     return 0;
    // }

    private String processExtension(String parentClass) {
        if (String.isNotEmpty(parentClass)) {
            return ' extends ' + parentClass;
        }

        return '';
    }

    private String processInterfaces(List<String> interfacesNames) {
        if (interfacesNames.size() > 0) {
            return ' implements ' + String.join(interfacesNames, ',');
        }

        return '';
    }

    private String processParameters(List<Parameter> parameters) {
        List<String> parametersLines = new List<String>();

        for (Parameter parameter : parameters) {
            parametersLines.add(parameter.type + ' ' + parameter.name);
        }

        return String.join(parametersLines, ',');
    }

    private String startUml() {
        return '@startuml' + this.newLine();
    }

    private String finishUml() {
        return '@enduml';
    }

    private String newLine() {
        return '\n';
    }
}