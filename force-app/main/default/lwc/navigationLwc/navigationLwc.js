/* 
    Purpose         :   Navigation Js
    Created By      :   Pooja Hemrajani
    Created Date    :   04/27/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 04/27/2022
*/
import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigationLwc extends NavigationMixin(LightningElement) {
    navigateToHome() {

        this[NavigationMixin.Navigate]({
            
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            }
        });
    }
}