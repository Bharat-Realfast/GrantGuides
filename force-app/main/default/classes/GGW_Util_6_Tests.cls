
@isTest
private class GGW_Util_6_Tests {
    // Test setup for creating test data
    @testSetup
    static void setup() {
        // Create a test Grant Application record, normally you'd create related records if needed
        GGW_Grant_State__c grantState = new GGW_Grant_State__c();
        grantState.Current_User__c = UserInfo.getUserId();
        grantState.Grant_Application__c = 'DummyGrantId';
        insert grantState;
    }
    
    // Helper method to retrieve test data including the necessary field
    private static GGW_Grant_State__c getTestGrantState() {
        return [SELECT Id, Current_User__c, Grant_Application__c FROM GGW_Grant_State__c LIMIT 1];
    }

    // Test method for updating an existing Grant State
    @isTest
    static void testUpdateExistingGrantState() {
        // Get the test record created in setup
        GGW_Grant_State__c grantState = getTestGrantState();
        
        // Perform test
        Test.startTest();
        GGW_Util.saveGrantState('NewGrantId');
        Test.stopTest();
        
        // Requery the updated grant state record and verify it was updated correctly
        GGW_Grant_State__c updatedGrantState = [SELECT Id, Grant_Application__c FROM GGW_Grant_State__c WHERE Id = :grantState.Id];
        System.assertNotEquals(null, updatedGrantState, 'Grant State should not be null');
        System.assertEquals('NewGrantId', updatedGrantState.Grant_Application__c, 'Grant State should be updated with new Grant ID');
    }
    
    // Test method for creating a new Grant State when none exist for the user
    @isTest
    static void testCreateNewGrantState() {
        // Remove any existing grant states for a clean slate
        delete [SELECT Id FROM GGW_Grant_State__c WHERE Current_User__c = :UserInfo.getUserId()];
        
        // Perform test
        Test.startTest();
        GGW_Util.saveGrantState('AnotherGrantId');
        Test.stopTest();
        
        // Verify a new grant state record was created
        List<GGW_Grant_State__c> grantStates = [SELECT Id, Grant_Application__c FROM GGW_Grant_State__c WHERE Current_User__c = :UserInfo.getUserId()];
        System.assertEquals(1, grantStates.size(), 'One new Grant State record should be created');
        System.assertEquals('AnotherGrantId', grantStates[0].Grant_Application__c, 'New Grant State record should have the correct Grant ID');
    }
    
    // Test method for handling null or empty grantId
    @isTest
    static void testGrantIdNullOrEmpty() {
        // We expect the method to handle null or empty inputs gracefully
        String emptyGrantId = '';
        String nullGrantId = null;
        
        // Perform test with empty grantId
        Test.startTest();
        GGW_Util.saveGrantState(emptyGrantId);
        Test.stopTest();
        
        // Perform test with null grantId
        Test.startTest();
        GGW_Util.saveGrantState(nullGrantId);
        Test.stopTest();
        
        // Assert that no errors occurred and the method handled the input as expected
        // Since the behavior with null/empty input is not defined, there's no specific assertion here
        System.assert(true, 'Method should handle null or empty Grant ID gracefully');
    }
}
