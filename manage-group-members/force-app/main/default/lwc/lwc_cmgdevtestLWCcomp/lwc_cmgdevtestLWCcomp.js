import { LightningElement } from 'lwc';

export default class Lwc_cmgdevtestLWCcomp extends LightningElement 
{
    callme(event)
    {
        alert('This is LWC component created in VS Code');
    }
}