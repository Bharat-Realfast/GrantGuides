
@isTest
private class GGW_ContentBlockSelector_2_Tests {

    @testSetup
    static void setup() {
        // Create an Account record to simulate the Section
        Account testAccount = new Account(Name = 'Test Account Section');
        insert testAccount;

        // Create a few Content Block records associated with the Account
        List<GGW_Content_Block__c> cBlocks = new List<GGW_Content_Block__c>{
            new GGW_Content_Block__c(Name = 'Block1', Section__c = testAccount.Id),
            new GGW_Content_Block__c(Name = 'Block2', Section__c = testAccount.Id)
        };
        insert cBlocks;
    }
    
    @isTest
    static void testQueryContentBlocksByValidSection() {
        // Retrieve the Account record to use its ID for the section
        Account sectionAccount = [SELECT Id FROM Account WHERE Name = 'Test Account Section' LIMIT 1];

        // Call the method with a valid section ID
        List<GGW_Content_Block__c> blocks = GGW_ContentBlockSelector.queryContentBlocksBySection(sectionAccount.Id);

        // Assertions
        System.assertEquals(2, blocks.size(), 'There should be 2 content blocks for the section.');
        System.assertEquals('Block1', blocks[0].Name, 'The first content block name should match.');
    }

    @isTest
    static void testQueryContentBlocksBySectionWithNoContent() {
        // Create a fake Account ID that does not exist in the test data
        String fakeAccountId = '001XXXXXXXXXXXXXXX'; // Example of a 15-character Salesforce ID

        // Call the method with an Account ID that has no content blocks
        List<GGW_Content_Block__c> blocks = GGW_ContentBlockSelector.queryContentBlocksBySection(fakeAccountId);

        // Assertions
        System.assertNotEquals(null, blocks, 'Blocks list should not be null even if the section ID does not exist.');
        System.assertTrue(blocks.isEmpty(), 'There should be no content blocks for the fake section.');
    }

    @isTest
    static void testQueryContentBlocksWithNullSectionId() {
        // Since Salesforce throws an exception on a query with a null ID,
        // we expect an exception to be thrown here as we're testing the behavior of the method.
        Boolean exceptionThrown = false;
        try {
            GGW_ContentBlockSelector.queryContentBlocksBySection(null);
        } catch (Exception e) {
            exceptionThrown = e instanceof QueryException;
        }

        // Assertions
        System.assertTrue(exceptionThrown, 'A QueryException should be thrown when section ID is null.');
    }
}
