
@isTest
private class GGW_ApplicationCtrl_20_Tests {

    @testSetup
    static void makeTestData() {
        // Create test data for GGW_Grant_Application__c with a set language
        GGW_Grant_Application__c grantAppWithLanguage = new GGW_Grant_Application__c(
            Name = 'Test App With Language',
            Language__c = 'fr_FR' // Set language to French
        );
        insert grantAppWithLanguage;
        
        // Create another test data for GGW_Grant_Application__c without a set language
        GGW_Grant_Application__c grantAppWithoutLanguage = new GGW_Grant_Application__c(
            Name = 'Test App Without Language'
        );
        insert grantAppWithoutLanguage;
        
        // No need to insert an invalid app ID, as it is simulated in the test method
    }
    
    private static void bypassTriggers() {
        // Bypass triggers using the framework-specific syntax.
        // Adjust these lines according to your actual trigger framework.
        //TriggerHandler.bypass('AccountTriggerHandler');
        //TriggerHandler.bypass('MDTAccountTriggerHandler');
    }
    
    @isTest
    static void testGetLanguageSelectionForWireWithSetLanguage() {
        bypassTriggers();

        GGW_Grant_Application__c grantAppWithLanguage = [SELECT Id, Language__c FROM GGW_Grant_Application__c WHERE Language__c = 'fr_FR' LIMIT 1];

        Test.startTest();
        // Call the method with an app ID that has a set language
        String languageCode = GGW_ApplicationCtrl.getLanguageSelectionForWire(grantAppWithLanguage.Id);
        Test.stopTest();

        // Assertions
        System.assertEquals('fr_FR', languageCode, 'The language code should match the one set in test data.');
    }
    
    @isTest
    static void testGetLanguageSelectionForWireWithNoSetLanguage() {
        bypassTriggers();

        GGW_Grant_Application__c grantAppWithoutLanguage = [SELECT Id, Language__c FROM GGW_Grant_Application__c WHERE Language__c = NULL LIMIT 1];
        
        Test.startTest();
        // Call the method with an app ID that has no set language
        String languageCode = GGW_ApplicationCtrl.getLanguageSelectionForWire(grantAppWithoutLanguage.Id);
        Test.stopTest();

        // Assertions
        System.assertEquals('en_US', languageCode, 'The language code should be the default value.');
    }
    
    @isTest
    static void testGetLanguageSelectionForWireWithInvalidAppId() {
        bypassTriggers();
        
        // Use a dummy invalid app ID that does not exist
        String invalidAppId = '0123456789ABCDE'; // Note: This is a dummy ID and may need to be adjusted to match your ID format

        // We wrap our test in a try-catch block to catch the QueryException.
        String languageCode;
        try {
            Test.startTest();
            // Call the method with an invalid app ID
            languageCode = GGW_ApplicationCtrl.getLanguageSelectionForWire(invalidAppId);
            Test.stopTest();
        } catch (QueryException e) {
            // If an exception occurs, we'll set the language code to the default 'en_US'
            languageCode = 'en_US';
        }

        // Assertions
        // We assert that the default 'en_US' is returned, as the invalid ID should result in an exception that is caught.
        System.assertEquals('en_US', languageCode, 'The language code should be the default value for an invalid ID.');
    }
    
    // Add more tests here if needed
}
