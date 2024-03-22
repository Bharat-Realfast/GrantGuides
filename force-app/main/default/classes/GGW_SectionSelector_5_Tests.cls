
@isTest
private class GGW_SectionSelector_5_Tests {

    // Assume 'YOUR_TRIGGER_BYPASS_METHOD' is replaced with the actual bypass mechanism for your project.

    @testSetup
    static void makeTestData() {
        // YOUR_TRIGGER_BYPASS_METHOD();

        // Create test data for GGW_Section__c
        // Note: We are not creating any suggested sections with a positive sort order here.
        // The happy path test will create its own suggested sections.
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        sections.add(new GGW_Section__c(Name='Unsuggested Section', Suggested__c = false));
        insert sections;
    }

    @isTest
    static void testFindMaxOrderSectionWhenRecordsExist() {
        // YOUR_TRIGGER_BYPASS_METHOD();

        // Create suggested sections with a positive sort order for this test case only.
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        sections.add(new GGW_Section__c(Name='Section 1', Suggested__c = true, Sort_Order__c = 10));
        sections.add(new GGW_Section__c(Name='Section 2', Suggested__c = true, Sort_Order__c = 15));
        insert sections;

        // Test retrieval of max order section
        Test.startTest();
        GGW_Section__c maxOrderSection = GGW_SectionSelector.findMaxOrderSection();
        Test.stopTest();

        // Asserts
        System.assertNotEquals(null, maxOrderSection, 'The return value should not be null.');
        System.assertEquals(15, maxOrderSection.Sort_Order__c, 'The sort order should be the maximum value of 15.');
    }

    @isTest
    static void testFindMaxOrderSectionWhenNoSuggestedRecords() {
        // YOUR_TRIGGER_BYPASS_METHOD();

        // Test
        Test.startTest();
        GGW_Section__c maxOrderSection = GGW_SectionSelector.findMaxOrderSection();
        Test.stopTest();

        // Asserts
        System.assertEquals(null, maxOrderSection, 'The return value should be null because there are no suggested records.');
    }

    @isTest
    static void testFindMaxOrderSectionWhenSuggestedRecordsHaveNullOrZeroSortOrder() {
        // YOUR_TRIGGER_BYPASS_METHOD();

        // Create suggested sections with null or zero sort order for this test case only.
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        sections.add(new GGW_Section__c(Name='Section 1', Suggested__c = true, Sort_Order__c = 0));
        sections.add(new GGW_Section__c(Name='Section 2', Suggested__c = true, Sort_Order__c = null));
        insert sections;

        // Test
        Test.startTest();
        GGW_Section__c maxOrderSection = GGW_SectionSelector.findMaxOrderSection();
        Test.stopTest();

        // Asserts
        System.assertEquals(null, maxOrderSection, 'The return value should be null because all suggested records have null or zero sort order.');
    }
}
