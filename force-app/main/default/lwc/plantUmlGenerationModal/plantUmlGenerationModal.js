import { LightningElement, api } from 'lwc';

export default class PlantUmlGenerationModal extends LightningElement {
    
    @api 
    isModalOpen = false;
    classes;
    
    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.dispatchEvent(new CustomEvent('modalclose'));
        this.isModalOpen = false;
    }

    submitDetails() {
        this.isModalOpen = false;
        this.dispatchEvent(new CustomEvent('submitdetails', {
            detail : this.classes
        }));
    }

    handleInputChange(event) {
        this.classes = event.target.value;
    }
}