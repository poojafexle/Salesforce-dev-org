/* 
    Purpose         :   Contact Tiles Js
    Created By      :   Pooja Hemrajani
    Created Date    :   28/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 28/04/2022
*/
import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getContactList from '@salesforce/apex/dataController.getContactList1';

export default class ContactTiles extends NavigationMixin(LightningElement) {
    @api flexipageRegionWidth;
    @track size;
    @track type;
    @track contacts;

    @wire(getContactList, {}) contacts;
    
    connectedCallback(){
        console.log(this.recordId);
        if(this.flexipageRegionWidth == 'LARGE'){
            this.size = 'slds-size_1-of-3';
            this.type = 'Large';
        }

        if(this.flexipageRegionWidth == 'MEDIUM'){
            this.size = 'slds-size_1-of-2';
            this.type = 'Medium';
        }

        if(this.flexipageRegionWidth == 'SMALL'){
            this.type = 'Small';
            this.size = 'slds-size_2-of-2'
        }
    }

    handleChange(event){
        this[NavigationMixin.Navigate]({
            
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.name,
                objectApiName: 'Contact',
                actionName: 'view'
            }
        });
    }
}