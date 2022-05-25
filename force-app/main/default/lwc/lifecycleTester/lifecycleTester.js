/*
    Purpose         :   Lifecycle Tester Component
    Created By      :   Pooja Hemrajani
    Created Date    :   23/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 23/04/2022
*/
import { LightningElement } from 'lwc';
import templateOne from './lifecycleTester.html';
import templateTwo from './lifecycleTester2.html';
export default class LifecycleTester extends LightningElement {

    templateNumber = 'temp1';

    constructor() {
        super();
        console.log('Inside Constructor');
    }

    connectedCallback() {
        console.log('Inside connectedCallback');
    }

    disconnectedCallback() {
        console.log('Inside disconnectedCallback');
    }

    changeTemplate() {
        console.log('Inside changeTemplate Method');
        if(this.templateNumber === 'temp1') {
            this.templateNumber = 'temp2';
        } else {
            this.templateNumber = 'temp1';
        }
    }

    render(){
        console.log('Inside render');
        if (this.templateNumber === 'temp1') {
            return templateOne;
        } else  {
            return templateTwo;
        }
    }

    renderedCallback(){
        console.log('inside rendered callback');
    }

    errorCallback(error, stack) {
        console.log('inside errorCallback' + error);
        alert('error' + error);
    }

}