public with sharing class SortService {
    
    public List<String> customSort(List<String> source) {
        List<SortContainer> containers = new List<SortContainer>();

        for (String text : source) {
            containers.add(new SortContainer(text));
        }

        containers.sort();

        List<String> rewritenSources = new List<String>();
        for (SortContainer container : containers) {
            rewritenSources.add(container.value);
        }

        return rewritenSources;
    }
}
