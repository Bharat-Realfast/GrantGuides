
@isTest
private class GGW_ApplicationCtrl_13_Tests {
    
    // Using testSetup to create test data
    @testSetup
    static void makeTestData() {
        // Creating a test section
        GGW_Section__c testSection = new GGW_Section__c(
            Name = 'Test Section',
            Recommended__c = true,
            Suggested__c = true
        );
        insert testSection;
        
        // Creating test content blocks
        GGW_Content_Block__c testContentBlock1 = new GGW_Content_Block__c(
            Name = 'Test Content Block 1',
            Section__c = testSection.Id,
            Description__c = 'Description for Test Content Block 1'
        );
        GGW_Content_Block__c testContentBlock2 = new GGW_Content_Block__c(
            Name = 'Test Content Block 2',
            Section__c = testSection.Id,
            Description__c = 'Description for Test Content Block 2'
        );
        insert new List<GGW_Content_Block__c>{testContentBlock1, testContentBlock2};
    }

    // Happy path: Test retrieving content blocks with a valid section ID
    @isTest
    static void testGetContentBlocksWithValidSectionId() {
        Test.startTest();
        
        // Retrieve test data
        GGW_Section__c testSection = [SELECT Id FROM GGW_Section__c LIMIT 1];
        List<GGW_ContentBlockWrapper> contentBlocks = GGW_ApplicationCtrl.getContentBlocks(testSection.Id);
        
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, contentBlocks, 'Content blocks should not be null');
        System.assertEquals(2, contentBlocks.size(), 'There should be 2 content blocks retrieved');
    }

    // Sad path: Test retrieving content blocks with a valid section ID but no content blocks
    @isTest
    static void testGetContentBlocksWithNoBlocksForSection() {
        Test.startTest();
        
        // Creating a test section with no content blocks
        GGW_Section__c testSection = new GGW_Section__c(
            Name = 'Empty Section',
            Recommended__c = false,
            Suggested__c = false
        );
        insert testSection;
        List<GGW_ContentBlockWrapper> contentBlocks = GGW_ApplicationCtrl.getContentBlocks(testSection.Id);
        
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, contentBlocks, 'Content blocks should not be null');
        System.assertEquals(0, contentBlocks.size(), 'There should be no content blocks retrieved');
    }

    // Exceptional scenario: Test retrieving content blocks with an invalid section ID
    @isTest
    static void testGetContentBlocksWithInvalidSectionId() {
        Test.startTest();
        
        String invalidSectionId = 'InvalidId';
        List<GGW_ContentBlockWrapper> contentBlocks = GGW_ApplicationCtrl.getContentBlocks(invalidSectionId);
        
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, contentBlocks, 'Content blocks should not be null');
        System.assertEquals(0, contentBlocks.size(), 'There should be no content blocks retrieved for an invalid ID');
    }
}
