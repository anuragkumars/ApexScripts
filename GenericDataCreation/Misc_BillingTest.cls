/**
 * Perforce keywords
 *
 * $Author: $ 
 * $Change: $ 
 * $Date: $ 
 * $DateTime: $ 
 * $File: $ 
 * $Header: $ 
 * $Id: $ 
 * $Revision: $ 
 *
*/

/**
 Original Details:

 Author : Anurag
 Project : <Misc>
*/

public class Misc_BillingTest {

 private static storBillingProcessTestUtils billProcessTestUtil = new storBillingProcessTestUtils();
  public static Map<String,Object> testcase_create_sobject (String p_dataSet, String p_entityType,String p_getThisAsId,Map <String,Object> p_addOnValues) {
    Map<String, Object> hm_dataMap = DataSetTestClass.getData(p_dataSet);
       
    // Iterate over the key value pair for add on
    if (p_addOnValues != null) {
     for (String skey : p_addOnValues.keySet()) {
       hm_dataMap.put (skey, p_addOnValues.get(skey) );
     }
    }

    return GenericSObject_Util.createSObject(hm_dataMap,p_getThisAsId,p_entityType);
  }
  
  public static Map<String,Object> testcase_create_org (String p_intDataSet,Map <String,Object> p_addOnValues) {
    // Create Mock Org
    String ls_entityType = 'MockOrg__c'; 
    String ls_getThisAsId = 'id';
    return testcase_create_sobject(p_intDataSet,ls_entityType,ls_getThisAsId,p_addOnValues);
    }
    public static Map<String,Object> testcase_create_Tenant (String p_intDataSet,Map <String,Object> p_addOnValues) {
    // Create Tenant
    String ls_entityType = 'Tenant'; 
    String ls_getThisAsId = 'TenantId';
    return testcase_create_sobject(p_intDataSet,ls_entityType,ls_getThisAsId,p_addOnValues);
    }
  public static Map<String,Object> testcase_create_accountLocation (String p_intDataSet,Map <String,Object> p_addOnValues) {
    // Create Account Location
    String ls_entityType = 'Apttus_Config2_AccountLocation__c'; 
    String ls_getThisAsId = 'id';
    return testcase_create_sobject(p_intDataSet,ls_entityType,ls_getThisAsId,p_addOnValues);
    }

  public static Map<String,Object> testcase_create_account (String p_intDataSet,Map <String,Object> p_addOnValues) {
    // Create Account
    String ls_entityType = 'Account'; 
    String ls_getThisAsId = 'AccountId';
    return testcase_create_sobject(p_intDataSet,ls_entityType,ls_getThisAsId,p_addOnValues);
    }

   public static Map<String,Object> testcase_create_contract (String intDataSet,Map <String,Object> p_addOnValues) {
    // Create Contract
    String ls_entityType = 'Contract'; 
    String ls_getThisAsId = 'ContractId';
    return testcase_create_sobject (intDataSet, ls_entityType,ls_getThisAsId,p_addOnValues);
  }

   public static Map<String,Object> testcase_create_order (String intDataSet,Map <String,Object> p_addOnValues) {
    // Create Order
    String ls_entityType = 'Order'; 
    String ls_getThisAsId = 'OrderId';
    return testcase_create_sobject (intDataSet, ls_entityType,ls_getThisAsId,p_addOnValues);
  }
  
   public static Map<String,Object> testcase_create_orderitem (String intDataSet,Map <String,Object> p_addOnValues) {
    // Create OrderItem
    String ls_entityType = 'OrderItem'; 
    String ls_getThisAsId = 'OrderItemId';
    return testcase_create_sobject (intDataSet, ls_entityType,ls_getThisAsId,p_addOnValues);
  }
  
