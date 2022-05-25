/*
    Purpose         :   Child Component for progress bar which will get value from parent
    Created By      :   Pooja Hemrajani
    Created Date    :   26/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 26/04/2022
*/
import { LightningElement, api } from 'lwc';
export default class ProgressBar extends LightningElement {
    @api percentage;
}