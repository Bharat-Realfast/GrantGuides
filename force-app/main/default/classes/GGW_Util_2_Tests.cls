
@isTest
private class GGW_Util_2_Tests {

    // Since ggGtStLanField is a static variable that just retrieves metadata, we do not need to provide a test setup or test methods specifically targeting this variable.
    // However, we can test other utility methods that might rely on the ggGtStLanField to ensure they function correctly and thus, implicitly test the static variable initialization.

    @isTest
    static void testToLanguageLabelValid() {
        // For this test, we can assume that the 'Language__c' field has valid picklist values and that the 'toLanguageLabel' method uses the 'ggGtStLanField'
        // We would need to create a mock value that represents a valid picklist value for the 'Language__c' field
        // Since the 'toLanguageLabel' method also calls 'getValueMapFromPicklist', we need to ensure that this method is covered
        
        // Test Data Preparation
        // Normally, we would insert test data here, but for this test, we rely on the application's metadata (picklist values), which doesn't require data setup
        
        // Execution
        String result = GGW_Util.toLanguageLabel('en_US');
        
        // Verification
        System.assertEquals('English', result, 'The label for en_US should be English.');
    }

    @isTest
    static void testToLanguageLabelInvalid() {
        // For this test, we provide an invalid or unknown language code to ensure that the fallback language label is returned
        
        // Execution
        String result = GGW_Util.toLanguageLabel('invalid_code');
        
        // Verification
        System.assertEquals('English', result, 'The label for an invalid language code should be the default English.');
    }
}
