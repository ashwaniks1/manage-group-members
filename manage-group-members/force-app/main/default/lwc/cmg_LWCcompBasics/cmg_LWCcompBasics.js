import { LightningElement } from 'lwc';

export default class Cmg_LWCcompBasics extends LightningElement 
{
    name='Enter Name'
    callme(event)
    {
        this.name='My City Health';
    }
    listenName(event)
    {
        this.name = event.target.value;
    }
}