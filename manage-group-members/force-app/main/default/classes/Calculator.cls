public class Calculator {
    
    integer num1, num2, result;
    public integer addition(Integer a, integer b){
        result = a+b;
        return result;
    }
    public integer substraction(Integer a, integer b){
        if(a>b){
            result = a-b;
            return result; 
        }else{
            result = b-a;
            return result;
        }
        
    }
    public integer division(Integer a, integer b){
        if(a>b){
            result = a/b;
            return result; 
        }else{
            result = b/a;
            return result;
        }
    }
    public integer multiplication(Integer a, integer b){
        result = a*b;
        return result;    
    }
}