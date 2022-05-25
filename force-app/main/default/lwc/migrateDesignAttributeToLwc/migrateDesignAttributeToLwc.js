/* 
    Purpose         :   Migrate Design Attributes Js
    Created By      :   Pooja Herajani
    Created Date    :   02/05/2022
    Current Version :   V_1.0
    Revision Log    :   V_1.0 Created - Pooja Herajani - 02/05/2022
*/
import { LightningElement, api } from "lwc";

export default class MigrateDesignAttributeToLWC extends LightningElement {
  @api currentStep = "step-4";
  @api type = "base";
  @api variant = "base";
  steps = [
    { label: "Contacted", value: "step-1" },
    { label: "Open", value: "step-2" },
    { label: "Unqualified", value: "step-3" },
    { label: "Nurturing", value: "step-4" },
    { label: "Closed-Won", value: "step-5" },
    { label: "Closed-Loss", value: "step-6" }
  ];
}