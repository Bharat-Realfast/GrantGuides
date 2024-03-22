
@isTest
private class GGW_Util_3_Tests {

    @testSetup
    static void setup() {
        // Create test data for GGW_Selected_Item__c
        // Insert other necessary records and relationships if required
        // Assume there is a relationship with Account and it's necessary for the test
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        
        GGW_Selected_Item__c selectedItem = new GGW_Selected_Item__c(
            // Assuming Selected_Block__c is a required field
            Grant_Application__c = testAccount.Id, // Assuming this is the relationship field to Account
            Selected_Block__c = 'Test Block',
            Sort_Order__c = 1
            // Add other required field initializations if necessary
        );
        insert selectedItem;
    }
    
    @isTest
    static void testGetSelectedItemsWithValidAppId() {
        Test.startTest();
        // Retrieve the test data
        Account testAccount = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        List<GGW_Selected_Item__c> selectedItems = GGW_Util.getSelectedItems(testAccount.Id);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(1, selectedItems.size(), 'Should return exactly 1 selected item.');
        System.assertEquals('Test Block', selectedItems[0].Selected_Block__c, 'Selected Block should match.');
    }
    
    @isTest
    static void testGetSelectedItemsWithNoRelatedRecords() {
        Test.startTest();
        // Pass a valid-looking but non-existent appId
        String fakeAppId = 'a000000000000000';
        List<GGW_Selected_Item__c> selectedItems = GGW_Util.getSelectedItems(fakeAppId);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, selectedItems.size(), 'Should return an empty list when no related records are found.');
    }
    
    @isTest
    static void testGetSelectedItemsWithNullAppId() {
        Test.startTest();
        // Pass a null appId which should handle gracefully and return an empty list
        String nullAppId = null;
        List<GGW_Selected_Item__c> selectedItems = GGW_Util.getSelectedItems(nullAppId);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, selectedItems.size(), 'Should return an empty list for null appId.');
    }
}
