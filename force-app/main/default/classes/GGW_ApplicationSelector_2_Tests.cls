
@isTest
private class GGW_ApplicationSelector_2_Tests {

    // Test data creation is omitted for brevity and must be adjusted as per actual object fields and requirements.

    @testSetup
    static void setup() {
        // Create test data for GGW_Grant_Application__c
        GGW_Grant_Application__c grantApp = new GGW_Grant_Application__c(
            // Fields initialization
            // Example: Application_Name__c = 'Test Application',
            // Status__c = 'Open',
            // Description__c = 'Test Description',
            // Language__c = 'English',
            // Include_Logo__c = true
            // ... other required fields ...
        );
        insert grantApp;
    }

    @isTest
    static void testQueryGrantAppWithValidId() {
        GGW_Grant_Application__c existingGrantApp = [SELECT Id FROM GGW_Grant_Application__c LIMIT 1];
        Test.startTest();
        GGW_Grant_Application__c result = GGW_ApplicationSelector.queryGrantApp(existingGrantApp.Id);
        Test.stopTest();
        System.assertNotEquals(null, result, 'The grant application should not be null.');
        System.assertEquals(existingGrantApp.Id, result.Id, 'The ID should match the test record.');
    }

    @isTest
    static void testQueryGrantAppWithNonexistentId() {
        String nonexistentId = '012345678901234';
        GGW_Grant_Application__c result = null;

        Test.startTest();
        try {
            result = GGW_ApplicationSelector.queryGrantApp(nonexistentId);
        } catch (System.QueryException e) {
            // Expected exception for non-existent ID
        }
        Test.stopTest();

        System.assertEquals(null, result, 'Result should be null for a non-existent ID.');
    }

    @isTest
    static void testQueryGrantAppWithNullId() {
        GGW_Grant_Application__c result = null;

        Test.startTest();
        try {
            result = GGW_ApplicationSelector.queryGrantApp(null);
        } catch (System.QueryException e) {
            // Expected exception for null ID
        }
        Test.stopTest();

        System.assertEquals(null, result, 'Result should be null for a null ID.');
    }
}
