
@isTest
public class GGW_ContentSelector_3_Tests {
    
    @testSetup
    static void setupTestData() {
        ContentVersion cv = new ContentVersion(
            Title = 'Test CV',
            PathOnClient = 'TestCV.jpg',
            VersionData = Blob.valueOf('Test data'),
            IsMajorVersion = true
        );
        insert cv;
        
        // Query for the ContentDocumentId related to the ContentVersion just inserted
        cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];

        // Insert a ContentDistribution for the ContentVersion
        ContentDistribution cd = new ContentDistribution(
            Name = 'Test CD',
            ContentVersionId = cv.Id
            // ContentDocumentId is set automatically based on ContentVersion's Document
        );
        insert cd;
    }

    @isTest
    static void testGetContentDistributionByIdValidId() {
        // Get the inserted ContentDistribution record to obtain a valid ID
        ContentDistribution existingCD = [SELECT Id FROM ContentDistribution LIMIT 1];
        Id validCDId = existingCD.Id;

        Test.startTest();
        ContentDistribution result = GGW_ContentSelector.getContentDistributionById(validCDId);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null for a valid ID.');
        System.assertEquals(validCDId, result.Id, 'The ID of the result should be the same as the test data ID.');
    }

    @isTest
    static void testGetContentDistributionByIdInvalidId() {
        // Generate a syntactically correct, but non-existing ContentDistribution Id
        Id invalidCDId = Schema.SObjectType.ContentDistribution.getKeyPrefix() + '000000000000XXX';

        ContentDistribution result;
        Boolean isExceptionOccurred = false;
        
        Test.startTest();
        try {
            result = GGW_ContentSelector.getContentDistributionById(invalidCDId);
        } catch (QueryException e) {
            // Catch the exception to prevent test failure, assert later
            isExceptionOccurred = true;
        }
        Test.stopTest();

        // Assertions
        System.assertEquals(true, isExceptionOccurred, 'QueryException should be thrown for an invalid ID.');
    }

    @isTest
    static void testGetContentDistributionByIdNullId() {
        // Expect an exception to be thrown for a null ID
        Exception caughtException;

        Test.startTest();
        try {
            ContentDistribution result = GGW_ContentSelector.getContentDistributionById(null);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for a null ID.');
    }
}
