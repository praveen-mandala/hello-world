@IsTest
public class TestPaginationREDOController {

    @IsTest
    public static void testGetPagination() {
        PaginationREDOController paginationREDOController = new PaginationREDOController();
        paginationREDOController.getContacts();
        paginationREDOController.flag = false;
    }
}