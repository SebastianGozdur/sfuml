import { LightningElement } from 'lwc';
import getMarkup from '@salesforce/apex/PlantUmlViewerController.getMarkup';
import plantUmlLibary from '@salesforce/resourceUrl/jquery_plantuml';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';



export default class PlantUmlViewer extends LightningElement {

    markup;
    umltext;

    connectedCallback() {
        getMarkup().then(result => {
            this.markup = result;
        });
    }
}
