
@isTest
private class GGW_Util_5_Tests {

    // Use @testSetup to create common test data
    @testSetup
    static void setupTestData() {
        // Assuming that the GGW_Grant_State__c object and fields are set up in the org
        // No need to insert test data for this scenario
    }

    @isTest
    static void shouldUpdateExistingGrantState() {
        // Create a new state to update
        GGW_Grant_State__c state = new GGW_Grant_State__c(
            // Initialize required fields, such as Language__c and Grant_Application__c
        );
        insert state;

        // Set new language to update
        String newLanguage = 'en_US';

        Test.startTest();
        // Assuming the state ID is used as the grantId
        String resultMessage = GGW_Util.saveGrantLanguage(newLanguage, state.Id);
        Test.stopTest();

        // Query the updated state
        GGW_Grant_State__c updatedState = [SELECT Language__c FROM GGW_Grant_State__c WHERE Id = :state.Id LIMIT 1];

        // Assertions
        System.assertEquals('Language state is updated', resultMessage);
        System.assertEquals(newLanguage, updatedState.Language__c);
    }

    @isTest
    static void shouldInsertNewGrantState() {
        // Define new language and grant application ID
        String newLanguage = 'en_US';
        String newGrantId = 'NewGrantId'; // This should be a valid Id or represent a test record

        Test.startTest();
        String resultMessage = GGW_Util.saveGrantLanguage(newLanguage, newGrantId);
        Test.stopTest();

        // Query the newly inserted state
        GGW_Grant_State__c newState = [SELECT Language__c, Grant_Application__c FROM GGW_Grant_State__c WHERE Grant_Application__c = :newGrantId LIMIT 1];

        // Assertions
        System.assertEquals('NEW Language state is inserted', resultMessage);
        System.assertEquals(newLanguage, newState.Language__c);
        System.assertEquals(newGrantId, newState.Grant_Application__c);
    }

    @isTest
    static void shouldHandleInvalidInputs() {
        // Define invalid language and grantId
        String invalidLanguage = '';
        String invalidGrantId = '';

        Test.startTest();
        String resultMessage = GGW_Util.saveGrantLanguage(invalidLanguage, invalidGrantId);
        Test.stopTest();

        // Since the method saveGrantLanguage does not explicitly handle empty or null inputs
        // for the language and grantId by returning a specific error message, we should not expect
        // the 'Save language select failed.' message. Instead, we should validate that no new
        // GGW_Grant_State__c record has been created in the system.

        // Query to ensure no new record has been created
        Integer recordCount = [SELECT count() FROM GGW_Grant_State__c WHERE Language__c = :invalidLanguage AND Grant_Application__c = :invalidGrantId];

        // Assertions
        System.assertEquals(0, recordCount, 'No new GGW_Grant_State__c record should have been created with invalid inputs.');
    }
}
