/*
    Purpose         :   Navigation Component
    Created By      :   Pooja Hemrajani
    Created Date    :   27/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 27/04/2022
*/
import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigationComponent extends NavigationMixin(
    LightningElement
) {
    navigateToChatter() {
        // Use the built-in 'Navigate' method
        this[NavigationMixin.Navigate]({
            // Pass in pageReference
            type: 'standard__namedPage',
            attributes: {
                pageName: 'chatter'
            }
        });
    }

    navigateToSales() {
        // Use the built-in 'Navigate' method
        this[NavigationMixin.Navigate]({
            // App in pageReference
            type: 'standard__app',
            attributes: {
                appTarget: 'standard__Sales',
            }
        });
    }
}