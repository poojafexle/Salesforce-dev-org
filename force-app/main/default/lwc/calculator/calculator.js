/*
    Purpose         :   Calculator Component
    Created By      :   Pooja Hemrajani
    Created Date    :   22/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 22/04/2022
*/
import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Calculator extends LightningElement {

    _title = 'Error message';
    message = 'Sample Message';
    variant = 'error';

    num1 = '';
    num2 = '';
    @track result;

    handleChangeNum(evt) {
        this.result = '';
        this.template.querySelectorAll("lightning-input")[2].value = '';
        if(Object.is(evt.target.name,"num1")) {
            this.num1 = evt.target.value;    
        } else if (Object.is(evt.target.name,"num2")) {
            this.num2 = evt.target.value;
        }
    }
    calcFunc(evt) {
        if(Object.is(this.num1,null) || Object.is(this.num1,'') || Object.is(this.num2,null) || Object.is(this.num2,'')) {
            this.message = 'Enter both values';
            this.result = '';
            this.template.querySelectorAll("lightning-input")[2].value = '';
            this.showNotification();
        } else if (Number(this.num1) < 0 || Number(this.num2) < 0) {
            this.message = 'Enter positive values';
            this.result = '';
            this.template.querySelectorAll("lightning-input")[2].value = '';
            this.showNotification();
        } else{
            if(Object.is(evt.target.value,"+")) {
                this.result = Number(this.num1) + Number(this.num2);
            } else if(Object.is(evt.target.value,"-")) {
                this.result = Number(this.num1) - Number(this.num2);
            } else if(Object.is(evt.target.value,"*")) {
                this.result = Number(this.num1) * Number(this.num2);
            } else if(Object.is(evt.target.value,"/")) {
                this.result = Number(this.num1) / Number(this.num2);
            }
            this.num1 = '';
            this.num2 = '';
            this.template.querySelectorAll("lightning-input")[0].value = '';
            this.template.querySelectorAll("lightning-input")[1].value = '';
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