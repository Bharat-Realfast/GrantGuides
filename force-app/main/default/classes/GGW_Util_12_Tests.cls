
@isTest
private class GGW_Util_12_Tests {

    // Test the happy path scenario where valid strings are passed to PickList constructor
    @isTest
    static void testPickListCreationWithValidStrings() {
        // Arrange
        String validVal = 'testValue';
        String validLbl = 'testLabel';

        // Act
        GGW_Util.PickList pickListInstance = new GGW_Util.PickList(validVal, validLbl);

        // Assert
        System.assertEquals(validVal, pickListInstance.value, 'The value should match the input value.');
        System.assertEquals(validLbl, pickListInstance.label, 'The label should match the input label.');
    }

    // Test the sad path scenario where null is passed to PickList constructor for value
    @isTest
    static void testPickListCreationWithNullValue() {
        // Arrange
        String nullVal = null;
        String validLbl = 'testLabel';

        // Act
        GGW_Util.PickList pickListInstance = new GGW_Util.PickList(nullVal, validLbl);

        // Assert
        System.assertEquals(nullVal, pickListInstance.value, 'The value should be null.');
        System.assertEquals(validLbl, pickListInstance.label, 'The label should match the input label.');
    }

    // Test the sad path scenario where null is passed to PickList constructor for label
    @isTest
    static void testPickListCreationWithNullLabel() {
        // Arrange
        String validVal = 'testValue';
        String nullLbl = null;

        // Act
        GGW_Util.PickList pickListInstance = new GGW_Util.PickList(validVal, nullLbl);

        // Assert
        System.assertEquals(validVal, pickListInstance.value, 'The value should match the input value.');
        System.assertEquals(nullLbl, pickListInstance.label, 'The label should be null.');
    }

    // Test the sad path scenario where null is passed to PickList constructor for both value and label
    @isTest
    static void testPickListCreationWithNullValueAndLabel() {
        // Arrange
        String nullVal = null;
        String nullLbl = null;

        // Act
        GGW_Util.PickList pickListInstance = new GGW_Util.PickList(nullVal, nullLbl);

        // Assert
        System.assertEquals(nullVal, pickListInstance.value, 'The value should be null.');
        System.assertEquals(nullLbl, pickListInstance.label, 'The label should be null.');
    }
}
