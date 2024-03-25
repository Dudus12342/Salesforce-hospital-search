public with sharing class DoctorController {
    public Doctor__c doctor {get; set;}
    public List<Doctor__c> doctorList {get; set;}
    public Hospital__c hospital {get; set;}
    public List<Hospital__c> hospitalList {get; set;}
    public Date startDate {get; set;}
    public Date endDate {get; set;}
    public Id selectedDoctorId {get; set;}
    public Boolean showTableBlockFlag {get; set;}
    public Boolean showTableBlockFlagForHospitals {get; set;}
    public Boolean showDoctorDeletePrompt {get; set;}
    public Boolean displayPopUp {get; set;}
    public DoctorController() {
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>(); 
        hospital = new Hospital__c();
        hospitalList = new List<Hospital__c>();
        showTableBlockFlag = false; 
        showDoctorDeletePrompt = false;
        displayPopUp = false;
    }
// QUery fo Doctors
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
// Query for Hospitals
    public String createQueryForHospitals(){
        String queryStringForHospitals = 'SELECT Hospital_Name__c, City__c FROM Hospital__c WHERE Hospital_Name__c LIKE \'' + hospital.Hospital_Name__c + '%\'';
        return queryStringForHospitals;
    }
// Actions buttons
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

    public void deleteDoctor(){
        Database.delete(selectedDoctorId);
        search();
        showDoctorDeletePrompt = false;
    }

    public void cancelDeleteDoctor(){
        showDoctorDeletePrompt = false;
    }
// Prompt for delete doctor
    public void showDoctorDeletePromptMethod(){
        showDoctorDeletePrompt = true;
    }

// Pop up
    public void showPopUpMethod(){
        displayPopUp = true;
         
    }
    public void closePopUpMethod(){
        displayPopUp = false;
    }
// Pop up database for hospitals
    public void clearHospitalTable(){
        hospital = new Hospital__c();
        hospitalList = new List<Hospital__c>();
        if(hospitalList == null || hospitalList.isEmpty()){
            showTableBlockFlag = false;
        }else{
            showTableBlockFlag = true;
        }
    }
    public void searchHospitals(){
        hospitalList = Database.query(createQueryForHospitals());
        if(hospitalList == null || hospitalList.isEmpty()){
            showTableBlockFlag = false;
        }else{
            showTableBlockFlag = true;
        }
    }
}