@isTest
public class TaskUtilTest {
	@isTest static void testWarmTemp() {
        String str = TaskUtil.getTaskPriority('CA');
        System.assertEquals('Normal',str);
    }
}