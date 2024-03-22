
@isTest
private class GGW_SampleData_2_Tests {
    // Test Setup to create test data
    @testSetup
    static void makeTestData() {
        // Create test sections and save the reference ids in a map for later association with content blocks
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        for (Integer i = 0; i < 5; i++) {
            GGW_Section__c section = new GGW_Section__c(Name='TestSection' + i);
            sections.add(section);
        }
        insert sections;
    }
    
    // Test method for happy path scenario
    @isTest
    static void testInsertContentBlocksHappyPath() {
        // Retrieve the sections created in test setup
        Map<String, String> sectionMap = new Map<String, String>();
        List<GGW_Section__c> sections = [SELECT Id, Name FROM GGW_Section__c];
        for (GGW_Section__c section : sections) {
            sectionMap.put('secRef' + section.Name, section.Id);
        }
        
        // Call the method under test
        String result = GGW_SampleData.insertContentBlocks(sectionMap);
        
        // Assertions
        System.assert(result.contains('import complete.'), 'Expected import to be complete.');
        List<GGW_Content_Block__c> blocks = [SELECT Id, Name FROM GGW_Content_Block__c];
        System.assertEquals(sections.size(), blocks.size(), 'Expected same number of content blocks to be inserted as sections.');
    }
    
    // Test method for sad path scenario
    @isTest
    static void testInsertContentBlocksWithEmptySectionMap() {
        // Call the method under test with an empty section map
        Map<String, String> emptySectionMap = new Map<String, String>();
        String result = GGW_SampleData.insertContentBlocks(emptySectionMap);
        
        // Assertions
        System.assert(!result.contains('import complete.'), 'Import should not be complete with an empty section map.');
        List<GGW_Content_Block__c> blocks = [SELECT Id, Name FROM GGW_Content_Block__c];
        System.assertEquals(0, blocks.size(), 'Expected 0 content blocks to be inserted with an empty section map.');
    }
    
    // Test method for exception scenario
    @isTest
    static void testInsertContentBlocksExceptionScenario() {
        // Trigger an exception by providing a null map
        Boolean didThrowException = false;
        try {
            String result = GGW_SampleData.insertContentBlocks(null);
        } catch (Exception e) {
            didThrowException = true;
        }
        System.assert(didThrowException, 'An exception should have been thrown when passing a null map.');
    }
}
