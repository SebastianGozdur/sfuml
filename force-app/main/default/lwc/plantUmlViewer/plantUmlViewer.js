import { LightningElement } from 'lwc';
import getMarkup from '@salesforce/apex/PlantUmlViewerController.getMarkup';
import generateMarkup from '@salesforce/apex/PlantUmlViewerController.generateMarkup';

export default class PlantUmlViewer extends LightningElement {

    markup;
    umltext;
    isMarkupGenerationModalVisible = false;
    showSpinner = false;

    connectedCallback() {
        getMarkup()
            .then(result => {
                this.markup = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleMarkupGeneration() {
        this.isMarkupGenerationModalVisible = true;
    }

    handleMarkupRetrieval() {
        this.showSpinner = true;
        getMarkup()
            .then(result => {
                this.markup = result;
                this.showSpinner = false;
            })
            .catch(error => {
                this.showSpinner = false;
                console.error(error);
            });
    }

    handleClose() {
        this.isMarkupGenerationModalVisible = false;
    }

    handleSubmitDetails(event) {
        this.showSpinner = true;
        setTimeout(() => {
            getMarkup()
                .then(result => {
                    this.markup = result;
                })
                .catch(error => {
                    console.error(error);
                });
            this.showSpinner = false;
        }, 5000);
        this.isMarkupGenerationModalVisible = false;

        console.log(JSON.stringify(event.detail.replace(/ /g,'').split(',')));

        generateMarkup({ classesSerialized : JSON.stringify(event.detail.replace(/ /g,'').split(',')) })
            .catch(error => console.error(error));
    }
}