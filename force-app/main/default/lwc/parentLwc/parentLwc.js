/*
    Purpose         :   Parent Component which will get value from child
    Created By      :   Pooja Hemrajani
    Created Date    :   26/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 26/04/2022
*/
import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ParentLwc extends LightningElement {
    @track number = 0;
    @track percentage = 0;
    _title = 'Error message';
    message = 'Sample Message';
    variant = 'error';

    hanldeProgressValueChange(event) {
        console.log('working-----' + this.number);
        this.number = event.detail;
    }
    handlePercentageChange(event) {
        console.log(event.target.value);
        if(event.target.value < 0 || event.target.value > 100) {
            this.message = 'Enter values in range from 1 to 100';
            this.showNotification();
        } else if(Object.is(event.target.value,'') || Object.is(event.target.value,null)) {
            //this.message = 'Values cannot be blank';
            this.percentage = 0; 
            event.target.value = 0;   
            //this.showNotification();
        } else{
            this.percentage = event.target.value;
        }
    }

    showNotification() {
        const evt = new ShowToastEvent({
            title: this._title,
            message: this.message,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
    }
}