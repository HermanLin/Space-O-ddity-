/*****************************************************
 * interface List -- subset of actual Java List interface
 * Specifies actions a List must be able to perform.
 * If present in local dir, will take precedence over Java's 
 * built-in List interface.
 *****************************************************/

public interface List { 

    public boolean add( Driver.Player.Shot x ); 

    public Driver.Player.Shot get( int i ); 

    public Driver.Player.Shot set( int i, Driver.Player.Shot x ); 

    public int size(); 
}