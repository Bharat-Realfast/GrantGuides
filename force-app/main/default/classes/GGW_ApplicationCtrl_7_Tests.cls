
@isTest
private class GGW_ApplicationCtrl_7_Tests {
    
    // Test data setup
    @testSetup
    static void makeTestData() {
        // Setup Test Data
        // Create a dummy Grant Application record
        GGW_Grant_Application__c grant = new GGW_Grant_Application__c(
            Name = 'Test Grant',
            Status__c = 'In Progress'
            // set other required fields as per your org configuration
        );
        insert grant;
        
        // Create a dummy ContentVersion record
        ContentVersion contentVersion = new ContentVersion(
            Title = 'TestContentVersion',
            PathOnClient = 'TestContentVersion.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
            // set other required fields as per your org configuration
        );
        insert contentVersion;
    }
    
    // Happy Path Test
    @isTest
    static void testCreateContentDistributionSuccess() {
        // Prepare Test Data for the scenario
        GGW_Grant_Application__c grant = [SELECT Id FROM GGW_Grant_Application__c LIMIT 1];
        ContentVersion cv = [SELECT Id, Title FROM ContentVersion LIMIT 1];
        
        Test.startTest();
        // Call method under test
        String downloadUrl = GGW_ApplicationCtrl.createContentDistribution(grant.Id, cv.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, downloadUrl, 'ContentDistribution should be created with a download URL.');
        // Check if the grant application was updated with the new URL
        GGW_Grant_Application__c updatedGrant = [SELECT Logo_Download_Url__c FROM GGW_Grant_Application__c WHERE Id = :grant.Id];
        System.assertEquals(downloadUrl, updatedGrant.Logo_Download_Url__c, 'Grant application should have the updated logo download URL.');
    }
    
    // Sad Path Test
    @isTest
    static void testCreateContentDistributionFailure() {
        // Assuming the test setup has created a ContentVersion and Grant Application record
        GGW_Grant_Application__c grant = [SELECT Id FROM GGW_Grant_Application__c LIMIT 1];
        String fakeCVID = 'nonexistentCVID';
        
        Test.startTest();
        // Call method under test
        String result = GGW_ApplicationCtrl.createContentDistribution(grant.Id, fakeCVID);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'A null value should be returned if ContentDistribution creation fails.');
    }
}
