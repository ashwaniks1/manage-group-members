import { LightningElement } from 'lwc';

export default class Fct_newfctItem_lwc extends LightningElement 
{
    flowApiName = "Create_Lead_Flow"; // api name of your flow
    
        // Setting flow input variables
       /* accountId = "<--add account id here-->";
        flowInputVariables = [
            {
                name: "accountId",
                type: "String",
                value: this.accountId,
            },
        ]; */
    
            // do something when flow status changed
        handleFlowStatusChange(event) {
            console.log("flow status", event.detail.status);
            if (event.detail.status === "FINISHED") {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success",
                        message: "Flow Finished Successfully",
                        variant: "success",
                    })
                );
            }
        }
    }