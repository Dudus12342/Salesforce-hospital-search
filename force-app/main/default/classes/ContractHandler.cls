public with sharing class ContractHandler extends TriggerFactory{
    public List<Contract__c> oldContracts;
    public List<Contract__c> newContracts;
    public ContractHandler(){
        this.oldContracts = (List<Contract__c>) Trigger.old;
        this.newContracts = (List<Contract__c>) Trigger.new;
    }
    public override void beforeUpdate(){
        ContractController.duplicateContractChecker(this.oldContracts, this.newContracts);
    }
    public override void beforeInsert(){
        ContractController.duplicateContractChecker(new List<Contract__c>(), this.newContracts);
    }
}

// Wywołuję logikę