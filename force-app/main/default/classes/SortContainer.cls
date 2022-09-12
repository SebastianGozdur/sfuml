public class SortContainer implements Comparable {
    public String value;

    public Sortcontainer(string value) {
        this.value = value;
    }

    public Integer compareTo(Object compareTo) {
        if ((value == 'public' || value == 'private') && (compareTo == 'static' || compareTo == 'final')) {
            return -1;
        } else if ((compareTo == 'public' || compareTo == 'private') && (value == 'static' || value == 'final')) {
            return 1;
        } else if ((value == 'final') && (compareTo == 'static')) {
            return 1;
        } else if ((value == 'static') && (compareTo == 'final')) {
            return -1;
        }
        return 0;      
    }
}
