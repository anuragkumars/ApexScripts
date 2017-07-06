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

public class DataSetTestClass
{

 public static map<String,list<Object>> billingAddress;
 public static map<String,Object> billingLanguageMap;
 public static map<String,Object> revOwnerCurrCodeVATMap;
 public static map<String,Object> BillingEmailMap;
 public static map<String,Object> PaymentTermMap;
 public static map<String,Object> AutoRenewalCode;
 public static map<String,Object> PaymentMethod;
 public static map<String,Object> ContractType;
 public static map<String,Object> ContractTerm;
 public static map<String,Object> BillingFrequency;
 public static map<String,Object> OrderPrebillDays;
 public static map<String,Object> Status;
 public static map<String,Object> Type;
 public static map<String,Object> OrderSubType;
 public static Integer count =2;
 public static  String PRICEBOOK_ID;
 public static map<String,Object> Pricebookmap;
 public static  String PRICEBOOK_ENTRY_ID;
 public static Decimal UnitPrice =1000.00;
// public static Integer BillingFrequency =1;
 
 
 public static Map<String,map<String,Object>> testDataMasterMap = new Map<String,map<String,Object>>();

 static{
 
        
    // Billing Address
    billingAddress= new map<string,list<Object>>();
    billingAddress.put('US-USD',new list<Object>{'US','94105','CA','San Francisco','1 Market'});
    billingAddress.put('CANADA',new list<Object>{'CA','T2C 2C8','Alberta','Calgary','4255 - 64 Avenue S.E.'});
    billingAddress.put('EU-USD',new list<Object>{'FR','83119','PA','Center Valley','Unit 3 Kingfisher House'});
    billingAddress.put('EU-EUR',new list<Object>{'IE','4','Dublin','Dublin','Unit 3 Kingfisher House'});
    billingAddress.put('EU-GBP',new list<Object>{'GB','NW5 2SB','','London','11 Apollo Studios, Charlton Kings Road'});
    billingAddress.put('EU-SEK',new list<Object>{'SE','','Stockholm','Stockholm','GrevTuregatan 30'});
    billingAddress.put('JP-JPY',new list<Object>{'JP','222-8530','Kanagawa Prefecture','Yokohama','Kohoku-ku Shin-Yokohama 3-2-3 NR sale Division NR planning'});
    billingAddress.put('ASIA PAC-AUD',new list<Object>{'AU','1230','NSW','Queen Victoria Building','PO Box Q1764 Queen Victoria Building NSW 1230'});
   // billingAddress.put('ASIA PAC-AUD',new list<Object>{'AU','NSW 2000','','Sydney','246 Walnut St'});


    revOwnerCurrCodeVATMap = new map<String,Object>();
    revOwnerCurrCodeVATMap.put('EU-USD','FR722273261');
    revOwnerCurrCodeVATMap.put('EU-EUR','GB722273261');
    revOwnerCurrCodeVATMap.put('EU-GBP','GB722273261');
    revOwnerCurrCodeVATMap.put('EU-SEK','SE5565850608');
    
    //Billing Language
    billingLanguageMap = new map<String, String>();

    billingLanguageMap .put('German','de');
    billingLanguageMap .put('Spanish','es');
    billingLanguageMap .put('Finnish','fi');
    billingLanguageMap .put('French','fr');
    billingLanguageMap .put('Italian','it');
    billingLanguageMap .put('Japaneese','ja');
    billingLanguageMap .put('Korean','ko');
    billingLanguageMap .put('Dutch','nl_NL');
    billingLanguageMap .put('Portugeese','pt_BR');
    billingLanguageMap .put('English','en_US');
    billingLanguageMap .put('Sweedish','sv');
    billingLanguageMap .put('Thai','th');
    billingLanguageMap .put('Chineese-Simplified','zh_CN');
    billingLanguageMap .put('Chineese-Traditional','zh_TW');
    
    //Billing Email 
    BillingEmailMap = new map<String,Object>();
    BillingEmailMap.put('Email', 'qatestingemail@salesforce.com');
    
    //Payment Term
    PaymentTermMap = new map<String,Object>();
    PaymentTermMap.put('PT1','Net30');
    PaymentTermMap.put('PT2','JP-Net 30 EOM');
    PaymentTermMap.put('PT3','Due upon receipt');
    PaymentTermMap.put('PT4','DD-Germany: Net 10');
    PaymentTermMap.put('PT5','Net 45');
    PaymentTermMap.put('PT6','Net 60');
    PaymentTermMap.put('PT7','JP-Net 60 EOM');
    
    //AutoRenewalCode
    AutoRenewalCode = new map<String,Object>();
    AutoRenewalCode.put('AR1','Yes');
    AutoRenewalCode.put('AR1','No');
    
    //Payment Method
    PaymentMethod = new map<String,Object>();
    PaymentMethod.put('PM1','Check');
    PaymentMethod.put('PM2','CreditCard');
    PaymentMethod.put('PM3','WireTransfer');
    PaymentMethod.put('PM4','DirectDebit');
    
    //ContractType
    ContractType = new map<String,Object>();
    ContractType.put('CT1','New');
    ContractType.put('CT2','New - Upgrade');
    ContractType.put('CT3','New - Downgrade');
    ContractType.put('CT4','Renewal');
    ContractType.put('CT5','Renewal - Upgrade');
    ContractType.put('CT6','Renewal - Downgrade');
    ContractType.put('CT7','Courtesy Contract');
    ContractType.put('CT8','QA Testing Only');
    ContractType.put('CT9','Non-profit');
    ContractType.put('CT10','Courtesy renewal');
    ContractType.put('CT11','Trial licenses');
    ContractType.put('CT12','Business Development');
    ContractType.put('CT13','Misc Fees');
    ContractType.put('CT14','Manual Sales Tax');
    ContractType.put('CT15','sforce');
    ContractType.put('CT16','Services');
    ContractType.put('CT17','Alliances');
    ContractType.put('CT18','Education');
    ContractType.put('CT19','Support');
    ContractType.put('CT20','JP 3rd Party Product');
    ContractType.put('CT21','Third Party Services');
    ContractType.put('CT22','Re-seller');
    ContractType.put('CT23','Partner Program');
    ContractType.put('CT24','Referral');
    ContractType.put('CT25','Affiliate');
    ContractType.put('CT26','VAR');
    
    //Contract Term
    ContractTerm = new map<String,Object>();
    ContractTerm.put('CTRM1','6');
    ContractTerm.put('CTRM1','12');
    ContractTerm.put('CTRM1','24');
    ContractTerm.put('CTRM1','36');
    
    // Billing Frequency
    BillingFrequency = new map<String,Object>();
    BillingFrequency.put('BF1','1');
    BillingFrequency.put('BF2','3');
    BillingFrequency.put('BF3','6');
    BillingFrequency.put('BF4','12');

    OrderPrebillDays = new map<String,Object>();
    OrderPrebillDays.put('OPD1','30');
    OrderPrebillDays.put('OPD2','60');
    // Order Status
    Status = new map<String,Object>();
    Status.put('OS1', 'Draft');
    Status.put('OS2', 'Activated');
    Status.put('OS3', '30 Day Warning Checked');
    Status.put('OS4', '5 Day Warning Checked');
    Status.put('OS5', '1 Day Warning Checked');
    Status.put('OS6', 'Provisioned');
    Status.put('OS7', 'Pending');
    Status.put('OS8', 'Canceled');
    Status.put('OS9', 'Expired');
    
    // Get Order Types
    Type = new map<String,Object>();
    Type.put('OT1','Add');
    Type.put('OT2','AppExchange Lead Programs');
    Type.put('OT3','Auto Renew');
    Type.put('OT4','Cancel');
    Type.put('OT5','Courtesy');
    Type.put('OT6','Courtesy Renew');
    Type.put('OT7','Initial');
    Type.put('OT8','License Change');
    Type.put('OT9','Order - Promo');
    Type.put('OT10','Org Transfer');
    Type.put('OT11','Renew');
    Type.put('OT12','Service Cancellation');
    Type.put('OT13','Service Change');
    Type.put('OT14','Service Non-Renewal');
    Type.put('OT15','Service Renewal');
    Type.put('OT16','Standard');
    Type.put('OT17','Upgrade');
    Type.put('OT18','Trial');
    
    //Order SubType
    OrderSubType = new map<String,Object>();
    OrderSubType.put('OST1','New');
    OrderSubType.put('OST2','Add');
    OrderSubType.put('OST3','License Transfer');
    OrderSubType.put('OST4','Swap');
    OrderSubType.put('OST5','Billing Adjustment');
    OrderSubType.put('OST6','Ramp');
    OrderSubType.put('OST7','List Price To Negotiated');
    OrderSubType.put('OST8','List Price To Negotiated-Add');
    OrderSubType.put('OST9','Swap-Add');
    OrderSubType.put('OST10','Renewal');
    OrderSubType.put('OST11','Renewal-Add');
    OrderSubType.put('OST12','Early Renewal');
    OrderSubType.put('OST13','Early Renewal-Add');
    OrderSubType.put('OST14','Early Renewal/Upgrade');
    OrderSubType.put('OST15','Expired');
    OrderSubType.put('OST16','Early Renewal/Upgrade-Add');
    OrderSubType.put('OST17','Renewal/Upgrade');
    OrderSubType.put('OST18','Renewal/Upgrade-Add');
    OrderSubType.put('OST19','Early Upgrade');
    OrderSubType.put('OST20','Early Upgrade-Add');
    OrderSubType.put('OST21','Upgrade-Add');
    OrderSubType.put('OST22','Upgrade');
    OrderSubType.put('OST23','Upgrade - Expired');
    OrderSubType.put('OST24','Non-commissionable');
    OrderSubType.put('OST25','Account Transfer');
    OrderSubType.put('OST26','Order Management Correction');
    OrderSubType.put('OST27','Trial');
       
   
   PRICEBOOK_ID= [Select id from Pricebook2 where Name='CPQ - Direct - Commercial - Marketing Cloud - WW - USD' limit 1].id;
   Pricebookmap = new map<String,Object>();
   Pricebookmap.put('Pricebookid',PRICEBOOK_ID);
     Integer p_Integer = 5;
     String RevenueOwner ='AMER';
     
     map<String,Object> TestDataTenantMap;
     map<String,Object> TestDataOrgMap;
     map<String,Object> TestDataAccountLocationMap;
     map<String,Object> TestAMERDataAccountMap;
     map<String,Object> TestEMEADataAccountMap;
     map<String,Object> TestAPACDataAccountMap;
     map<String,Object> TestCADataAccountMap;
     map<String,Object> TestJPDataAccountMap;
    
    //Mock org creation
    
     TestDataOrgMap = new map<String,Object>();
    // TestDataOrgMap.put('Test_MockOrgNum','ORG1');
     TestDataOrgMap.put('CrmLicenseCount__c',10);
     TestDataOrgMap.put('CurrencyIsoCode','USD');
     TestDataOrgMap.put('Edition__c','Enterprise');
    // TestDataOrgMap.put('Status__c ','Trial');
    // TestDataOrgMap.put('Action_Derive_ExternalId',1234);

     testDataMasterMap.put('Org',TestDataOrgMap);
     
     //Accountlocation creation
     TestDataAccountLocationMap = new map<String,Object>();
     TestDataAccountLocationMap.put('Apttus_Config2__TaxExempt__c','No');
     TestDataAccountLocationMap.put('Apttus_Config2__Type__c','ExactTarget');
     TestDataAccountLocationMap.put('CurrencyIsoCode','USD');
     TestDataAccountLocationMap.put('Name','TenantInfo');
     
     FulfillmentProvider__c Fp=[SELECT Id FROM FulfillmentProvider__c where name = 'ExactTarget' limit 1];
     TestDataAccountLocationMap.put('SfdcFulfillmentProvider__c',fp.id);
     TestDataAccountLocationMap.put('SfdcStatus__c','Complete');
     
     testDataMasterMap.put('AccountLocation',TestDataAccountLocationMap);
    //Tenant Creation 
   
     CloudServiceProvider cp=[SELECT Id FROM CloudServiceProvider where name = 'ExactTarget' limit 1];
    
    System.debug('***After getting CloudServiceProvider cp****'+ cp);
    TestDataTenantMap = new map<String,Object>();
        
    //hm_inDataMap = hm_currentTestdata.get('Tenant');
    TestDataTenantMap.put ('CloudServiceProviderId',cp.Id);
    TestDataTenantMap.put ('CurrencyIsoCode','USD');
    TestDataTenantMap.put ('Name','Tenant1');
    TestDataTenantMap.put ('ServiceProviderKey','ExactTarget');
    TestDataTenantMap.put ('TimeZoneSidKey','America/Los_Angeles');
    testDataMasterMap.put('Tenant',TestDataTenantMap);
     // AMER Account Creation   
        for(Integer i=1; i<p_Integer; i++){
        
            TestAMERDataAccountMap = new map<String,Object>();
            TestAMERDataAccountMap.put('Name','TestAMERAccount'+i); 
            
            TestAMERDataAccountMap.put ('NumberOfEmployees',10);
            TestAMERDataAccountMap.put ('BillingStreet',billingAddress.get('US-USD').get(4));
            TestAMERDataAccountMap.put ('BillingCity',billingAddress.get('US-USD').get(3));
            TestAMERDataAccountMap.put ('BillingState',billingAddress.get('US-USD').get(2));
            TestAMERDataAccountMap.put ('BillingPostalCode',billingAddress.get('US-USD').get(1));
            TestAMERDataAccountMap.put ('BillingCountry',billingAddress.get('US-USD').get(0));
            TestAMERDataAccountMap.put ('ShippingStreet',billingAddress.get('US-USD').get(4));
            TestAMERDataAccountMap.put ('ShippingCity',billingAddress.get('US-USD').get(3));
            TestAMERDataAccountMap.put ('ShippingState',billingAddress.get('US-USD').get(2));
            TestAMERDataAccountMap.put ('ShippingPostalCode',billingAddress.get('US-USD').get(1));
            TestAMERDataAccountMap.put ('ShippingCountry',billingAddress.get('US-USD').get(0));
        

            testDataMasterMap.put('AMER_A'+i,TestAMERDataAccountMap);
        }
        
        // EMEA Account Creation
        for(Integer i=1; i<p_Integer; i++){
        
            TestEMEADataAccountMap = new map<String,Object>();
            TestEMEADataAccountMap.put('Name','TestEMEAAccount'+i); 
            
            TestEMEADataAccountMap.put ('NumberOfEmployees',10);
            TestEMEADataAccountMap.put ('BillingStreet',billingAddress.get('EU-GBP').get(4));
            TestEMEADataAccountMap.put ('BillingCity',billingAddress.get('EU-GBP').get(3));
            TestEMEADataAccountMap.put ('BillingState',billingAddress.get('EU-GBP').get(2));
            TestEMEADataAccountMap.put ('BillingPostalCode',billingAddress.get('EU-GBP').get(1));
            TestEMEADataAccountMap.put ('BillingCountry',billingAddress.get('EU-GBP').get(0));
            TestEMEADataAccountMap.put ('ShippingStreet',billingAddress.get('EU-GBP').get(4));
            TestEMEADataAccountMap.put ('ShippingCity',billingAddress.get('EU-GBP').get(3));
            TestEMEADataAccountMap.put ('ShippingState',billingAddress.get('EU-GBP').get(2));
            TestEMEADataAccountMap.put ('ShippingPostalCode',billingAddress.get('EU-GBP').get(1));
            TestEMEADataAccountMap.put ('ShippingCountry',billingAddress.get('EU-GBP').get(0));
        

            testDataMasterMap.put('EMEA_A'+i,TestEMEADataAccountMap);
        }
        
        // APAC Account Creation
        for(Integer i=1; i<p_Integer; i++){
        
            TestAPACDataAccountMap = new map<String,Object>();
            TestAPACDataAccountMap.put('Name','TestAPACAccount'+i); 
            
            TestAPACDataAccountMap.put ('NumberOfEmployees',10);
            TestAPACDataAccountMap.put ('BillingStreet',billingAddress.get('ASIA PAC-AUD').get(4));
            TestAPACDataAccountMap.put ('BillingCity',billingAddress.get('ASIA PAC-AUD').get(3));
            TestAPACDataAccountMap.put ('BillingState',billingAddress.get('ASIA PAC-AUD').get(2));
            TestAPACDataAccountMap.put ('BillingPostalCode',billingAddress.get('ASIA PAC-AUD').get(1));
            TestAPACDataAccountMap.put ('BillingCountry',billingAddress.get('ASIA PAC-AUD').get(0));
            TestAPACDataAccountMap.put ('ShippingStreet',billingAddress.get('ASIA PAC-AUD').get(4));
            TestAPACDataAccountMap.put ('ShippingCity',billingAddress.get('ASIA PAC-AUD').get(3));
            TestAPACDataAccountMap.put ('ShippingState',billingAddress.get('ASIA PAC-AUD').get(2));
            TestAPACDataAccountMap.put ('ShippingPostalCode',billingAddress.get('ASIA PAC-AUD').get(1));
            TestAPACDataAccountMap.put ('ShippingCountry',billingAddress.get('ASIA PAC-AUD').get(0));
        

            testDataMasterMap.put('APAC_A'+i,TestAPACDataAccountMap);
        }
        
        // CANADA Account Creation
        for(Integer i=1; i<p_Integer; i++){
        
            TestCADataAccountMap = new map<String,Object>();
            TestCADataAccountMap.put('Name','TestCAAccount'+i); 
            
            TestCADataAccountMap.put ('NumberOfEmployees',10);
            TestCADataAccountMap.put ('BillingStreet',billingAddress.get('CANADA').get(4));
            TestCADataAccountMap.put ('BillingCity',billingAddress.get('CANADA').get(3));
            TestCADataAccountMap.put ('BillingState',billingAddress.get('CANADA').get(2));
            TestCADataAccountMap.put ('BillingPostalCode',billingAddress.get('CANADA').get(1));
            TestCADataAccountMap.put ('BillingCountry',billingAddress.get('CANADA').get(0));
            TestCADataAccountMap.put ('ShippingStreet',billingAddress.get('CANADA').get(4));
            TestCADataAccountMap.put ('ShippingCity',billingAddress.get('CANADA').get(3));
            TestCADataAccountMap.put ('ShippingState',billingAddress.get('CANADA').get(2));
            TestCADataAccountMap.put ('ShippingPostalCode',billingAddress.get('CANADA').get(1));
            TestCADataAccountMap.put ('ShippingCountry',billingAddress.get('CANADA').get(0));
        

            testDataMasterMap.put('CA_A'+i,TestCADataAccountMap);
        }
        
        // JAPAN Account Creation
        for(Integer i=1; i<p_Integer; i++){
        
            TestJPDataAccountMap = new map<String,Object>();
            TestJPDataAccountMap.put('Name','TestCAAccount'+i); 
            
            TestJPDataAccountMap.put ('NumberOfEmployees',10);
            TestJPDataAccountMap.put ('BillingStreet',billingAddress.get('JP-JPY').get(4));
            TestJPDataAccountMap.put ('BillingCity',billingAddress.get('JP-JPY').get(3));
            TestJPDataAccountMap.put ('BillingState',billingAddress.get('JP-JPY').get(2));
            TestJPDataAccountMap.put ('BillingPostalCode',billingAddress.get('JP-JPY').get(1));
            TestJPDataAccountMap.put ('BillingCountry',billingAddress.get('JP-JPY').get(0));
            TestJPDataAccountMap.put ('ShippingStreet',billingAddress.get('JP-JPY').get(4));
            TestJPDataAccountMap.put ('ShippingCity',billingAddress.get('JP-JPY').get(3));
            TestJPDataAccountMap.put ('ShippingState',billingAddress.get('JP-JPY').get(2));
            TestJPDataAccountMap.put ('ShippingPostalCode',billingAddress.get('JP-JPY').get(1));
            TestJPDataAccountMap.put ('ShippingCountry',billingAddress.get('JP-JPY').get(0));
        

            testDataMasterMap.put('JP_A'+i,TestJPDataAccountMap);
        }
        map<String,Object> TestContractAMERDataMap;
        map<String,Object> TestContractEMEADataMap;
        map<String,Object> TestContractAPACDataMap;
        map<String,Object> TestContractCADataMap;
        map<String,Object> TestContractJPDataMap;
        
        // AMER Contract Creation
        for(Integer i=1; i<p_Integer; i++){
        TestContractAMERDataMap =new map<String,Object>();
        Integer j;
        Integer k;
        Integer m;
        if(i==1)
        {
         j= i;
        String s = string.valueof(j);
         k =6;
        }
        else if(i==2 && m==6)
        {
          j=i+1;
         String s = string.valueof(j);
          k=m+6;
        }
        else if(i==3 && m==12)
        {
           j=i+3;
         String s = string.valueof(j);
           k=m+12;
        }
        else if(i==4 && m==24)
        {
         j=i+8;
        String s = string.valueof(j);
         k=m+12;
        }
        TestContractAMERDataMap .put('PaymentTerm',PaymentTermMap.get('PT1'));
        TestContractAMERDataMap .put('AutoRenewCode',AutoRenewalCode.get('AR1'));       
        TestContractAMERDataMap .put('sfbase__PaymentType__c',PaymentMethod.get('PM3'));
      //  TestContractAMERDataMap .put('OrderPrebillDays', OrderPrebillDays.get('OPD1'));
        TestContractAMERDataMap .put('OrderPrebillDays', 10);
        TestContractAMERDataMap .put('BillingLanguage',billingLanguageMap.get('English'));
        TestContractAMERDataMap .put('Pricebook2Id',Pricebookmap.get('Pricebookid'));
        TestContractAMERDataMap .put('sfbase__ContractType__c',ContractType.get('CT1'));
        TestContractAMERDataMap .put('billingstreet',billingAddress.get('US-USD').get(4));
        TestContractAMERDataMap .put('BillingCity',billingAddress.get('US-USD').get(3));
        TestContractAMERDataMap .put('BillingState',billingAddress.get('US-USD').get(2));
        TestContractAMERDataMap .put('BillingPostalCode',billingAddress.get('US-USD').get(1));
        TestContractAMERDataMap .put('BillingCountry',billingAddress.get('US-USD').get(0));
        TestContractAMERDataMap .put('Shippingstreet',billingAddress.get('US-USD').get(4));
        TestContractAMERDataMap .put('ShippingCity',billingAddress.get('US-USD').get(3));
        TestContractAMERDataMap .put('ShippingState',billingAddress.get('US-USD').get(2));
        TestContractAMERDataMap .put('ShippingPostalCode',billingAddress.get('US-USD').get(1));
        TestContractAMERDataMap .put('ShippingCountry',billingAddress.get('US-USD').get(0));
        TestContractAMERDataMap .put('sfbase__Customer_VAT_Number__c',(revOwnerCurrCodeVATMap.get('US-USD') != null) ? revOwnerCurrCodeVATMap.get('US-USD') : null);
        
        TestContractAMERDataMap.put('StartDate',getDate(2));
        //TestContractAMERDataMap .put('ContractTerm',ContractTerm.get('CTRM1'));
        TestContractAMERDataMap.put('ContractTerm',k);
        TestContractAMERDataMap.put('sfbase__Billing_Frequency__c','s');
        TestContractAMERDataMap.put('InvoiceDispatchMethod','Both');
        TestContractAMERDataMap.put('BillingEmail',BillingEmailMap.get('Email'));
        
        testDataMasterMap.put('AMER_C'+i,TestContractAMERDataMap );
        }
        
        // EMEA Contract Creation
        for(Integer i=1; i<p_Integer; i++){
        TestContractEMEADataMap =new map<String,Object>();
        Integer j;
        Integer k;
        Integer m;
        if(i==1)
        {
         j= i;
        String s = string.valueof(j);
         k =12;
        }
        else if(i==2 && m==12)
        {
          j=i+1;
         String s = string.valueof(j);
          k=m+12;
        }
        else if(i==3 && m==24)
        {
           j=i+3;
         String s = string.valueof(j);
           k=m+12;
        }
        else if(i==4 && m==36)
        {
         j=i+8;
        String s = string.valueof(j);
         k=m+12;
        }
        TestContractEMEADataMap .put('PaymentTerm',PaymentTermMap.get('PT1'));
        TestContractEMEADataMap .put('AutoRenewCode',AutoRenewalCode.get('AR1'));       
        TestContractEMEADataMap .put('sfbase__PaymentType__c',PaymentMethod.get('PM1'));
      //  TestContractEMEADataMap .put('OrderPrebillDays', OrderPrebillDays.get('OPD1'));
        TestContractEMEADataMap .put('OrderPrebillDays', 10);
        TestContractEMEADataMap .put('BillingLanguage',billingLanguageMap.get('English'));
        TestContractEMEADataMap .put('Pricebook2Id',Pricebookmap.get('Pricebookid'));
        TestContractEMEADataMap .put('sfbase__ContractType__c',ContractType.get('CT1'));
        TestContractEMEADataMap .put('billingstreet',billingAddress.get('EU-GBP').get(4));
        TestContractEMEADataMap .put('BillingCity',billingAddress.get('EU-GBP').get(3));
        TestContractEMEADataMap .put('BillingState',billingAddress.get('EU-GBP').get(2));
        TestContractEMEADataMap .put('BillingPostalCode',billingAddress.get('EU-GBP').get(1));
        TestContractEMEADataMap .put('BillingCountry',billingAddress.get('EU-GBP').get(0));
        TestContractEMEADataMap .put('Shippingstreet',billingAddress.get('EU-GBP').get(4));
        TestContractEMEADataMap .put('ShippingCity',billingAddress.get('EU-GBP').get(3));
        TestContractEMEADataMap .put('ShippingState',billingAddress.get('EU-GBP').get(2));
        TestContractEMEADataMap .put('ShippingPostalCode',billingAddress.get('EU-GBP').get(1));
        TestContractEMEADataMap .put('ShippingCountry',billingAddress.get('EU-GBP').get(0));
        TestContractEMEADataMap .put('sfbase__Customer_VAT_Number__c',(revOwnerCurrCodeVATMap.get('EU-GBP') != null) ? revOwnerCurrCodeVATMap.get('EU-GBP') : null);
        
        TestContractEMEADataMap.put('StartDate',getDate(2));
        //TestContractEMEADataMap .put('ContractTerm',ContractTerm.get('CTRM1'));
        TestContractEMEADataMap.put('ContractTerm',k);
        TestContractEMEADataMap.put('sfbase__Billing_Frequency__c','s');
        TestContractEMEADataMap.put('InvoiceDispatchMethod','Both');
        TestContractEMEADataMap.put('BillingEmail',BillingEmailMap.get('Email'));
        
        testDataMasterMap.put('EMEA_C'+i,TestContractEMEADataMap );
        }
        
        // APAC Contract Creation
        for(Integer i=1; i<p_Integer; i++){
        TestContractAPACDataMap =new map<String,Object>();
        Integer j;
        Integer k;
        Integer m;
        if(i==1)
        {
         j= i;
        String s = string.valueof(j);
         k =12;
        }
        else if(i==2 && m==12)
        {
          j=i+1;
         String s = string.valueof(j);
          k=m+12;
        }
        else if(i==3 && m==24)
        {
           j=i+3;
         String s = string.valueof(j);
           k=m+12;
        }
        else if(i==4 && m==36)
        {
         j=i+8;
        String s = string.valueof(j);
         k=m+12;
        }
        TestContractAPACDataMap .put('PaymentTerm',PaymentTermMap.get('PT1'));
        TestContractAPACDataMap .put('AutoRenewCode',AutoRenewalCode.get('AR1'));       
        TestContractAPACDataMap .put('sfbase__PaymentType__c',PaymentMethod.get('PM1'));
      //  TestContractAPACDataMap .put('OrderPrebillDays', OrderPrebillDays.get('OPD1'));
        TestContractAPACDataMap .put('OrderPrebillDays', 10);
        TestContractAPACDataMap .put('BillingLanguage',billingLanguageMap.get('English'));
        TestContractEMEADataMap .put('Pricebook2Id',Pricebookmap.get('Pricebookid'));
        TestContractAPACDataMap .put('sfbase__ContractType__c',ContractType.get('CT1'));
        TestContractAPACDataMap .put('billingstreet',billingAddress.get('ASIA PAC-AUD').get(4));
        TestContractAPACDataMap .put('BillingCity',billingAddress.get('ASIA PAC-AUD').get(3));
        TestContractAPACDataMap .put('BillingState',billingAddress.get('ASIA PAC-AUD').get(2));
        TestContractAPACDataMap .put('BillingPostalCode',billingAddress.get('ASIA PAC-AUD').get(1));
        TestContractAPACDataMap .put('BillingCountry',billingAddress.get('ASIA PAC-AUD').get(0));
        TestContractAPACDataMap .put('Shippingstreet',billingAddress.get('ASIA PAC-AUD').get(4));
        TestContractAPACDataMap .put('ShippingCity',billingAddress.get('ASIA PAC-AUD').get(3));
        TestContractAPACDataMap .put('ShippingState',billingAddress.get('ASIA PAC-AUD').get(2));
        TestContractAPACDataMap .put('ShippingPostalCode',billingAddress.get('ASIA PAC-AUD').get(1));
        TestContractAPACDataMap .put('ShippingCountry',billingAddress.get('ASIA PAC-AUD').get(0));
        TestContractAPACDataMap .put('sfbase__Customer_VAT_Number__c',(revOwnerCurrCodeVATMap.get('ASIA PAC-AUD') != null) ? revOwnerCurrCodeVATMap.get('ASIA PAC-AUD') : null);
        
        TestContractAPACDataMap.put('StartDate',getDate(2));
        //TestContractAPACDataMap .put('ContractTerm',ContractTerm.get('CTRM1'));
        TestContractAPACDataMap.put('ContractTerm',k);
        TestContractAPACDataMap.put('sfbase__Billing_Frequency__c','s');
        TestContractAPACDataMap.put('InvoiceDispatchMethod','Both');
        TestContractAPACDataMap.put('BillingEmail',BillingEmailMap.get('Email'));
        
        testDataMasterMap.put('APAC_C'+i,TestContractAPACDataMap );
        }
        
        // CANADA Contract Creation
        for(Integer i=1; i<p_Integer; i++){
        TestContractCADataMap =new map<String,Object>();
        Integer j;
        Integer k;
        Integer m;
        if(i==1)
        {
         j= i;
        String s = string.valueof(j);
         k =12;
        }
        else if(i==2 && m==12)
        {
          j=i+1;
         String s = string.valueof(j);
          k=m+12;
        }
        else if(i==3 && m==24)
        {
           j=i+3;
         String s = string.valueof(j);
           k=m+12;
        }
        else if(i==4 && m==36)
        {
         j=i+8;
        String s = string.valueof(j);
         k=m+12;
        }
        TestContractCADataMap.put('PaymentTerm',PaymentTermMap.get('PT1'));
        TestContractCADataMap.put('AutoRenewCode',AutoRenewalCode.get('AR1'));       
        TestContractCADataMap.put('sfbase__PaymentType__c',PaymentMethod.get('PM1'));
      //  TestContractCADataMap.put('OrderPrebillDays', OrderPrebillDays.get('OPD1'));
        TestContractCADataMap.put('OrderPrebillDays', 10);
        TestContractCADataMap.put('BillingLanguage',billingLanguageMap.get('English'));
        TestContractEMEADataMap .put('Pricebook2Id',Pricebookmap.get('Pricebookid'));
        TestContractCADataMap.put('sfbase__ContractType__c',ContractType.get('CT1'));
        TestContractCADataMap.put('billingstreet',billingAddress.get('CANADA').get(4));
        TestContractCADataMap.put('BillingCity',billingAddress.get('CANADA').get(3));
        TestContractCADataMap.put('BillingState',billingAddress.get('CANADA').get(2));
        TestContractCADataMap.put('BillingPostalCode',billingAddress.get('CANADA').get(1));
        TestContractCADataMap.put('BillingCountry',billingAddress.get('CANADA').get(0));
        TestContractCADataMap.put('Shippingstreet',billingAddress.get('CANADA').get(4));
        TestContractCADataMap.put('ShippingCity',billingAddress.get('CANADA').get(3));
        TestContractCADataMap.put('ShippingState',billingAddress.get('CANADA').get(2));
        TestContractCADataMap.put('ShippingPostalCode',billingAddress.get('CANADA').get(1));
        TestContractCADataMap.put('ShippingCountry',billingAddress.get('CANADA').get(0));
        TestContractCADataMap.put('sfbase__Customer_VAT_Number__c',(revOwnerCurrCodeVATMap.get('CANADA') != null) ? revOwnerCurrCodeVATMap.get('CANADA') : null);
        
        TestContractCADataMap.put('StartDate',getDate(2));
        //TestContractCADataMap.put('ContractTerm',ContractTerm.get('CTRM1'));
        TestContractCADataMap.put('ContractTerm',k);
        TestContractCADataMap.put('sfbase__Billing_Frequency__c','s');
        TestContractCADataMap.put('InvoiceDispatchMethod','Both');
        TestContractCADataMap.put('BillingEmail',BillingEmailMap.get('Email'));
        
        testDataMasterMap.put('CA_C'+i,TestContractCADataMap);
        }
        
        // JP Contract Creation
        for(Integer i=1; i<p_Integer; i++){
        TestContractJPDataMap =new map<String,Object>();
        Integer j;
        Integer k;
        Integer m;
        if(i==1)
        {
         j= i;
        String s = string.valueof(j);
         k =12;
        }
        else if(i==2 && m==12)
        {
          j=i+1;
         String s = string.valueof(j);
          k=m+12;
        }
        else if(i==3 && m==24)
        {
           j=i+3;
         String s = string.valueof(j);
           k=m+12;
        }
        else if(i==4 && m==36)
        {
         j=i+8;
        String s = string.valueof(j);
         k=m+12;
        }
        TestContractJPDataMap.put('PaymentTerm',PaymentTermMap.get('PT1'));
        TestContractJPDataMap.put('AutoRenewCode',AutoRenewalCode.get('AR1'));       
        TestContractJPDataMap.put('sfbase__PaymentType__c',PaymentMethod.get('PM1'));
      //  TestContractJPDataMap.put('OrderPrebillDays', OrderPrebillDays.get('OPD1'));
        TestContractJPDataMap.put('OrderPrebillDays', 10);
        TestContractJPDataMap.put('BillingLanguage',billingLanguageMap.get('English'));
        TestContractEMEADataMap .put('Pricebook2Id',Pricebookmap.get('Pricebookid'));
        TestContractJPDataMap.put('sfbase__ContractType__c',ContractType.get('CT1'));
        TestContractJPDataMap.put('billingstreet',billingAddress.get('JP-JPY').get(4));
        TestContractJPDataMap.put('BillingCity',billingAddress.get('JP-JPY').get(3));
        TestContractJPDataMap.put('BillingState',billingAddress.get('JP-JPY').get(2));
        TestContractJPDataMap.put('BillingPostalCode',billingAddress.get('JP-JPY').get(1));
        TestContractJPDataMap.put('BillingCountry',billingAddress.get('JP-JPY').get(0));
        TestContractJPDataMap.put('Shippingstreet',billingAddress.get('JP-JPY').get(4));
        TestContractJPDataMap.put('ShippingCity',billingAddress.get('JP-JPY').get(3));
        TestContractJPDataMap.put('ShippingState',billingAddress.get('JP-JPY').get(2));
        TestContractJPDataMap.put('ShippingPostalCode',billingAddress.get('JP-JPY').get(1));
        TestContractJPDataMap.put('ShippingCountry',billingAddress.get('JP-JPY').get(0));
        TestContractJPDataMap.put('sfbase__Customer_VAT_Number__c',(revOwnerCurrCodeVATMap.get('JP-JPY') != null) ? revOwnerCurrCodeVATMap.get('JP-JPY') : null);
        
        TestContractJPDataMap.put('StartDate',getDate(2));
        //TestContractJPDataMap.put('ContractTerm',ContractTerm.get('CTRM1'));
        TestContractJPDataMap.put('ContractTerm',k);
        TestContractJPDataMap.put('sfbase__Billing_Frequency__c','s');
        TestContractJPDataMap.put('InvoiceDispatchMethod','Both');
        TestContractJPDataMap.put('BillingEmail',BillingEmailMap.get('Email'));
        
        testDataMasterMap.put('JP_C'+i,TestContractJPDataMap);
        }
        
        //Order Creation
        Map<String,Object> TestDataOrderMap;
        
        for(Integer i=1; i<p_Integer; i++){
            TestDataOrderMap = new map<String,Object>();
           // TestDataOrderMap.put('ContractId','testContract.id');
             TestDataOrderMap.put('EffectiveDate',getDate(2));
             TestDataOrderMap.put('Status',Status.get('OS1'));
            //TestDataOrderMap.put(sfbase__OrderTermAps__c','orderTerm');
             TestDataOrderMap.put ('Type',Type.get('OT7'));
             TestDataOrderMap.put('Order_Sub_Type__c',OrderSubType.get('OST1'));
            // TestDataOrderMap.put('CustomerAuthorizedById',getContact());
             TestDataOrderMap.put('CustomerAuthorizedDate',getDate(0));
             TestDataOrderMap.put('sfbase__CustomerPORequired__c','Yes');
             TestDataOrderMap.put('PoNumber','1234');
             TestDataOrderMap.put('sfbase__POAmount__c',2000);
             testDataMasterMap.put('AMER_O'+i,TestDataOrderMap);
             testDataMasterMap.put('EMEA_O'+i,TestDataOrderMap);
             testDataMasterMap.put('APAC_O'+i,TestDataOrderMap);
             testDataMasterMap.put('CA_O'+i,TestDataOrderMap);
             testDataMasterMap.put('JP_O'+i,TestDataOrderMap);
        
         }
       //Creating Pricebook
      // PRICEBOOK_ID = OmTestUtils.getPricebookId('CPQ - Direct - Commercial - Ohana - WW - USD');
      // system.debug('**Pricebook id**'+PRICEBOOK_ID);
       PRICEBOOK_ENTRY_ID = [SELECT Id,Name,Pricebook2Id FROM PricebookEntry where Pricebook2Id =:PRICEBOOK_ID and name ='ExactTarget - Pro Edition' Limit 1].Id;
         system.debug('**Pricebook11 id**'+PRICEBOOK_ENTRY_ID);
          Map<String,Object> TestDataOrderLineMap;
        for(Integer i=1; i<p_Integer; i++){
            TestDataOrderLineMap = new map<String,Object>();
           
             TestDataOrderLineMap.put('PricebookEntryId',PRICEBOOK_ENTRY_ID);
             TestDataOrderLineMap.put('Quantity',1);
             TestDataOrderLineMap.put ('UnitPrice',1250.00);
            System.debug('**TestDataOrderLineMap**'+TestDataOrderLineMap);
             testDataMasterMap.put('AMER_OL'+i,TestDataOrderLineMap);
             testDataMasterMap.put('EMEA_OL'+i,TestDataOrderLineMap);
             testDataMasterMap.put('APAC_OL'+i,TestDataOrderLineMap);
             testDataMasterMap.put('CA_OL'+i,TestDataOrderLineMap);
             testDataMasterMap.put('JP_OL'+i,TestDataOrderLineMap);
        
         }
       
        }
        
