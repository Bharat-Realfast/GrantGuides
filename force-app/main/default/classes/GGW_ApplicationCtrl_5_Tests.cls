
@isTest
private class GGW_ApplicationCtrl_5_Tests {
    
    @testSetup
    static void setup() {
        // Create test data for GGW_Grant_Application__c
        GGW_Grant_Application__c grantApp = new GGW_Grant_Application__c(Name = 'Test Application');
        // Add any other required fields for your GGW_Grant_Application__c object initialization
        insert grantApp;
        
        // Setup code for any other necessary related records should be added here
    }
    
    @isTest
    static void testDeleteLogoHappyPath() {
        GGW_Grant_Application__c grantApp = [SELECT Id FROM GGW_Grant_Application__c LIMIT 1];
        
        Test.startTest();
        String result = GGW_ApplicationCtrl.deleteLogo(grantApp.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result);
        System.assertEquals('Logo image deleted', result);
        
        // Verify that logo fields are nullified
        grantApp = [SELECT DistributionPublicUrl__c, Logo_Download_Url__c, Include_Logo__c FROM GGW_Grant_Application__c WHERE Id = :grantApp.Id];
        System.assertEquals(null, grantApp.DistributionPublicUrl__c);
        System.assertEquals(null, grantApp.Logo_Download_Url__c);
        System.assertEquals(false, grantApp.Include_Logo__c);
    }
    
    @isTest
    static void testDeleteLogoSadPathNoPermission() {
        // Assuming the user does not have permission to update the GGW_Grant_Application__c record
        GGW_Grant_Application__c grantApp = [SELECT Id, Include_Logo__c FROM GGW_Grant_Application__c LIMIT 1];
        grantApp.Include_Logo__c = true; // Set Include_Logo__c to true for testing
        update grantApp; // Update the record to simulate a logo being present before deletion attempt

        // Create a user with limited permissions
        User limitedPermissionUser = createLimitedPermissionUser();
        
        System.runAs(limitedPermissionUser) {
            // Attempt to delete the logo without having the necessary permissions
            Test.startTest();
            String result = GGW_ApplicationCtrl.deleteLogo(grantApp.Id);
            Test.stopTest();
            
            // Assertions
            grantApp = [SELECT Include_Logo__c FROM GGW_Grant_Application__c WHERE Id = :grantApp.Id];
            System.assertEquals(true, grantApp.Include_Logo__c, 'Logo should not be deleted as the user lacks permissions');
        }
    }
    
    static User createLimitedPermissionUser() {
        Profile limitedProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User newUser = new User(
            Alias = 'noperm',
            Email='noperm@testorg.com',
            EmailEncodingKey='UTF-8',
            LastName='NoPerm',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId = limitedProfile.Id,
            TimeZoneSidKey='America/Los_Angeles',
            UserName='noperm@testorg.com'
        );
        insert newUser;
        return newUser;
    }

    // Other test methods should be added here as necessary...
}
