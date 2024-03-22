
@isTest
private class GGW_SectionSelector_2_Tests {
    
    @testSetup
    static void setup() {
        // Retrieve valid picklist options for the Language__c field
        Schema.DescribeFieldResult fieldResult = GGW_Section__c.Language__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        // Ensure there are valid picklist values available
        if (ple.isEmpty()) {
            System.assert(false, 'The picklist for Language__c does not contain any values.');
        }
        
        // Use the first valid picklist value for the test
        String validLanguageValue = ple[0].getValue();

        // Sample data creation for sections
        List<GGW_Section__c> sections = new List<GGW_Section__c>();
        sections.add(new GGW_Section__c(Name='Section One', Language__c=validLanguageValue, Suggested__c=true, Sort_Order__c=1));
        
        // Insert sections if not empty
        if (!sections.isEmpty()) {
            insert sections;
        }
    }

    @isTest
    static void testQuerySectionsByLanguage_HappyPath() {
        String validLanguageValue = getValidLanguageValue();

        // Execute the method with a language that has matches
        Test.startTest();
        List<GGW_Section__c> sections = GGW_SectionSelector.querySectionsByLanguage(validLanguageValue);
        Test.stopTest();

        // Assertions
        System.assertEquals(1, sections.size(), 'Should return exactly one section for the valid language');
        System.assertEquals(validLanguageValue, sections[0].Language__c, 'The language of the returned section should match the query language');
    }

    // Additional test methods would go here...

    private static String getValidLanguageValue() {
        Schema.DescribeFieldResult fieldResult = GGW_Section__c.Language__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        return ple.isEmpty() ? null : ple[0].getValue();
    }
}
