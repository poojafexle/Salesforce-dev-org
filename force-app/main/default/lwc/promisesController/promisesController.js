/*
    Purpose         :   invoke apex methods using asyncronous javascript
    Created By      :   Pooja Hemrajani
    Created Date    :   25/04/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Hemrajani - 22/04/2022
*/
import { LightningElement, track } from 'lwc';
 
import getMethod1 from '@salesforce/apex/promisesController.getMethod1';
import getMethod2 from '@salesforce/apex/promisesController.getMethod2';
import getMethod3 from '@salesforce/apex/promisesController.getMethod3';
 
export default class PromisesController extends LightningElement {
 
    @track result = '';

    connectedCallback() {
        this.invokeApexMethods();
    }
 
    async invokeApexMethods() {
        try {
            const result1 = await getMethod1();
            this.result = 'Method1 result: ' + result1;
            
            const result2 = await getMethod2({
                message1: result1
            });
            this.result += '\nMethod2 result: ' + result1 + ' ' + result2;
            
            const result3 = await getMethod3({
                message2: result2
            });
            this.result += '\nMethod2 result: ' + result1 + ' ' + result2 + ' ' + result3;
            
            
        } catch(error) {
            console.log(error);
        } finally {
            console.log('Finally Block');
        }
    }

    /*Promise1 = 'Method1 result: ' + result1;
    Promise2 = '\nMethod2 result: ' + result1 + ' ' + result2;
    Promise3 = '\nMethod2 result: ' + result1 + ' ' + result2 + ' ' + result3;
    Promise.all([Promise1, Promise2, Promise3]).then(values) => (newResult = values));*/

}