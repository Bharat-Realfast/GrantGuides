
@isTest
private class GGW_SectionSelector_4_Tests {

    @testSetup
    static void setupTestData() {
        // Create a list of GGW_Section__c records to be used as test data
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        for (Integer i = 0; i < 5; i++) {
            sections.add(new GGW_Section__c(
                Name = 'TestSection' + i,
                Suggested__c = false // Set Suggested__c to false for all sections
            ));
        }
        insert sections;
    }

    @isTest
    static void testSearchKeyMatch() {
        Test.startTest();
        List<GGW_Section__c> results = GGW_SectionSelector.querySectionsByName('TestSection');
        Test.stopTest();

        System.assertEquals(5, results.size(), 'Expected to find 5 sections that match the search key and are not suggested.');
        for (GGW_Section__c section : results) {
            System.assert(section.Name.startsWith('TestSection'), 'Expected section name to start with "TestSection".');
        }
    }

    @isTest
    static void testEmptyResult() {
        Test.startTest();
        List<GGW_Section__c> results = GGW_SectionSelector.querySectionsByName('NonExistent');
        Test.stopTest();

        System.assertEquals(0, results.size(), 'Expected to find no sections that match the search key.');
    }

    @isTest
    static void testNullSearchKey() {
        Test.startTest();
        List<GGW_Section__c> results = GGW_SectionSelector.querySectionsByName(null);
        Test.stopTest();

        System.assertEquals(0, results.size(), 'Expected to find no sections when search key is null.');
    }

    @isTest
    static void testEmptySearchKey() {
        Test.startTest();
        List<GGW_Section__c> results = GGW_SectionSelector.querySectionsByName('');
        Test.stopTest();

        // Assuming that the method should return all sections where Suggested__c = false when the search key is empty.
        System.assertEquals(5, results.size(), 'Expected to find all non-suggested sections when search key is empty.');
    }
}
