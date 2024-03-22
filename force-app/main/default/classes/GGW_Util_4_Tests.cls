
@isTest
private class GGW_Util_4_Tests {

    @isTest
    static void testIsValidStringWithNonNullNonEmptyString() {
        // Happy path scenario
        String testString = 'Salesforce';
        Boolean result = GGW_Util.isValidString(testString);
        System.assertEquals(true, result, 'The string should be valid');
    }

    @isTest
    static void testIsValidStringWithNull() {
        // Sad path scenario with null string
        String testString = null;
        Boolean result = GGW_Util.isValidString(testString);
        System.assertEquals(false, result, 'The result should be false for null strings');
    }

    @isTest
    static void testIsValidStringWithEmptyString() {
        // Sad path scenario with empty string
        String testString = '';
        Boolean result = GGW_Util.isValidString(testString);
        System.assertEquals(false, result, 'The result should be false for empty strings');
    }

    // Not writing a test for an exceptional scenario, as there aren't any for isValidString method.
}
