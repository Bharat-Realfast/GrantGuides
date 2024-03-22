
@isTest
private class GGW_ContentBlockSelector_3_Tests {

    @testSetup
    static void setup() {
        // Creating test data for GGW_Content_Block__c
        List<GGW_Content_Block__c> contentBlocks = new List<GGW_Content_Block__c>();
        for (Integer i = 0; i < 5; i++) {
            GGW_Content_Block__c block = new GGW_Content_Block__c(
                Name = 'TestBlock' + i,
                Description__c = 'Test Description ' + i,
                Short_Description__c = 'Test Short Description ' + i,
                Section__c = 'TestSection' + (i % 2), // To create two sections for ordering
                Language__c = 'EN'
            );
            contentBlocks.add(block);
        }
        insert contentBlocks;
    }

    @isTest
    static void testQueryContentBlocksWithRecords() {
        // This test case verifies that the method returns a non-empty list when records are present

        Test.startTest();
        List<GGW_Content_Block__c> blocks = GGW_ContentBlockSelector.queryContentBlocks();
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, blocks, 'The returned list should not be null.');
        System.assert(blocks.size() > 0, 'The returned list should contain records.');
    }

    @isTest
    static void testQueryContentBlocksWithNoRecords() {
        // This test case verifies that the method returns an empty list when there are no records

        Test.startTest();
        List<GGW_Content_Block__c> blocks = GGW_ContentBlockSelector.queryContentBlocks();
        Test.stopTest();

        // Assertions
        System.assertEquals(0, blocks.size(), 'The returned list should be empty.');
    }
}
