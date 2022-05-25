/*
    Purpose         :   To get third party javascript and css library in js
    Created By      :   Pooja Hemrajani
    Created Date    :   04/27/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 04/27/2022
*/
import { LightningElement, track } from 'lwc';
import interest from '@salesforce/resourceUrl/interest';
import { loadScript } from 'lightning/platformResourceLoader';

export default class MyComponent extends LightningElement {

    @track result;

    connectedCallback() {
        loadScript(this, interest).then(() => {
            //method which is call from static resource
            const interest = myLib.calculatePrincipleInterest(145);
            this.result = interest;
        });
    }
}