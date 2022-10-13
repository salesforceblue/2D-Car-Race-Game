/* 
    Author: Pankaj Agrahari
    Email: salesforceblue@gmail.com 
*/

global class race_wars {
    public static String racer_name{get; set;}
    public List<RaceWars__c> ls_top_racers{get{
        return [Select name, score__c from RaceWars__c order by score__c DESC Limit 10];
    } set;}
    public static String score{get; set;}    
    public static String racerId{get; set;}
    @remoteAction
      global static String save(String v_name){
        
          System.debug('Save() called');
       	
      RaceWars__c  rw = new RaceWars__c(name = v_name);
          
        try{
            System.debug('name ' + v_name);
            insert rw;
            System.debug('rw --- > ' + rw); 
            
            racerId = rw.id;
            racer_name =    v_name;
            
            System.debug('Racer id setting confirmation --- > ' + racerId);
            return rw.id;
        }
        catch(DmlException e){
            return 'failed' + e;
        }        
         
    }
    
    public static void updateScore(){
        System.debug('Score ' + score);
        System.debug('Racer ID ' + racerId);
        
        RaceWars__c racer = [Select id, score__c from RaceWars__C where id = :racerId];
        racer.Score__c = Long.valueOf(score);
        update racer;
        
        System.debug('Score Updated');
    }
}