import {
    LightningElement,
    track,
    wire
} from 'lwc';

import getAllAccounts from '@salesforce/apex/AccountControllerNew.getAllAccounts';
export default class Cssexample extends LightningElement {
    @track accounts;
    @track errors;
    @wire(getAllAccounts)
    wireAllAccs({
        error,
        data
    }) {
        if (data) {
            this.accounts = data;
        } else {
            this.error = error;
        }
    }
}