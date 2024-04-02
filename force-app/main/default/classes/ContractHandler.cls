public with sharing class ContractHandler extends TriggerFactory{
    public List<Contract__c> oldContracts;
    public List<Contract__c> newContracts;
    public ContractHandler(){
        this.oldContracts = (List<Contract__c>) Trigger.old;
        this.newContracts = (List<Contract__c>) Trigger.new;
    }
    public override void beforeUpdate(){
        
    }
    public override void beforeInsert(){

    }
}