
@isTest
private class GGW_Util_7_Tests {

    @testSetup
    static void setup() {
        // Assuming 'en_US' is a valid picklist option for the 'Language__c' field
        String validLanguage = 'en_US';

        // Create a GGW_Grant_State__c record for the current user with a language preference
        GGW_Grant_State__c grantState = new GGW_Grant_State__c(
            Current_User__c = UserInfo.getUserId(),
            Language__c = validLanguage // Use a valid language code here
        );
        insert grantState;
    }

    @isTest
    static void testGetGrantLanguage_ExistingRecordWithLanguage() {
        String expectedLanguage = 'en_US';
        Test.startTest();
        String resultLanguage = GGW_Util.getGrantLanguage();
        Test.stopTest();

        System.assertEquals(expectedLanguage, resultLanguage, 'The language should be retrieved from the Grant State record.');
    }

    @isTest
    static void testGetGrantLanguage_NoRecordExists() {
        // Delete the existing Grant State record to simulate no record exists for the current user
        delete [SELECT Id FROM GGW_Grant_State__c WHERE Current_User__c = :UserInfo.getUserId() LIMIT 1];

        String expectedLanguage = 'en_US';
        Test.startTest();
        String resultLanguage = GGW_Util.getGrantLanguage();
        Test.stopTest();

        System.assertEquals(expectedLanguage, resultLanguage, 'The default language should be returned when no record exists.');
    }

    @isTest
    static void testGetGrantLanguage_ExistingRecordWithoutLanguage() {
        // Update the existing Grant State record to have no language preference
        GGW_Grant_State__c grantState = [SELECT Id, Language__c FROM GGW_Grant_State__c WHERE Current_User__c = :UserInfo.getUserId() LIMIT 1];
        grantState.Language__c = null;
        update grantState;

        String expectedLanguage = 'en_US';
        Test.startTest();
        String resultLanguage = GGW_Util.getGrantLanguage();
        Test.stopTest();

        System.assertEquals(expectedLanguage, resultLanguage, 'The default language should be returned when the record language is null.');
    }
}
