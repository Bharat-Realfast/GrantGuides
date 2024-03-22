
@isTest
private class GGW_SampleData_5_Tests {
    
    @testSetup
    static void setup() {
        // Create sample data to be used across all tests
        List<GGW_Section__c> sectionList = new List<GGW_Section__c>();
        sectionList.add(new GGW_Section__c(Name = 'Test Section 1'));
        sectionList.add(new GGW_Section__c(Name = 'Test Section 2'));
        insert sectionList; // Insert test sections
    }
    
    @isTest
    static void testIsSectionExists_WithSections() {
        // Test
        Test.startTest();
        Boolean exists = GGW_SampleData.isSectionExists();
        Test.stopTest();
        
        // Assertions
        System.assert(exists, 'Sections should exist.');
    }
    
    @isTest
    static void testIsSectionExists_WithoutSections() {
        // Test is designed to run without any sections existing
        // Due to test setup, we need to delete the sections created in setup
        delete [SELECT Id FROM GGW_Section__c];
        
        // Test
        Test.startTest();
        Boolean exists = GGW_SampleData.isSectionExists();
        Test.stopTest();
        
        // Assertions
        System.assert(!exists, 'Sections should not exist.');
    }
}
