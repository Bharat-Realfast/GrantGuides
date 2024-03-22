
@isTest
private class GGW_ApplicationCtrl_18_Tests {

    @testSetup
    static void setup() {
        // Create and insert test data necessary for the tests
        GGW_Grant_Application__c testApp = new GGW_Grant_Application__c(Name = 'Test Application', Language__c = 'en_US');
        insert testApp;
    }

    private static String getTestAppId() {
        GGW_Grant_Application__c testApp = [SELECT Id FROM GGW_Grant_Application__c LIMIT 1];
        return testApp.Id;
    }

    @isTest
    static void testSaveLanguageSelectionHappyPath() {
        // Prepare test data
        String appId = getTestAppId();
        String lang = 'en_US';

        // Perform the test
        Test.startTest();
        String result = GGW_ApplicationCtrl.saveLanguageSelection(lang, appId);
        Test.stopTest();

        // Perform assertions
        System.assertNotEquals(null, result, 'The result should not be null for a valid language and app ID');
        System.assertEquals('NEW Language state is inserted', result, 'The expected message was not returned for a valid scenario');
    }

    @isTest
    static void testSaveLanguageSelectionInvalidLanguage() {
        // Prepare test data
        String appId = getTestAppId();
        String lang = 'xx_XX'; // Assuming 'xx_XX' is not a valid language code

        // Perform the test
        Test.startTest();
        String result = GGW_ApplicationCtrl.saveLanguageSelection(lang, appId);
        Test.stopTest();

        // Perform assertions
        System.assertNotEquals(null, result, 'The result should not be null for an invalid language code');
        System.assertEquals('NEW Language state is inserted', result, 'The expected message was not returned for an invalid language code');
    }

    @isTest
    static void testSaveLanguageSelectionInvalidAppId() {
        // Prepare test data
        String appId = '000000000000000'; // Assuming this is not a valid application Id
        String lang = 'en_US';

        // Perform the test
        Test.startTest();
        String result = GGW_ApplicationCtrl.saveLanguageSelection(lang, appId);
        Test.stopTest();

        // Perform assertions
        System.assertNotEquals(null, result, 'The result should not be null for an invalid application ID');
        System.assertEquals('NEW Language state is inserted', result, 'The expected message was not returned for an invalid application ID');
    }

    @isTest
    static void testSaveLanguageSelectionNullParameters() {
        // Prepare test data
        String appId = null;
        String lang = null;

        // Perform the test
        Test.startTest();
        String result = GGW_ApplicationCtrl.saveLanguageSelection(lang, appId);
        Test.stopTest();

        // Perform assertions
        System.assertNotEquals(null, result, 'The result should not be null for null parameters');
        System.assertEquals('NEW Language state is inserted', result, 'The expected message was not returned for null parameters');
    }
}
