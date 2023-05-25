import { LightningElement } from 'lwc';

export default class Cmg_findgreaternumber_LWCcomp extends LightningElement 
{
    Num1;
    Num2;
    Num3;

    firstNum(event)
    {
        this.Num1 = event.target.value;
    }
    secondNum(event)
    {
        this.Num2 = event.target.value;
    }
    thirdNum(event)
    {
        this.Num3 = event.target.value;
    }
    findGreaterNumber(event)
    {
        const a = parseInt(Num1)
        const b = parseInt(Num2)
        const c = parseInt(Num3)
        if(a>b && a>c)
        {
            alert('Greater number is' +a);
        }
        else if(b>a && b>c)
        {
            alert('Greater number is' +b);
        } else
        {
            alert('Greater number is' +c);
        }
    }
    clear(event)
    {
        this.Num1 = null;
        this.Num2 = null;
        this.Num3 = null;

    }
}