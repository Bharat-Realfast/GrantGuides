
@isTest
private class GGW_Util_9_Tests {
    
    // Method to create test data
    @testSetup
    static void setup() {
        // Since the method does not interact with records, 
        // no test data is required to be set up.
    }

    @isTest
    static void testGetSelectOptionFromPicklistWithNone() {
        // Disabling triggers is not needed since no DML operations are performed.
        List<GGW_Util.PickList> options = GGW_Util.getSelectOptionFromPicklist('Account', 'Type', true);
        System.assertNotEquals(null, options, 'Options should not be null');
        System.assertEquals('--None--', options[0].value, 'The first option should be --None--');
    }

    @isTest
    static void testGetSelectOptionFromPicklistWithoutNone() {
        List<GGW_Util.PickList> options = GGW_Util.getSelectOptionFromPicklist('Account', 'Type', false);
        System.assertNotEquals(null, options, 'Options should not be null');
        System.assertNotEquals('--None--', options[0].value, 'The first option should not be --None--');
    }

    @isTest
    static void testGetSelectOptionFromInvalidObject() {
        List<GGW_Util.PickList> options = GGW_Util.getSelectOptionFromPicklist('InvalidObject', 'Type', false);
        System.assertEquals(0, options.size(), 'Options list should be empty for invalid object');
    }

    @isTest
    static void testGetSelectOptionFromInvalidField() {
        List<GGW_Util.PickList> options = GGW_Util.getSelectOptionFromPicklist('Account', 'InvalidField', false);
        System.assertEquals(0, options.size(), 'Options list should be empty for invalid field');
    }
    
    // Add more test methods if needed...
}
