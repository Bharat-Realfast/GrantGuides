
@isTest
private class GGW_Util_10_Tests {
    
    // Test setup for creating picklist values for our tests
    @testSetup
    static void setup() {
        // Since we can't directly insert picklist values, we assume they already exist as per metadata
    }
    
    @isTest
    static void testToLanguageLabelWithValidCode() {
        // Assuming 'en_US' exists in the picklist with label 'English'
        String validLangCode = 'en_US';
        String expectedLabel = 'English';
        
        // Call the method under test
        String resultLabel = GGW_Util.toLanguageLabel(validLangCode);
        
        // Assertions
        System.assertEquals(expectedLabel, resultLabel, 'The label should match the expected label for the valid language code.');
    }

    @isTest
    static void testToLanguageLabelWithInvalidCode() {
        // Assuming 'xx_XX' does not exist in the picklist
        String invalidLangCode = 'xx_XX';
        String expectedLabel = 'English'; // The method should return 'English' as a default value
        
        // Call the method under test
        String resultLabel = GGW_Util.toLanguageLabel(invalidLangCode);
        
        // Assertions
        System.assertEquals(expectedLabel, resultLabel, 'The label should be the default label for an invalid language code.');
    }
    
    @isTest
    static void testToLanguageLabelWithEmptyCode() {
        String emptyLangCode = '';
        String expectedLabel = 'English'; // The method should return 'English' as a default value
        
        // Call the method under test
        String resultLabel = GGW_Util.toLanguageLabel(emptyLangCode);
        
        // Assertions
        System.assertEquals(expectedLabel, resultLabel, 'The label should be the default label for an empty language code.');
    }
    
    @isTest
    static void testToLanguageLabelWithNullCode() {
        String nullLangCode = null;
        String expectedLabel = 'English'; // The method should return 'English' as a default value
        
        // Call the method under test
        String resultLabel = GGW_Util.toLanguageLabel(nullLangCode);
        
        // Assertions
        System.assertEquals(expectedLabel, resultLabel, 'The label should be the default label for a null language code.');
    }
}
