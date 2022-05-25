@isTest
public class TestVerifyDate {
    @isTest  static void testCorrectCheckDates() {
        Date checkDate = VerifyDate.CheckDates(Date.today(), Date.today().addDays( 29 ));
        System.assertEquals(Date.today().addDays( 29 ),checkDate);
    }
        @isTest  static void testInCorrectCheckDates() {
        Date checkDate = VerifyDate.CheckDates(Date.today(), Date.today().addDays( 31 ));
        Integer totalDays = Date.daysInMonth(Date.today().year(), Date.today().month());
		Date lastDay = Date.newInstance(Date.today().year(), Date.today().month(), totalDays);
        System.assertEquals(lastDay,checkDate);
    }
}