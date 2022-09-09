public class QueryService {
    
    private String query;

    public QueryService initiateQuery() {
        this.query = 'SELECT';
        return this;
    }

    public QueryService withFields(List<String> fields) {
        this.query += ' ' + String.join(fields, ',');
        return this;
    }

    public QueryService withObject(String objectName) {
        this.query += ' FROM ' + objectName;
        return this;
    }

    public QueryService withWhere() {
        this.query += ' WHERE';
        return this;
    }

    public QueryService withFieldCondition(String field) {
        this.query += ' ' + field;
        return this;
    }

    public QueryService withListFilters(List<String> filters) {
        this.query += ' IN ' + '(\'' + String.join(filters, '\',\'') + '\')';
        return this;
    }

    public String getQuery() {
        return this.query;
    }

    public String getUrlyFormattedQuery() {
        return this.query.replace(' ', '+');
    }
}