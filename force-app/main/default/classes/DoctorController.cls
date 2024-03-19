public with sharing class DoctorController {
    public Doctor__c doctor {get; set;}
    public List<Doctor__c> doctorList {get; set;}
    public DoctorController() {
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>();  
    }
    public String createQueryForDoctors(){
        String queryString = 'SELECT Full_Name__c, Country__c, City__c FROM Doctor__c';
        return queryString;
    }

    public void search(){
        doctorList = Database.query(createQueryForDoctors());
    }

    public void clear(){
        doctor = new Doctor__c();
    }
}