  public static void testcase_creation(String p_intDataSet) {
    
    Map<String, Object> p_addOnValues = new Map<String, Object> ();
        
    Map<String, Object> ls_accountId = testcase_create_account (p_intDataSet, p_addOnValues);
    
    p_addOnValues.put ('AccountId',ls_accountId);
    
    Map<String, Object> ls_orgId = testcase_create_org(p_intDataSet, p_addOnValues);
    
    p_addOnValues.put ('id',ls_orgId);
    
    Map<String, Object> ls_accountLocationId = testcase_create_accountLocation(p_intDataSet, p_addOnValues);
    
    p_addOnValues.put ('id',ls_accountLocationId);
    
    Map<String, Object> ls_contractId = testcase_create_contract (p_intDataSet, p_addOnValues);
    
    p_addOnValues = new Map<String, Object> ();
    p_addOnValues.put ('ContractId',ls_contractId);
    
    Map<String, Object> ls_orderId = testcase_create_order (p_intDataSet, p_addOnValues);
    
    p_addOnValues = new Map<String, Object> ();
    p_addOnValues.put ('OrderId',ls_orderId);

    Map<String, Object> ls_orderItemId = testcase_create_orderitem (p_intDataSet, p_addOnValues);
    
    p_addOnValues = new Map<String, Object> ();
    p_addOnValues.put ('OrderItemId',ls_orderItemId);

  }
 
 
   
