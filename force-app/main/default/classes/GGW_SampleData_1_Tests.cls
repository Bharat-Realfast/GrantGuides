
@isTest
private class GGW_SampleData_1_Tests {
    
    private static final String IMPORT_CANCELLED_MESSAGE = 'Section data already exists. IMPORT CANCELLED';
    
    @testSetup
    static void setup() {
        // Prepare test data that can be shared across test methods
        // Since we're testing insertSampleSections, we won't create any GGW_Section__c records here
    }

    @isTest
    static void testInsertSampleSections_HappyPath() {
        Test.startTest();
        String result = GGW_SampleData.insertSampleSections();
        Test.stopTest();

        // Assertions for Happy Path
        System.assert(result.contains('import complete.'), 'Expected the result to indicate completion of import.');
        System.assert(result.contains('Sample section data'), 'Expected the result to contain "Sample section data".');
        // Additionally, we can assert that section records were actually created
    }

    @isTest
    static void testInsertSampleSections_SadPath() {
        // Create a section record to simulate the existence of section data
        GGW_Section__c section = new GGW_Section__c(Name = 'Test Section');
        insert section;

        String result = GGW_SampleData.insertSampleSections();

        // Assertions for Sad Path
        System.assertEquals(IMPORT_CANCELLED_MESSAGE, result, 'Expected the cancellation message when sections already exist.');
    }
}
