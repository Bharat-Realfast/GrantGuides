
@isTest
public class GGW_ContentSelector_2_Tests {
    
    private static Id contentDocId;

    @testSetup
    static void setup() {
        // Create test data for ContentVersion as it's required for ContentDistribution
        ContentVersion contentVersion = new ContentVersion(
            Title = 'TestContentVersion',
            PathOnClient = 'TestContentVersion.jpg',
            VersionData = Blob.valueOf('Test content data'),
            IsMajorVersion = true
        );
        insert contentVersion;

        // Query the newly inserted ContentVersion to get the ContentDocumentId
        List<ContentVersion> contentVersions = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: contentVersion.Id];
        if (!contentVersions.isEmpty()) {
            contentDocId = contentVersions[0].ContentDocumentId;
        }

        // Create a ContentDistribution record for the ContentDocument
        ContentDistribution distribution = new ContentDistribution(
            Name = 'Test Distribution',
            ContentVersionId = contentVersion.Id
            // ContentDocumentId is automatically linked via ContentVersionId
        );
        insert distribution;
    }
    
    @isTest
    static void testGetContentDistributionWithValidDocId() {
        // Query the test data
        List<ContentDistribution> testDistributions = [SELECT ContentDocumentId FROM ContentDistribution];
        System.assertNotEquals(0, testDistributions.size(), 'Test distribution should exist.');
        String docId = testDistributions[0].ContentDocumentId;
        
        Test.startTest();
        ContentDistribution distribution = GGW_ContentSelector.getContentDistributionByDocId(docId);
        Test.stopTest();
        
        // Assert that a ContentDistribution record is returned
        System.assertNotEquals(null, distribution, 'ContentDistribution should not be null.');
        // Assert that the ContentDistribution has the correct ContentDocumentId
        System.assertEquals(docId, distribution.ContentDocumentId, 'The ContentDistribution should have the correct ContentDocumentId.');
    }
    
    @isTest
    static void testGetContentDistributionWithInvalidDocId() {
        String invalidDocId = '0123456789abcdef';

        Test.startTest();
        List<ContentDistribution> distributions = [SELECT Id FROM ContentDistribution WHERE ContentDocumentId = :invalidDocId];
        Test.stopTest();

        // Assert that no ContentDistribution record is returned
        System.assertEquals(0, distributions.size(), 'There should be no ContentDistribution records for an invalid ContentDocumentId.');
    }
    
    @isTest
    static void testGetContentDistributionWithNullDocId() {
        String nullDocId = null;

        Test.startTest();
        List<ContentDistribution> distributions = [SELECT Id FROM ContentDistribution WHERE ContentDocumentId = :nullDocId];
        Test.stopTest();

        // Assert that no ContentDistribution record is returned
        System.assertEquals(0, distributions.size(), 'There should be no ContentDistribution records for a null ContentDocumentId.');
    }
}
