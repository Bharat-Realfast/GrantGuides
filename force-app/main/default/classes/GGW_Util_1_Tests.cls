
@isTest
private class GGW_Util_1_Tests {
    
    // Since the target method is a static variable initialization, no test data setup is required
    // As per the instructions, we will not include any @testSetup method
    
    // Test to ensure the sObject name is correctly retrieved
    @isTest
    static void testGetSObjectName() {
        // Execute the method that utilizes the static variable we want to test
        String sObjectName = GGW_Util.ggGtSteObj;

        // Assert the sObject name is correct
        System.assertEquals('GGW_Grant_State__c', sObjectName, 'The sObject name should match the API name of the custom object.');
    }
}
