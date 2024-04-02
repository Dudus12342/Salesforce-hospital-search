public with sharing class ContractController {

    public static void duplicateContractChecker(List<Contract__c> oldContracts, List<Contract__c> newContracts){
        Set<String> doctorIds = new Set<String>();
        Set<String> hospitalIds = new Set<String>();
        Map<String, List<Contract__c>> existingContractByDoctorHospitalId = new Map<String,List<Contract__c>>(); //STRING SKLEJA 2 ID W JEDNO A LISTA PRZECHOWUJE OBIEKTY KTORE MA W SOBIE ID.
        assignIdToSets(newContracts, doctorIds, hospitalIds);
        
        List<Contract__c> contractRecords = [SELECT Doctor_Id__c, End_Date__c, Hospital_Id__c, Start_Date__c FROM Contract__c WHERE Doctor_Id__c IN :doctorIds AND Hospital_Id__c IN :hospitalIds];

        fillMapOfExistingContracts(existingContractByDoctorHospitalId, contractRecords);
    }

    public static void assignIdToSets(List<Contract__c> contractList, Set<String> doctorIds, Set<String> hospitalIds){

        for(Contract__c contract: contractList){
            doctorIds.add(contract.Doctor_Id__c);
            hospitalIds.add(contract.Hospital_Id__c);
        }
 }
    public static void fillMapOfExistingContracts(Map<String, List<Contract__c>> existingContractByDoctorHospitalId,  List<Contract__c> contractRecords){
        if(!existingContractByDoctorHospitalId.isEmpty()){
        for (Contract__c contract : contractRecords)
            if(existingContractByDoctorHospitalId.containsKey((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c)){
                existingContractByDoctorHospitalId.get((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c).add(contract);
            }else{
        existingContractByDoctorHospitalId.put((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c, new List<Contract__c>{contract});
      }
}
}
}