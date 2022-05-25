/*
    Purpose         :   Passing value from current component to parent component
    Created By      :   Pooja Hemrajani
    Created Date    :   26/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 26/04/2022
*/
import { LightningElement, api } from 'lwc';
export default class ChildLwc extends LightningElement {
    @api number = 0;

    handleNumberChange(event) {
        this.number = event.target.value;
        console.log(this.number);
        const selectedEvent = new CustomEvent("progressvaluechange", {
            detail: this.number
        });

        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
    }

}