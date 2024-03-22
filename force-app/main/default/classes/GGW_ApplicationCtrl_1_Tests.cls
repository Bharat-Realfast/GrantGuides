
@isTest
private class GGW_ApplicationCtrl_1_Tests {

    @isTest
    static void testGgGtSteObjInitialization() {
        // Since we're testing a static variable initialization, there is no need to setup test data or disable triggers.
        // This is merely asserting that the static variable holds the correct sObject name upon class loading.
        
        String expectedObjectName = 'GGW_Grant_State__c';
        String actualObjectName = GGW_ApplicationCtrl.ggGtSteObj;
        
        System.assertNotEquals(null, actualObjectName, 'The ggGtSteObj variable should not be null.');
        System.assertEquals(expectedObjectName, actualObjectName, 'The ggGtSteObj variable should be initialized with the correct sObject name.');
    }
}
