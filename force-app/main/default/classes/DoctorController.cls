public with sharing class DoctorController {
    public Doctor__c doctor {get; set;}
    public List<Doctor__c> doctorList {get; set;} 
    public Hospital__c hospital {get; set;}
    public List<Hospital__c> hospitalList {get; set;}
    public Id selectedDoctorId {get; set;}
    public Id selectedHospitalId { get; set; }
    public Boolean showTableBlockFlag {get; set;}
    public Boolean showTableBlockFlagForHospitals {get; set;}
    public Boolean showDoctorDeletePrompt {get; set;}
    public Boolean displayPopUp {get; set;}
    public Boolean showHospitalDatesFlag {get; set;}
    public Contract__c contract {get; set;}
    public List<Contract__c> contractList {get; set; }
    public Boolean isStartDateFilled {get; set;}

    public DoctorController() {
        doctor = new Doctor__c();
        doctorList = new List<Doctor__c>(); 
        hospital = new Hospital__c();
        hospitalList = new List<Hospital__c>();
        contract = new Contract__c();
        contractList = new List<Contract__c>();
        showTableBlockFlag = false; 
        showDoctorDeletePrompt = false;
        displayPopUp = false;
        showHospitalDatesFlag = false;
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
        showTableBlockFlag = false;
         
    }
    public void closePopUpMethod(){
        displayPopUp = false;
    }
// Pop up database for hospitals
    public void clearTablePopUp(){
        hospital = new Hospital__c();
        hospitalList = new List<Hospital__c>();
        contractList = new List<Contract__c>();
        showTableBlockFlag = false;
        showHospitalDatesFlag = false; 
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
    public void selectHospitalsDates() {
        showHospitalDatesFlag = true;
    }
    public void checkStartDateFilled() {
        isStartDateFilled = contract.Start_Date__c != null;
    }

    public void hireDoctor() {
        System.debug(String.isNotBlank(String.valueOf(selectedHospitalId)));
        System.debug(contract != null);
        
        if (String.isNotBlank(String.valueOf(selectedHospitalId)) && contract != null) {
            Contract__c newContract = new Contract__c();
            newContract.Hospital_Id__c= selectedHospitalId;
            newContract.Doctor_Id__c = selectedDoctorId;
            newContract.Start_Date__c = contract.Start_Date__c; 
            newContract.End_Date__c = contract.End_Date__c;
            System.debug(contract);
            Database.SaveResult contractResult = Database.insert(newContract);
            System.debug(contractResult);
        }
 }
}
