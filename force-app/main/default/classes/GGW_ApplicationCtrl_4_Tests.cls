
@isTest
private class GGW_ApplicationCtrl_4_Tests {
    
    @testSetup
    static void setup() {
        // Create test data records for GGW_Grant_Application__c
        List<GGW_Grant_Application__c> grantApplications = new List<GGW_Grant_Application__c>{
            new GGW_Grant_Application__c(Name = 'Test Grant 1'),
            new GGW_Grant_Application__c(Name = 'Test Grant 2')
        };
        
        insert grantApplications;
    }
    
    @isTest
    static void testGetApplicationListWithRecords() {
        Test.startTest();
        List<GGW_Grant_Application__c> applications = GGW_ApplicationCtrl.getApplicationList();
        Test.stopTest();
        
        // Assertions
        System.assertEquals(2, applications.size(), 'There should be 2 grant applications returned.');
        System.assertNotEquals(null, applications[0].Id, 'The returned grant application records should have Ids.');
    }
    
    @isTest
    static void testGetApplicationListWithoutRecords() {
        // Delete test data records to simulate no grant applications available
        delete [SELECT Id FROM GGW_Grant_Application__c];
        
        Test.startTest();
        List<GGW_Grant_Application__c> applications = GGW_ApplicationCtrl.getApplicationList();
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, applications.size(), 'There should be no grant applications returned.');
    }
}
