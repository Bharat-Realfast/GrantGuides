
@isTest
public class GGW_ApplicationCtrl_15_Tests {

    @testSetup
    static void setup() {
        // Create a test section that will be associated with the content block
        GGW_Section__c testSection = new GGW_Section__c(Name = 'Test Section', Recommended__c = true, Suggested__c = true);
        insert testSection;
    }

    @isTest
    static void testAddTextBlockToLibraryHappyPath() {
        // Query the test section created in the @testSetup method
        GGW_Section__c testSection = [SELECT Id FROM GGW_Section__c LIMIT 1];

        String richText = '<p>This is a rich text block content.</p>';
        String name = 'New Text Block';

        Test.startTest();
        String resultId = GGW_ApplicationCtrl.addTextBlockToLibrary(testSection.Id, richText, name);
        Test.stopTest();

        // Verify that the text block was created
        System.assertNotEquals(null, resultId, 'The text block should have been created successfully.');
        System.assert(resultId.startsWith('a'), 'The returned ID should start with "a" for a valid Salesforce record ID.');
    }

    @isTest
    static void testAddTextBlockToLibraryInvalidSectionId() {
        // Use an invalid Section ID
        String sectionId = '123456789012345';
        String richText = '<p>This is a rich text block content.</p>';
        String name = 'New Text Block';

        Boolean exceptionThrown = false;
        try {
            Test.startTest();
            String resultId = GGW_ApplicationCtrl.addTextBlockToLibrary(sectionId, richText, name);
            Test.stopTest();
        } catch (Exception e) {
            exceptionThrown = true;
        }

        // Verify that an exception was thrown due to the invalid Section ID
        System.assert(exceptionThrown, 'An exception should have been thrown for an invalid section ID.');
    }

    // Additional test methods for scenarios like no create permission or exceptions
    // should be implemented based on the actual project's permission framework and mocking capabilities.
}
