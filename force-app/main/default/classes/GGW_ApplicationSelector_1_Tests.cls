
@isTest
public class GGW_ApplicationSelector_1_Tests {

    // Test setup method to create test data
    @testSetup
    static void setup() {
        // Assuming 'Active' is not a valid picklist value for Status__c, we'll leave it out or use a valid value if known
        
        // Create a list to hold grant applications
        List<GGW_Grant_Application__c> grantApplications = new List<GGW_Grant_Application__c>();

        // Create a new grant application record
        GGW_Grant_Application__c grantApplication = new GGW_Grant_Application__c(
            // Required fields initialization (excluding read-only fields and restricted picklists if values are unknown)
            Logo_Download_Url__c = 'http://example.com/logo.png',
            DistributionPublicUrl__c = 'http://example.com/public',
            // Status__c field is commented out; if a valid value is known it should be used here
            // Status__c = 'Valid Picklist Value',
            Description__c = 'Test Description',
            // Language__c field is commented out; if a valid value is known it should be used here
            // Language__c = 'Valid Picklist Value',
            Include_Logo__c = true
        );
        grantApplications.add(grantApplication);
        
        // Insert the list of grant applications into the database
        insert grantApplications;
    }
    
    // Happy Path Test - Records Exist
    @isTest
    static void testGetGrantApplicationsWithRecords() {
        Test.startTest();
        List<GGW_Grant_Application__c> applications = GGW_ApplicationSelector.getGrantApplications();
        Test.stopTest();
        
        System.assertNotEquals(null, applications, 'The applications list should not be null.');
        System.assertEquals(1, applications.size(), 'There should be one application record.');
    }
    
    // Sad Path Test - No Records
    @isTest
    static void testGetGrantApplicationsWithoutRecords() {
        // Clear all records to simulate no data scenario
        delete [SELECT Id FROM GGW_Grant_Application__c];
        
        Test.startTest();
        List<GGW_Grant_Application__c> applications = GGW_ApplicationSelector.getGrantApplications();
        Test.stopTest();
        
        System.assertEquals(0, applications.size(), 'The applications list should be empty.');
    }
}