         //Get date
        public Static Date getDate(Integer days){
            Date da = system.today().adddays(days);
           // String Genericdate = String.valueOf(da);
            return da;        
        }
        
        Public Static Map<String,Map<String,Object>> getData(String Combination){
        
        Map<String,Map<String,Object>> Finaldata = new Map<String,Map<String,Object>> ();
        if (combination.equals('AMER_A1'))
        {
        System.debug('***Combination***'+combination);
        Finaldata.put('Account', testDataMasterMap.get('AMER_A1'));
        Finaldata.put('MockOrg__c', testDataMasterMap.get('Org'));
        Finaldata.put('Tenant', testDataMasterMap.get('Tenant'));
        Finaldata.put('Apttus_Config2__AccountLocation__c', testDataMasterMap.get('AccountLocation'));
        Finaldata.put('Contract', testDataMasterMap.get('AMER_C1'));
        Finaldata.put('Order', testDataMasterMap.get('AMER_O1'));
        Finaldata.put('Orderitem', testDataMasterMap.get('AMER_OL1'));
        } else if (combination.equals('AMER_A2')) {
        Finaldata.put('Account', testDataMasterMap.get('AMER_A2'));
        Finaldata.put('Contract', testDataMasterMap.get('AMER_C2'));
        Finaldata.put('Order', testDataMasterMap.get('AMER_O2'));
        Finaldata.put('Orderitem', testDataMasterMap.get('AMER_OL2'));
        }
        if (combination.equals('EMEA_A1'))
        {
        System.debug('***Combination***'+combination);
        Finaldata.put('Account', testDataMasterMap.get('EMEA_A1'));
        Finaldata.put('Contract', testDataMasterMap.get('EMEA_C1'));
        Finaldata.put('Order', testDataMasterMap.get('EMEA_O1'));
        Finaldata.put('Orderitem', testDataMasterMap.get('EMEA_OL1'));
        } else if (combination.equals('EMEA_A2')) {
        Finaldata.put('Account', testDataMasterMap.get('EMEA_A2'));
        Finaldata.put('Contract', testDataMasterMap.get('EMEA_C2'));
        Finaldata.put('Order', testDataMasterMap.get('EMEA_O2'));
        Finaldata.put('Orderitem', testDataMasterMap.get('EMEA_OL2'));
        }
        
        if (combination.equals('APAC_A1'))
        {
        System.debug('***Combination***'+combination);
        Finaldata.put('Account', testDataMasterMap.get('APAC_A1'));
        Finaldata.put('Contract', testDataMasterMap.get('APAC_C1'));
        Finaldata.put('Order', testDataMasterMap.get('APAC_O1'));
        Finaldata.put('Orderitem', testDataMasterMap.get('APAC_OL1'));
        } else if (combination.equals('APAC_A2')) {
        Finaldata.put('Account', testDataMasterMap.get('APAC_A2'));
        Finaldata.put('Contract', testDataMasterMap.get('APAC_C2'));
        Finaldata.put('Order', testDataMasterMap.get('APAC_O2'));
        Finaldata.put('Orderitem', testDataMasterMap.get('APAC_OL2'));
        }
        
        if (combination.equals('CA_A1'))
        {
        System.debug('***Combination***'+combination);
        Finaldata.put('Account', testDataMasterMap.get('CA_A1'));
        Finaldata.put('Contract', testDataMasterMap.get('CA_C1'));
        Finaldata.put('Order', testDataMasterMap.get('CA_O1'));
        Finaldata.put('Orderitem', testDataMasterMap.get('CA_OL1'));
        } else if (combination.equals('CA_A2')) {
        Finaldata.put('Account', testDataMasterMap.get('CA_A2'));
        Finaldata.put('Contract', testDataMasterMap.get('CA_C2'));
        Finaldata.put('Order', testDataMasterMap.get('CA_O2'));
        Finaldata.put('Orderitem', testDataMasterMap.get('CA_OL2'));
        }
        
        if (combination.equals('JP_A1'))
        {
        System.debug('***Combination***'+combination);
        Finaldata.put('Account', testDataMasterMap.get('JP_A1'));
        Finaldata.put('Contract', testDataMasterMap.get('JP_C1'));
        Finaldata.put('Order', testDataMasterMap.get('JP_O1'));
        Finaldata.put('Orderitem', testDataMasterMap.get('JP_OL1'));
        } else if (combination.equals('JP_A2')) {
        Finaldata.put('Account', testDataMasterMap.get('JP_A2'));
        Finaldata.put('Contract', testDataMasterMap.get('JP_C2'));
        Finaldata.put('Order', testDataMasterMap.get('JP_O2'));
        Finaldata.put('Orderitem', testDataMasterMap.get('JP_OL2'));
        }
        system.debug('***Finaldata****'+Finaldata);
        return Finaldata ;
        
        }

       
}
