/*
    Purpose         :   invoke apex methods using asyncronous javascript
    Created By      :   Pooja Hemrajani
    Created Date    :   26/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 26/04/2022
*/
import { LightningElement, wire, track } from 'lwc';
import getContactList from '@salesforce/apex/dataController.getContactList';
import getCasesList from '@salesforce/apex/dataController.getCasesList';
import getOpportunityList from '@salesforce/apex/dataController.getOpportunityList';
export default class DataController extends LightningElement {

    @track contacts;
    @track opportunities;
    @track cases;

    connectedCallback() {
        this.invokeApexMethods();
    }
 
    async invokeApexMethods() {
        try {
            const result1 = await getContactList();
            
            this.contacts = result1;
            const result2 = await getOpportunityList({
                message1: result1
            });
            
            this.opportunities = result2;
            const result3 = await getCasesList({
                message2: result2
            });

            this.cases = result3;
            
        } catch(error) {
            console.log(error);
        } finally {
            console.log('Finally Block');
        }
    }
}