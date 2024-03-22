
@isTest
public class GGW_ApplicationCtrl_2_Tests {
    
    @isTest
    static void testGgGtStLanField() {
        // Expected field name
        String expectedFieldName = 'Language__c';

        // Perform the test
        Test.startTest();
        String actualFieldName = GGW_ApplicationCtrl.ggGtStLanField;
        Test.stopTest();

        // Verify
        System.assertEquals(expectedFieldName, actualFieldName, 'The field name should match the expected API name.');
    }
}
