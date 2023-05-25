public class Student {
    string name;
    integer age;
    string schoolName;
    
    public void setAge(integer a)
    {
        if(a<0 || a>100){
            age = 99;
        }else{
            age = a;
        }
    }
    public void setSchool(String s){
        schoolName=s;
    }
    
    public void validateName(string n){
        Pattern pat = Pattern.compile('\\d');
        Matcher mat = pat.matcher(n);
        Boolean matches = mat.find();
        system.debug('Matches? '+matches);
        if(matches || n==''){
            name = 'Default Name';
        }else{
            name = n;
        }
    }
    public void displayDetails(){
        system.debug('Name of the student: '+name);
        system.Debug('Name of the school: '+schoolName);
        system.Debug('Age of the Student: '+age);
    }
    
    // creating constructor
    //public Student(String n,integer a, String s){
//    }

}