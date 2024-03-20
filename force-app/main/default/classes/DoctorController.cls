public with sharing class DoctorController {
    public Doctor__c doctor {get; set;}
    public List<Doctor__c> doctorList {get; set;}
    public Id doctorId {get; set;}
    public DoctorController() {
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>();  
    }
    public String createQueryForDoctors(){
        String queryString = 'SELECT Full_Name__c, Country__c, City__c FROM Doctor__c WHERE Last_Name__c LIKE \'' + doctor.Last_Name__c + '%\'';
        if(String.isNotBlank(doctor.First_Name__c)){
            queryString += ' AND First_Name__c LIKE \'' + doctor.First_Name__c + '%\'';
        }
        if(String.isNotBlank(doctor.City__c)){
            queryString += ' AND City__c LIKE \'' + doctor.City__c + '%\'';
        }
        if(String.isNotBlank(doctor.Country__c)){
            queryString += ' AND Country__c = \'' + doctor.Country__c + '\'';
        }
        return queryString;
    }

    public void search(){
        doctorList = Database.query(createQueryForDoctors());
    }

    public void clear(){
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>();
    }

    public void deleteRecord(){
        Database.delete(doctorId);
        search();
    }
}