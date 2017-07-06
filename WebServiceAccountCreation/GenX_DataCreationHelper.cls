/**
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
Author: Anurag
*/

global class GenX_DataCreationHelper {
  
   //Define an object in apex that is exposed in apex web service
   global class InMap {
       public Map<String, String> retainVal = new Map<String,String> ();
       public void put (String p_key, String p_value) {
           retainVal.put(p_key, p_value);
       }
       public String get (String p_key) {
           return retainVal.get(p_key);
       }
   }

   webservice static InMap createAccount (InMap p_inValues) {
       
       Account acct = new Account();
       acct.Name = (String) p_inValues.get('Name');
       acct.AccountNumber = (String) p_inValues.get('AccountNumber');
       insert acct;
       
       System.Debug ('Returning Id : ' + acct.id);

       p_inValues.retainVal.put('AccountId',acct.Id);
       return p_inValues;
  }

}
