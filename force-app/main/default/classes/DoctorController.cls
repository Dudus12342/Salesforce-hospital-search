public with sharing class DoctorController {
    public Doctor__c doctor {get; set;}
    public List<Doctor__c> doctorList {get; set;}
    public Id selectedDoctorId {get; set;}
    public Boolean showTableBlockFlag {get; set;}
    public Boolean showDoctorDeletePrompt {get; set;}
    public DoctorController() {
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>(); 
        showTableBlockFlag = false; 
        showDoctorDeletePrompt = false;
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
        if(doctorList == null || doctorList.isEmpty()){
            showTableBlockFlag = false;
        }else{
            showTableBlockFlag = true;
        }
    }

    public void clear(){
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>();
        if(doctorList == null || doctorList.isEmpty()){
            showTableBlockFlag = false;
        }else{
            showTableBlockFlag = true;
        }
    }
    public void showDoctorDeletePromptMethod(){
        showDoctorDeletePrompt = true;
    }
    public void deleteDoctor(){
        Database.delete(selectedDoctorId);
        search();
        showDoctorDeletePrompt = false;
    }
    public void cancelDeleteDoctor(){
        showDoctorDeletePrompt = false;
    }
  
}