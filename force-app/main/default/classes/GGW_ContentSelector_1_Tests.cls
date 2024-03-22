
@isTest
public class GGW_ContentSelector_1_Tests {
    @testSetup
    static void setup() {
        // Create test data
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        ContentVersion contentVersion = new ContentVersion(
            Title = 'Test Content Version',
            PathOnClient = 'TestContentVersion.txt',
            VersionData = Blob.valueOf('Test content data'),
            IsMajorVersion = true
        );
        insert contentVersion;

        Id contentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: contentVersion.Id].ContentDocumentId;

        ContentDocumentLink cdl = new ContentDocumentLink(
            LinkedEntityId = testAccount.Id,
            ContentDocumentId = contentDocumentId,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl;
    }

    @isTest
    static void testGetDocLinkByLinkedEntityWithValidRecordId() {
        Test.startTest();
        
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        ContentDocumentLink result = GGW_ContentSelector.getDocLinkByLinkedEntity(testAccount.Id);
        
        Test.stopTest();
        
        System.assertNotEquals(null, result, 'ContentDocumentLink should not be null');
        System.assertEquals(testAccount.Id, result.LinkedEntityId, 'The LinkedEntityId should match the test account ID');
    }

    @isTest
    static void testGetDocLinkByLinkedEntityWithNoRecordId() {
        Test.startTest();
        
        ContentDocumentLink result = GGW_ContentSelector.getDocLinkByLinkedEntity('nonexistent');
        
        Test.stopTest();
        
        System.assertEquals(null, result, 'ContentDocumentLink should be null for non-existing record');
    }

    @isTest
    static void testGetDocLinkByLinkedEntityWithNullRecordId() {
        Test.startTest();
        
        try {
            ContentDocumentLink result = GGW_ContentSelector.getDocLinkByLinkedEntity(null);
            System.assert(false, 'A QueryException should have been thrown due to null recordId');
        } catch (QueryException e) {
            // Expected exception, no further assertions needed
        }
        
        Test.stopTest();
    }
}
