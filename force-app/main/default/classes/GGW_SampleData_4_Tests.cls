
@isTest
private class GGW_SampleData_4_Tests {
    
    // Happy Path Test
    @isTest
    static void testReadContentBlockData() {
        // Assuming the Static Resource 'GGWContentBlockData' exists and is accessible

        // Perform the read operation within a try-catch block to simulate handling of the missing resource in the actual method
        List<GGW_SampleData.GGW_Content_Block> result = new List<GGW_SampleData.GGW_Content_Block>();
        Boolean caughtException = false;
        try {
            Test.startTest();
            result = GGW_SampleData.readContentBlockData();
            Test.stopTest();
        } catch (QueryException e) {
            caughtException = true;
        }
        
        // Assert that no exception was thrown and the result is as expected
        System.assert(!caughtException, 'No exception should be thrown if the static resource exists and is accessible.');
        System.assertNotEquals(null, result, 'The result should not be null.');
        // We assume that there is data in the Static Resource, but we cannot assert the size of the result in the test context.
    }
    
    // Note: The sad path test is not included because we cannot simulate a missing StaticResource in Apex tests.
    // The handling of a non-existent StaticResource should be part of the actual application code, not the test code.
}