 public static Object getPriceBookEntry (Map<String,Object> p_addOnValues ) {
  
  String sPriceBookName = (String) p_addOnValues.get('PriceBookName');
  String sProductName   = (String) p_addOnValues.get('ProductName');
  Integer iBillingFreq   = (Integer) p_addOnValues.get('BillingFrequency');
  //Integer bf = Integer.valueof(sBillingFreq);
  system.debug('**sPriceBookName** '+sPriceBookName);
  system.debug('**sProductName** '+sProductName);
  List<PricebookEntry > pblist = [SELECT p.Id,p.Name, p.BillingFrequency
            from PricebookEntry p  
            WHERE CurrencyIsoCode = 'USD' 
            AND p.Pricebook2Id in (Select p.Id from Pricebook2 p where p.name=:sPriceBookName and p.IsActive = true) 
            and Name = :sProductName and BillingFrequency = :iBillingFreq];
   return ((PricebookEntry )pblist.get(0)).Id;
  
  } 
  
   
  // *****************TestCase 1a*******************************
   private static testMethod void UtilizationBilling_01() {

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
   hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

   System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
   

   System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
     
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
  hm_inDataMap.put ('ContractTerm',1);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
     System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    Decimal unitprice =OI.UnitPrice;
    
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    
  // Integer BF =OI.BillingFrequency;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice);
     
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
    
     system.assert(unitprice ==trxline.sfbill__UnitPrice__c);
     system.assert(qty == trxline.sfbill__Quantity__c);
     system.assert(totalprice == trxline.sfbill__TotalPrice__c);
   system.assert(MU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(totalprice = trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);
     Test.StopTest();
  }
  //******************TestCase 1b **************************
   private static testMethod void UtilizationBilling_02() {

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
  Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
  hm_inDataMap.put ('ContractTerm',6);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    //Integer BF =OI.BillingFrequency;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
    
     system.assert(unitprice ==trxline.sfbill__UnitPrice__c);
     system.assert(qty == trxline.sfbill__Quantity__c);
     system.assert(totalprice == trxline.sfbill__TotalPrice__c);
   system.assert(MU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(totalprice == trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);
     
   Test.StopTest();
  }
  
  /*******************TestCase 1c **************************/
   private static testMethod void UtilizationBilling_03() {

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
  Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('ContractTerm',12);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
   // Integer BF =OI.BillingFrequency;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
    
     system.assert(unitprice ==trxline.sfbill__UnitPrice__c);
     system.assert(qty == trxline.sfbill__Quantity__c);
     system.assert(totalprice == trxline.sfbill__TotalPrice__c);
   system.assert(MU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(totalprice == trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);
   
   Test.StopTest();
     
  }
  /******************TestCase 1d **************************/
   private static testMethod void UtilizationBilling_04() {
   
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('ContractTerm',24);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    Integer BF =OI.BillingFrequency;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
    
     system.assert(unitprice ==trxline.sfbill__UnitPrice__c);
     system.assert(qty == trxline.sfbill__Quantity__c);
     system.assert(totalprice == trxline.sfbill__TotalPrice__c);
   system.assert(MU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(totalprice = trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);

   Test.StopTest();
     
  }
  
  /******************TestCase 2a **************************/
   private static testMethod void UtilizationBilling_05() {
  
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',1);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.01);
  hm_addOnValues1.put(Quantity,1);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Additional Contacts - Pro Edition');
    hm_addOnValues1.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice);
  
  system.assert(unitprice1 ==1250.00);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
     system.assert(unitprice ==trxline[0].sfbill__UnitPrice__c);
     system.assert(qty == trxline[0].sfbill__Quantity__c);
     system.assert(totalprice == trxline[0].sfbill__TotalPrice__c);
     system.assert(MU == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(totalprice == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == trxline[1].sfbill__Quantity__c);
     system.assert(totalprice1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(MU1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(totalprice1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
     Test.StopTest();
  }
  /******************TestCase 2b **************************/
   private static testMethod void UtilizationBilling_06() {
   
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',6);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.01);
  hm_addOnValues1.put(Quantity,1);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Additional Contacts - Pro Edition');
    hm_addOnValues1.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice);
  
  system.assert(unitprice1 ==1250.00);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
     system.assert(unitprice ==trxline[0].sfbill__UnitPrice__c);
     system.assert(qty == trxline[0].sfbill__Quantity__c);
     system.assert(totalprice == trxline[0].sfbill__TotalPrice__c);
     system.assert(MU == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(totalprice == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == trxline[1].sfbill__Quantity__c);
     system.assert(totalprice1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(MU1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(totalprice1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);

     Test.StopTest();
     
  }
  
  
   /******************TestCase 2c **************************/
   private static testMethod void UtilizationBilling_07() {
  {
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',12);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.01);
  hm_addOnValues1.put(Quantity,1);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Additional Contacts - Pro Edition');
    hm_addOnValues1.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice);
  
  system.assert(unitprice1 ==1250.00);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
     system.assert(unitprice ==trxline[0].sfbill__UnitPrice__c);
     system.assert(qty == trxline[0].sfbill__Quantity__c);
     system.assert(totalprice == trxline[0].sfbill__TotalPrice__c);
     system.assert(MU == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(totalprice == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == trxline[1].sfbill__Quantity__c);
     system.assert(totalprice1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(MU1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(totalprice1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
     Test.StopTest();
     
  }
  
  
   /******************TestCase 2d **************************/
   private static testMethod void UtilizationBilling_08() {
  {
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',24);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.01);
  hm_addOnValues1.put(Quantity,1);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Additional Contacts - Pro Edition');
    hm_addOnValues1.put('BillingFrequency',1);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==1250.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice);
  
  system.assert(unitprice1 ==1250.00);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
     system.assert(unitprice ==trxline[0].sfbill__UnitPrice__c);
     system.assert(qty == trxline[0].sfbill__Quantity__c);
     system.assert(totalprice == trxline[0].sfbill__TotalPrice__c);
     system.assert(MU == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(totalprice == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == trxline[1].sfbill__Quantity__c);
     system.assert(totalprice1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(MU1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(totalprice1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
  }
  
  
   /******************TestCase 3a **************************/
   private static testMethod void UtilizationBilling_09() { 

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
  hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',1);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
  hm_inDataMap.put('UnitPrice',30);
  hm_inDataMap.put('Quantity',10);
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',0);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    Integer BF =OI.BillingFrequency;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
    
     system.assert(unitprice ==trxline.sfbill__UnitPrice__c);
     system.assert(qty == trxline.sfbill__Quantity__c);
     system.assert(totalprice == trxline.sfbill__TotalPrice__c);
   system.assert(MU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(totalprice = trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);

        Test.StopTest();
 
 }
  
  
   /******************TestCase 3b **************************/
   private static testMethod void UtilizationBilling_10() {

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
  hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',6);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
  hm_inDataMap.put('UnitPrice',30);
  hm_inDataMap.put('Quantity',10);
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',0);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,sfbase__OrderItemTermMonths__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    Integer BF =OI.BillingFrequency;
  Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  system.assert(OI.totalprice ==qty*unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
              
  Decimal Txnqty = trxline.sfbill__Quantity__c;
  Decimal TxnUnitPrice =trxline.sfbill__UnitPrice__c;
    
     system.assert(TxnUnitPrice ==trxline.sfbill__UnitPrice__c);
     system.assert(Txnqty == trxline.sfbill__Quantity__c);
     system.assert(Txnqty*TxnUnitPrice == trxline.sfbill__TotalPrice__c);
   system.assert(NMU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(Txnqty*TxnUnitPrice = trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);
        
     Test.StopTest();
     
  }
  
  
   /******************TestCase 3c **************************/
   private static testMethod void UtilizationBilling_11() {

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('ContractTerm',12);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
  hm_inDataMap.put('UnitPrice',30);
  hm_inDataMap.put('Quantity',10);
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',0);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,sfbase__OrderItemTermMonths__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    Integer BF =OI.BillingFrequency;
  Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  system.assert(OI.totalprice ==qty*unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
              
  Decimal Txnqty = trxline.sfbill__Quantity__c;
  Decimal TxnUnitPrice =trxline.sfbill__UnitPrice__c;
    
     system.assert(TxnUnitPrice ==trxline.sfbill__UnitPrice__c);
     system.assert(Txnqty == trxline.sfbill__Quantity__c);
     system.assert(Txnqty*TxnUnitPrice == trxline.sfbill__TotalPrice__c);
   system.assert(NMU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(Txnqty*TxnUnitPrice = trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);
     
      Test.StopTest();
}

   /******************TestCase 3d **************************/
   private static testMethod void UtilizationBilling_12() {

    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
  //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('ContractTerm',24);
  Date contractstartdate = Date.today();
  hm_inDataMap.put('StartDate',contractstartdate)
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
  //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
  hm_inDataMap.put('UnitPrice',30);
  hm_inDataMap.put('Quantity',10);
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding product
    hm_addOnValues.put('ProductName','ExactTarget - Pro Edition');
    hm_addOnValues.put('BillingFrequency',0);  
    
    // Optionally overwrite currncy
    System.debug('***AddonValues****'+hm_addOnValues);
    System.debug('***getPBE****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId***' +hm_inDataMap);
    
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
    
    System.debug('***OI****'+ out_Values1);
    
    hm_outDataMap.put (key1,out_Values1.get(key1));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
  ID orderitem = (Id)out_Values1.get(key1);
  
  OrderItem OI = [Select id,UnitPrice,Total_Amount__c,sfbase__OrderItemTermMonths__c,Quantity,sfbase__MonthlyUnitPrice__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:orderitem];
    
  Decimal unitprice =OI.UnitPrice;
    Decimal totalprice=OI.Total_Amount__c;
    Decimal qty = OI.Quantity;
    Decimal MU =OI.sfbase__MonthlyUnitPrice__c;
    Integer BF =OI.BillingFrequency;
  Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI.NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI.sfbill__BillFromDate__c;
    Date Enddate =OI.sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
  system.assert(OI.sfbill__BillFromDate__c ==contractstartdate);
  system.assert(OI.sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
  system.assert(OI.NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  system.assert(OI.totalprice ==qty*unitprice);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   sfbill__TransactionLine__c trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id and s.sfbill__OriginalOrderProduct__c =:orderitem];
              
  Decimal Txnqty = trxline.sfbill__Quantity__c;
  Decimal TxnUnitPrice =trxline.sfbill__UnitPrice__c;
    
     system.assert(TxnUnitPrice ==trxline.sfbill__UnitPrice__c);
     system.assert(Txnqty == trxline.sfbill__Quantity__c);
     system.assert(Txnqty*TxnUnitPrice == trxline.sfbill__TotalPrice__c);
   system.assert(NMU == trxline.sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline.sfbill__TransactionTerm__c);
   system.assert(Txnqty*TxnUnitPrice = trxline.sfbill__LineAmount__c);
   system.assert(Startdate == trxline.sfbill__StartDate__c);
   system.assert(Enddate == trxline.sfbill__EndDate__c);

      Test.StopTest();
}


   /******************TestCase 4a **************************/
   private static testMethod void UtilizationBilling_13() {
  
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;
    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',1);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','Super Messages');
    hm_addOnValues.put('BillingFrequency',0);
    hm_addOnValues.put('UnitPrice',30); 
  hm_addOnValues.put('Quantity',10);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.60);
  hm_addOnValues1.put(Quantity,100);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Predictive Product Recommendations for ExactTarget Email');
    hm_addOnValues1.put('BillingFrequency',0);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,sfbase__OrderItemTermMonths__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Integer Term1 = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  
  system.assert(unitprice1 ==0.60);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1/Term1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id,sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
  Decimal TxnUnitprice =trxline[0].sfbill__UnitPrice__c;
  Decimal Txnqty =trxline[0].sfbill__Quantity__c;
  
     system.assert(unitprice ==TxnUnitprice);
     system.assert(qty == Txnqty);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
     Decimal TxnUnitprice1 =trxline[1].sfbill__UnitPrice__c;
     Decimal Txnqty1 =trxline[2].sfbill__Quantity__c;
   
     system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == Txnqty1);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
     Test.StopTest();
  }
  
  // 4b
   /******************TestCase 4b **************************/
   private static testMethod void UtilizationBilling_14() {
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;

    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',6);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','Super Messages');
    hm_addOnValues.put('BillingFrequency',0);
    hm_addOnValues.put('UnitPrice',30); 
  hm_addOnValues.put('Quantity',10);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.60);
  hm_addOnValues1.put(Quantity,100);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Predictive Product Recommendations for ExactTarget Email');
    hm_addOnValues1.put('BillingFrequency',0);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,sfbase__OrderItemTermMonths__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Integer Term1 = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  
  system.assert(unitprice1 ==0.60);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1/Term1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id, s.sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
  Decimal TxnUnitprice =trxline[0].sfbill__UnitPrice__c;
  Decimal Txnqty =trxline[0].sfbill__Quantity__c;
  Decimal Txnterm =trxline[0].sfbill__TransactionTerm__c;
  
     system.assert(unitprice ==TxnUnitprice);
     system.assert(qty == Txnqty);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice/Txnterm == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   Decimal TxnUnitprice1 =trxline[1].sfbill__UnitPrice__c;
   Decimal Txnqty1 =trxline[1].sfbill__Quantity__c;
   Decimal Txnterm1 =trxline[1].sfbill__TransactionTerm__c;
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == Txnqty1);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice1/Txnterm1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
     Test.StopTest();
     
  }

  // 4c
   /******************TestCase 4c **************************/
   private static testMethod void UtilizationBilling_15() {
   
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;

    Test.StartTest();
    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',12);
    hm_inDataMap.put ('ContractTerm',12);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','Super Messages');
    hm_addOnValues.put('BillingFrequency',0);
    hm_addOnValues.put('UnitPrice',30); 
  hm_addOnValues.put('Quantity',10);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.60);
  hm_addOnValues1.put(Quantity,100);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Predictive Product Recommendations for ExactTarget Email');
    hm_addOnValues1.put('BillingFrequency',0);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,sfbase__OrderItemTermMonths__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Integer Term1 = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  
  system.assert(unitprice1 ==0.60);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1/Term1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id, s.sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
  Decimal TxnUnitprice =trxline[0].sfbill__UnitPrice__c;
  Decimal Txnqty =trxline[0].sfbill__Quantity__c;
  Decimal Txnterm =trxline[0].sfbill__TransactionTerm__c;
  
     system.assert(unitprice ==TxnUnitprice);
     system.assert(qty == Txnqty);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice/Txnterm == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   Decimal TxnUnitprice1 =trxline[1].sfbill__UnitPrice__c;
   Decimal Txnqty1 =trxline[1].sfbill__Quantity__c;
   Decimal Txnterm1 =trxline[1].sfbill__TransactionTerm__c;
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == Txnqty1);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice1/Txnterm1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
     Test.StoptTest();
     
  }
  
  
   /******************TestCase 4d **************************/
   private static testMethod void UtilizationBilling_16() {
   
    String Combination = 'AMER_A1';
    Map<String,Map<String,Object>> hm_currentTestdata = DataSetTestClass.getData(Combination);
    System.debug('Data Account***'+ hm_currentTestdata);
    Map<String, Object> hm_inDataMap = new Map <String,Object> ();
    Map<String, Object> hm_outDataMap = new Map <String,Object> ();

    // First create Account
    hm_inDataMap = hm_currentTestdata.get('Account');
    System.debug('***before creating Account : hm_inDataMap****'+ hm_inDataMap);
    Map<String,Object> out_Values = new Map<String,Object> ();
    Map<String,Object> out_Values1 = new Map<String,Object> ();
    
    String key = 'AccountId';
    String key1;
    String key2;

    Test.StartTest();

    out_Values = GenericSObject_Util.createSObject(hm_inDataMap, key, 'Account');
    System.debug('***out_Values****'+ out_Values);

    Object sAccountId = out_Values.get(key);
    hm_outDataMap.put (key,sAccountId );
    
    System.debug('***After creating Account hm_outDataMap****'+ hm_outDataMap);
    
   //Create Mockorg
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('MockOrg__c');
    
    // Add dependency
    hm_inDataMap.put ('Account__c',hm_outDataMap.get(key));

    System.debug('***before creating Org: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'OrgId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'MockOrg__c' );
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Org hm_outDataMap****'+ hm_outDataMap);
    
    // Get external id from mock org
    String sMockOrgId = (String)out_Values.get(key);
    MockOrg__c sExternald = [SELECT Name from MockOrg__c where Id =:sMockOrgId];
    Object oExternald = sExternald.Name;
    
    //Create Tenant
      
    hm_inDataMap = new Map <String,Object> ();
    
    hm_inDataMap = hm_currentTestdata.get('Tenant');

    hm_inDataMap.put ('ExternalId',oExternald);
    hm_inDataMap.put ('sfbase__AccountId__c',sAccountId );
    key = 'TenantId';
    
    System.debug('***before creating Tenant: hm_inDataMap****'+ hm_inDataMap);
    
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Tenant');
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Tenant hm_outDataMap****'+ hm_outDataMap);
    
    Object sTenantId = out_Values.get(key);
    
    //Create Accountlocation
    
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Apttus_Config2__AccountLocation__c');
    
    // Add dependency
   // hm_inDataMap.put (key,hm_outDataMap.get(key));
    key = 'SfdcTenant__c';
    hm_inDataMap.put (key,sTenantId);
   
    hm_inDataMap.put ('Apttus_Config2__AccountId__c',sAccountId );
    System.debug('***before creating Accountlocation: hm_inDataMap****'+ hm_inDataMap);
    
    key = 'TenantInfoId';
    System.debug('****hm_inDataMap***'+hm_inDataMap);
    System.debug('****Key***'+key);
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Apttus_Config2__AccountLocation__c');
    
    hm_outDataMap.put (key,out_Values.get(key));
    
    System.debug('***After creating Account location hm_outDataMap****'+ hm_outDataMap);
    
    // Create Contract
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Contract');
    
    // Add dependency
    hm_inDataMap.put ('AccountId',sAccountId);
    hm_inDataMap.put ('RenewalTerm',24);
    hm_inDataMap.put ('ContractTerm',6);
    Date contractstartdate = Date.today();
    hm_inDataMap.put('StartDate',contractstartdate);
    System.debug('***before creating Contract : hm_inDataMap****'+ hm_inDataMap);
    
    key = 'ContractId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Contract' );
    
    //Activate Contract
    OmTestUtils.activateContract(new Contract(id =(Id)out_Values.get(key)));
    hm_outDataMap.put (key,out_Values.get(key));
    ID Contractid = (Id)out_Values.get(key);
    
    System.debug('***After creating Contract hm_outDataMap****'+ hm_outDataMap);
    System.debug('***ContractID****'+ Contractid);
     
    // Create Order
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Order');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
    
    key = 'OrderId';
    out_Values = GenericSObject_Util.createSObject (hm_inDataMap, key, 'Order');
    ID Orderid = (Id)out_Values.get(key);
    hm_outDataMap.put (key,out_Values.get(key));
     System.debug('***Order id****'+ Orderid);
    System.debug('***After creating Order hm_outDataMap****'+ hm_outDataMap);
    
   
   // Create  OrderItem
    hm_inDataMap = new Map <String,Object> ();
    hm_inDataMap = hm_currentTestdata.get('Orderitem');
    
    // Add dependency
    hm_inDataMap.put (key,hm_outDataMap.get(key));
       
    Map <String,Object> hm_addOnValues = new Map <String,Object> ();
    Map <String,Object> hm_addOnValues1 = new Map <String,Object> ();
    // Move this to Basedata
    hm_addOnValues.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    
    // overriding First product
    hm_addOnValues.put('ProductName','Super Messages');
    hm_addOnValues.put('BillingFrequency',0);
    hm_addOnValues.put('UnitPrice',30); 
  hm_addOnValues.put('Quantity',10);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues1****'+hm_addOnValues);
    System.debug('***getPBE1****'+getPriceBookEntry(hm_addOnValues));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues)); 
    
    System.debug('****PricebookEntryId1***' +hm_inDataMap);
    
      
    key1 = 'OrderItemId';
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key1, 'OrderItem');
     System.debug('***OI****'+ out_Values1);
    hm_outDataMap.put (key1,out_Values1.get(key1));
   
    // overriding Second product
  hm_addOnValues1.put(UnitPrice,0.60);
  hm_addOnValues1.put(Quantity,100);
    hm_addOnValues1.put('PriceBookName','CPQ - Direct - Commercial - Marketing Cloud - WW - USD');
    hm_addOnValues1.put('ProductName','Predictive Product Recommendations for ExactTarget Email');
    hm_addOnValues1.put('BillingFrequency',0);
    
    // Optionally overwrite currncy
    System.debug('***AddonValues2****'+hm_addOnValues1);
    System.debug('***getPBE2****'+getPriceBookEntry(hm_addOnValues1));
     hm_inDataMap.put ('PricebookEntryId',getPriceBookEntry(hm_addOnValues1)); 
    
    System.debug('****PricebookEntryId2***' +hm_inDataMap);
   
    key2 = 'OrderItemId';
    
    out_Values1 = GenericSObject_Util.createSObject (hm_inDataMap, key2, 'OrderItem');
      
    hm_outDataMap.put (key2,out_Values1.get(key2));
    
    System.debug('***After creating Orderitem hm_outDataMap****'+ hm_outDataMap);
    
    System.debug('*** Activating Order ****'+ Orderid);
    OmTestUtils.activateOrder(new Order(id =Orderid));
    System.debug('*** Activated Order ****'+ Orderid);
    
    ID orderitem1 = (Id)out_Values1.get(key1);
    ID orderitem2 = (Id)out_Values1.get(key2);
    
    List<id> OrderItems = New List<id>();
    OrderItems.add(orderitem1);
    OrderItems.add(orderitem1);
  
    System.debug('***The size is****'+OrderItems);
    
  List<OrderItem> OI = [Select id,UnitPrice,Total_Amount__c,Quantity,sfbase__MonthlyUnitPrice__c,sfbase__OrderItemTermMonths__c,NormalizedMonthlyUnitPrice__c,sfbill__BillFromDate__c,sfbill__BillThroughDate__c from OrderItem where id=:OrderItems];
    
  system.debug('***Total OI****'+OI.Size());
    system.debug('***Total OI****'+OI[0].id);
    system.debug('***Total OI****'+OI[1].id);
  
    Decimal unitprice =OI[0].UnitPrice;
    Decimal totalprice=OI[0].Total_Amount__c;
    Decimal qty = OI[0].Quantity;
    Decimal MU =OI[0].sfbase__MonthlyUnitPrice__c;
  //  Integer BF =OI[0].BillingFrequency;
    Integer Term = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU =OI[0].NormalizedMonthlyUnitPrice__c;
    Date Startdate =OI[0].sfbill__BillFromDate__c;
    Date Enddate =OI[0].sfbill__BillThroughDate__c;
  
  Decimal unitprice1 =OI[1].UnitPrice;
    Decimal totalprice1=OI[1].Total_Amount__c;
    Decimal qty1 = OI[1].Quantity;
    Decimal MU1 =OI[1].sfbase__MonthlyUnitPrice__c;
  //  Integer BF1 =OI[1].BillingFrequency;
    Integer Term1 = OI.sfbase__OrderItemTermMonths__c;
    Decimal NMU1 =OI[1].NormalizedMonthlyUnitPrice__c;
    Date Startdate1 =OI[1].sfbill__BillFromDate__c;
    Date Enddate1 =OI[1].sfbill__BillThroughDate__c;
   
    system.assert(unitprice ==30.00);
    system.assert(OI[0].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[0].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[0].NormalizedMonthlyUnitPrice__c ==unitprice/Term);
  
  system.assert(unitprice1 ==0.60);
    system.assert(OI[1].sfbill__BillFromDate__c ==contractstartdate);
    system.assert(OI[1].sfbill__BillThroughDate__c ==contractstartdate.addMonths(1));
    system.assert(OI[1].NormalizedMonthlyUnitPrice__c ==unitprice1/Term1);
   
   //Run billing Process   
   storBillingProcess.invokeBillingProcessOnDemand(Contractid, 'testing@blackhole.salesforce.com');
   sfbill__Transaction__c trxnDetails = billProcessTestUtil.getTrx(orderId, 1);
   
   system.debug('TXN details'+trxnDetails);
   
   List<sfbill__TransactionLine__c> trxline = [Select s.Id, s.sfbill__transaction__c, s.sfbill__TransactionTerm__c, s.sfbill__EndDate__c,
                          s.sfbill__OriginalOrderProduct__c, sfbill__MonthlyUnitNetPrice__c, s.sfbill__Quantity__c,
                          s.sfbill__StartDate__c,
                          s.sfbill__TotalPrice__c,sfbill__UnitPrice__c from sfbill__TransactionLine__c s  where s.sfbill__transaction__c =:trxnDetails.id];
    
  Decimal TxnUnitprice =trxline[0].sfbill__UnitPrice__c;
  Decimal Txnqty =trxline[0].sfbill__Quantity__c;
  Decimal Txnterm =trxline[0].sfbill__TransactionTerm__c;
  
     system.assert(unitprice ==TxnUnitprice);
     system.assert(qty == Txnqty);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice/Txnterm == trxline[0].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[0].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice*Txnqty == trxline[0].sfbill__LineAmount__c);
     system.assert(Startdate == trxline[0].sfbill__StartDate__c);
     system.assert(Enddate == trxline[0].sfbill__EndDate__c);
   
   Decimal TxnUnitprice1 =trxline[1].sfbill__UnitPrice__c;
   Decimal Txnqty1 =trxline[1].sfbill__Quantity__c;
   Decimal Txnterm1 =trxline[1].sfbill__TransactionTerm__c;
   
   system.assert(unitprice1 ==trxline[1].sfbill__UnitPrice__c);
     system.assert(qty1 == Txnqty1);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__TotalPrice__c);
     system.assert(TxnUnitprice1/Txnterm1 == trxline[1].sfbill__MonthlyUnitNetPrice__c);
     system.assert(1 == trxline[1].sfbill__TransactionTerm__c);
     system.assert(TxnUnitprice1*Txnqty1 == trxline[1].sfbill__LineAmount__c);
     system.assert(Startdate1 == trxline[1].sfbill__StartDate__c);
     system.assert(Enddate1 == trxline[1].sfbill__EndDate__c);
     
    Test.StopTest();
  }
}
