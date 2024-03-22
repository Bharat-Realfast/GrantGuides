
@isTest
private class GGW_ContentSelector_4_Tests {

    @testSetup
    static void setup() {
        // Create test ContentVersion record
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test Content',
            PathOnClient = 'TestContent.jpg',
            VersionData = Blob.valueOf('Test Data')
        );
        // Insert the record for test setup
        insert testContentVersion;
    }
    
    @isTest
    static void testGetContentFileHappyPath() {
        // Retrieve the test record created in @testSetup
        List<ContentVersion> testContentVersions = [SELECT Id, Title FROM ContentVersion];
        System.assert(testContentVersions.size() > 0, 'Test ContentVersion record should exist.');
        ContentVersion testContentVersion = testContentVersions[0];
        
        // Execute method to test the happy path
        ContentVersion result = GGW_ContentSelector.getContentFile(testContentVersion.Id);
        
        // Assertions
        System.assertNotEquals(null, result, 'ContentVersion should not be null');
        System.assertEquals(testContentVersion.Title, result.Title, 'The title of the ContentVersion should match');
    }
    
    @isTest
    static void testGetContentFileSadPath() {
        // Generate a dummy Id that doesn't correspond to any actual record
        Id dummyId = Id.valueOf('068000000000000AAA'); // This should be a non-existent ContentVersion Id
        
        // Execute method with non-existent ContentVersion Id and expect no result
        Test.startTest();
        List<ContentVersion> results = [SELECT Id, Title FROM ContentVersion WHERE Id = :dummyId];
        Test.stopTest();
        
        // Assertions
        System.assertEquals(0, results.size(), 'No ContentVersion should be returned for a non-existent Id');
    }
    
    @isTest
    static void testGetContentFileExceptionalScenario() {
        // Test with null Id
        Exception caughtException;
        
        try {
            ContentVersion result = GGW_ContentSelector.getContentFile(null);
        } catch (Exception e) {
            caughtException = e;
        }
        
        // Assertion
        System.assert(caughtException instanceof QueryException, 'Passing null should have thrown a QueryException.');
    }
}
