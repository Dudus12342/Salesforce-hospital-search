public with sharing class ContractController {

    public static void duplicateContractChecker(List<Contract__c> oldContracts, List<Contract__c> newContracts){
        Set<String> doctorIds = new Set<String>();
        Set<String> hospitalIds = new Set<String>();
        Map<String, List<Contract__c>> existingContractByDoctorHospitalId = new Map<String,List<Contract__c>>(); //STRING SKLEJA 2 ID W JEDNO A LISTA PRZECHOWUJE OBIEKTY KTORE MA W SOBIE ID.
        assignIdToSets(newContracts, doctorIds, hospitalIds);

        List<Contract__c> contractRecords = [SELECT Doctor_Id__c, End_Date__c, Hospital_Id__c, Start_Date__c FROM Contract__c WHERE Doctor_Id__c IN :doctorIds AND Hospital_Id__c IN :hospitalIds];

        fillMapOfExistingContracts(existingContractByDoctorHospitalId, contractRecords);
        System.debug('whatever');
        for(Contract__c contract :newContracts){
            if(existingContractByDoctorHospitalId.containsKey((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c)){
                List<Contract__c> contractsForDoctorHospital = existingContractByDoctorHospitalId.get((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c);
                System.debug('przeszlo przez liste');
                for(Contract__c existingContract :contractsForDoctorHospital){
                    if(doDatesOverlap(contract.Start_Date__c, contract.End_Date__c, existingContract.Start_Date__c, existingContract.End_Date__c)){
                       contract.addError('Dates from' + existingContract.Start_Date__c + ' to' + existingContract.End_Date__c + 'are occupied by existing: ' + existingContract.Id + ' please, select free date');
                       System.debug('jest w metodzie dodatesoverlap');
                    }
                }
            }
        }
    }

    public static void assignIdToSets(List<Contract__c> contractList, Set<String> doctorIds, Set<String> hospitalIds){

        for(Contract__c contract: contractList){
            doctorIds.add(contract.Doctor_Id__c);
            hospitalIds.add(contract.Hospital_Id__c);
        }
    }  
    public static void fillMapOfExistingContracts(Map<String, List<Contract__c>> existingContractByDoctorHospitalId,  List<Contract__c> contractRecords){
        if(!existingContractByDoctorHospitalId.isEmpty()){
            for (Contract__c contract : contractRecords){
                if(existingContractByDoctorHospitalId.containsKey((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c)){
                existingContractByDoctorHospitalId.get((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c).add(contract);
                }else{
        existingContractByDoctorHospitalId.put((String) contract.Doctor_Id__c + (String)contract.Hospital_Id__c, new List<Contract__c>{contract});
                }
            }
        }
    }
    public static Boolean doDatesOverlap(Date startDate1, Date endDate1, Date startDate2, Date endDate2) {
        if ((startDate1 >= startDate2 && startDate1 <= endDate2) || 
            (endDate1 >= startDate2 && endDate1 <= endDate2) ||
            (startDate1 <= startDate2 && endDate1 >= endDate2)) {
            return true;
        }
        return false;
    }
}