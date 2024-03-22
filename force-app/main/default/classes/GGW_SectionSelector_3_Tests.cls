
@isTest
public class GGW_SectionSelector_3_Tests {

    @testSetup
    static void setup() {
        // Creating test data
        List<GGW_Section__c> sectionList = new List<GGW_Section__c>();
        for (Integer i = 0; i < 5; i++) {
            sectionList.add(new GGW_Section__c(
                Name = 'Section ' + i,
                Sort_Order__c = i
            ));
        }

        insert sectionList;
    }
    
    @isTest
    static void testQuerySectionsWithResults() {
        Test.startTest();
        List<GGW_Section__c> sections = GGW_SectionSelector.querySections();
        Test.stopTest();
        
        // Asserts
        System.assertEquals(5, sections.size(), 'Should return all sections');
        System.assertEquals('Section 0', sections[0].Name, 'The first section should be the one with the lowest Sort_Order__c');
    }
    
    @isTest
    static void testQuerySectionsWithoutResults() {
        // Delete all sections to simulate no results scenario
        delete [SELECT Id FROM GGW_Section__c];

        Test.startTest();
        List<GGW_Section__c> sections = GGW_SectionSelector.querySections();
        Test.stopTest();
        
        // Asserts
        System.assert(sections.isEmpty(), 'Should return an empty list if no sections are available');
    }
}
