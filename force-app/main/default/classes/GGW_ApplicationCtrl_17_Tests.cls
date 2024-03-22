
@isTest
private class GGW_ApplicationCtrl_17_Tests {
    
    // Test setup method to create data required for the tests
    @testSetup
    static void setup() {
        // Create test sections for searching
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        sections.add(new GGW_Section__c(Name='Education', Language__c='en_US'));
        sections.add(new GGW_Section__c(Name='Healthcare', Language__c='en_US'));
        insert sections;
    }
    
    // Tests when search key is provided and matching sections are found
    @isTest
    static void testFindSectionsWithResults() {
        // Perform search with key that exists
        Test.startTest();
        List<GGW_SectionWrapper> result = GGW_ApplicationCtrl.findSections('Health');
        Test.stopTest();
        
        // Assertions
        System.assertEquals(1, result.size(), 'Should return 1 matching section');
    }
    
    // Tests when search key is provided but no matching sections are found
    @isTest
    static void testFindSectionsWithNoResults() {
        // Perform search with key that doesn't exist
        Test.startTest();
        List<GGW_SectionWrapper> result = GGW_ApplicationCtrl.findSections('Agriculture');
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, result.size(), 'Should return 0 matching sections');
    }
    
    // Tests when null or empty search key is provided
    @isTest
    static void testFindSectionsWithNullOrEmptyKey() {
        // Perform search with null or empty search key
        Test.startTest();
        List<GGW_SectionWrapper> resultWithNullKey = GGW_ApplicationCtrl.findSections(null);
        List<GGW_SectionWrapper> resultWithEmptyKey = GGW_ApplicationCtrl.findSections('');
        Test.stopTest();
        
        // Assertions for null or empty search key
        System.assertEquals(0, resultWithNullKey.size(), 'Should return 0 sections for null search key');
        System.assertEquals(0, resultWithEmptyKey.size(), 'Should return 0 sections for empty search key');
    }
}
