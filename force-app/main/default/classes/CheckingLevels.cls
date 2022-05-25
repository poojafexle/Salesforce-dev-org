public class CheckingLevels {
    public static void levelsOFRelationalQuery() {
        Order[] orderList = [SELECT Id, Opportunity__r.Lead__r.Student__r.Contact__r.Account.Name FROM Order];
    }
}