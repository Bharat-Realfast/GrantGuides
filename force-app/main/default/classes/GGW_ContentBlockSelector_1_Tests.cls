
@isTest
private class GGW_ContentBlockSelector_1_Tests {
    
    @TestSetup
    static void makeTestData() {
        // Create a Content Block for testing
        GGW_Content_Block__c testBlock = new GGW_Content_Block__c(
            Name = 'Test Content Block',
            Description__c = 'Test Description'
        );
        insert testBlock;
    }
    
    @isTest
    static void testValidContentBlockIdQuery() {
        // Retrieve the test data
        GGW_Content_Block__c existingBlock = [SELECT Id FROM GGW_Content_Block__c LIMIT 1];

        // Run the actual test
        Test.startTest();
        GGW_Content_Block__c result = GGW_ContentBlockSelector.queryContentBlockById(existingBlock.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result, 'Content Block should not be null');
        System.assertEquals(existingBlock.Id, result.Id, 'The ID of the content block should match the queried ID');
    }
    
    @isTest
    static void testInvalidContentBlockIdQuery() {
        // Generate a random ID that doesn't match any existing record
        String fakeId = 'a1BX0000001FakeP'; 

        // Run the actual test
        Test.startTest();
        GGW_Content_Block__c result;
        try {
            result = GGW_ContentBlockSelector.queryContentBlockById(fakeId);
        } catch (QueryException e) {
            // Expected exception when no rows are found
        }
        Test.stopTest();

        // Assertions (result should be null because no record with fakeId exists)
        System.assertEquals(null, result, 'No Content Block should be retrieved with an invalid ID');
    }
    
    @isTest
    static void testNullContentBlockIdQuery() {
        // Run the actual test
        Test.startTest();
        GGW_Content_Block__c result;
        try {
            result = GGW_ContentBlockSelector.queryContentBlockById(null);
        } catch (Exception e) {
            // Expected exception when null is passed
        }
        Test.stopTest();

        // Assertions (result should be null because null was passed as the ID)
        System.assertEquals(null, result, 'No Content Block should be retrieved when querying with null ID');
    }
}
