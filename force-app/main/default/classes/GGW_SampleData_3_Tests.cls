
@isTest
private class GGW_SampleData_3_Tests {

    @isTest
    static void testReadSectionDataHappyPath() {
        // Perform any necessary setup here if required before calling the method under test
        // Assuming that the necessary StaticResource named 'GGWSectionData' with expected JSON content exists in the org

        Test.startTest();
        List<GGW_SampleData.GGW_Section> sections = GGW_SampleData.readSectionData();
        Test.stopTest();

        // Assert that the returned list of sections is not null
        System.assertNotEquals(null, sections, 'The sections list should not be null.');
        
        // Assert that the returned list has the expected number of sections
        // The specific size should match the number of sections in the StaticResource content
        System.assertEquals(1, sections.size(), 'There should be one section returned from the static resource.');
        
        // Assert that the returned list contains sections with expected values
        // The specific assertions here would depend on the known content of the 'GGWSectionData' StaticResource
        GGW_SampleData.GGW_Section section = sections[0];
        System.assertEquals('Sample Section', section.Name, 'The section name should match the expected value.');
    }
}
