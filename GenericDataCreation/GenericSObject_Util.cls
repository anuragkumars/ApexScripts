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

public class GenericSObject_Util {

   public static Map<String,Object> createSObject (Map<String,Object> p_InValues, String p_returnIdAsKey, String p_entityType)
   {    
    Map<String,Object> out_Values = new Map<String,Object> ();

    Schema.sObjectType myType = Schema.getGlobalDescribe().get(p_entityType); 
    System.Debug (myType );

    // p_entityType could be Account, Contract, Whatever, initialize oSObject here
    SObject oSObject = Database.query('SELECT Id FROM ' + p_entityType + ' LIMIT 1');
    oSObject.clear();
    
    System.Debug (oSObject.getSObjectType());
    System.Debug (oSObject);
    
    // Iterate over the key value pair
    for (String skey : p_InValues.keySet()) {
      
      // The "key" variable is also available inside the loop
      System.Debug ('key (' + skey + '), value (' + p_InValues.get(skey) + ')');
      
      oSObject.put (skey, p_InValues.get(skey) );
    }
  
    upsert oSObject;
   System.debug('***SobjectData***'+oSObject);
    System.Debug (oSObject.Id);
   
    // Put the key to return
    out_Values.put (p_returnIdAsKey ,oSObject.Id );
   
    return out_Values;

  }
  
  public static Map<String,Object> createSObject(Map<String,Object> p_InValues, String p_returnIdAsKey, String p_entityType, Map <String,Object> p_addOnValues) {
       
    // Iterate over the key value pair for add on
    if (p_addOnValues != null) {
     for (String skey : p_addOnValues.keySet()) {
       p_InValues.put (skey, p_addOnValues.get(skey) );
     }
    }

    return GenericSObject_Util.createSObject(p_InValues, p_returnIdAsKey, p_entityType);
  }
  
  public static Map<String,Object> queryOneRecordFromSObject (String p_query, Map<String,Object> p_mapOutValuesAs)
  {     
    Map<String,Object> out_Values = new Map<String,Object> ();
    
    SObject oSObject = Database.query(p_query);
    
    System.Debug (oSObject.getSObjectType());
    System.Debug (oSObject);
    
    // Iterate over the key value pair in the oSObject
    for (String skey : p_mapOutValuesAs.keySet()) {
      
      String sKeyMappedOutValue = (String)p_mapOutValuesAs.get(skey);

      String sFetchedValue = (String)oSObject.get (skey);
      
      // The "key" variable is also available inside the loop
      System.Debug ('Fetched key (' + skey + '), is expected to be returned as key (' + sKeyMappedOutValue + ') with value (' + sFetchedValue + ')');
      
      out_Values.put (sKeyMappedOutValue, sFetchedValue );
    }
  
    return out_Values;

  }
  
   public static List<Map<String,Object>> queryMultiRecordFromSObject (String p_query, Map<String,Object> p_mapOutValuesAs)
  {     
    List<Map<String,Object>> out_Values = new List<Map<String,Object>> ();
    
    SObject oSObject = Database.query(p_query);
    
    System.Debug (oSObject.getSObjectType());
    System.Debug (oSObject);
    
    Map<String,Object> oneOut_Value;
    
     // Iterate over the key value pair in the oSObject
     for (String skey : p_mapOutValuesAs.keySet()) {
      
      oneOut_Value = new Map<String,Object> ();
      
      String sKeyMappedOutValue = (String)p_mapOutValuesAs.get (skey);

      String sFetchedValue = (String)oSObject.get (skey);
      
      // The "key" variable is also available inside the loop
      System.Debug ('Fetched key (' + skey + '), is expected to be returned as key (' + sKeyMappedOutValue + ') with value (' + sFetchedValue + ')');
      
      oneOut_Value.put (sKeyMappedOutValue, sFetchedValue );
      
      out_Values.add (oneOut_Value);
     }
  
    
    return out_Values;

  }
  
}