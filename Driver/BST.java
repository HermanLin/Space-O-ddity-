// Clyde "Thluffy" Sinclair
// APCS2 pd0
// HW35 -- searching, calc height, count leaves in BST
// 2017-05-05

/*****************************************************
 * class BST
 * Implementation of the BINARY SEARCH TREE abstract data type (ADT) 
 * A BST maDriver.Asteroid.Colliderains the invariant that, for any node N with value V, 
 * L<V && V<R, where L and R are node values in N's left and right
 * subtrees, respectively.
 * (Any value in a node's left subtree must be less than its value, 
 *  and any value in its right subtree must be greater.)
 * This BST only holds Driver.Asteroid.Colliders (its nodes have Driver.Asteroid.Collider cargo)
 *****************************************************/

public class BST 
{
  //instance variables / attributes of a BST:
  TreeNode _root;


  /*****************************************************
   * default constructor
   * Initializes an empty tree.
   *****************************************************/
  BST( ) {
    _root = null;
  }


  /*****************************************************
   * void insert( Driver.Asteroid.Collider ) 
   * Adds a new data element to the tree at appropriate location.
   *****************************************************/
  public void insert(Driver.Asteroid.Collider newVal ) 
  {
    TreeNode newNode = new TreeNode( newVal );

    if ( _root == null ) {
      _root = newNode;
      return;
    }
    insert( _root, newNode );
  }
  //recursive helper for insert(Driver.Asteroid.Collider)
  public void insert( TreeNode stRoot, TreeNode newNode ) {

    if ( newNode.getValue().focus1.x < stRoot.getValue().focus1.x ) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null )
        stRoot.setLeft( newNode );
      else //recurse down left subtree
      insert( stRoot.getLeft(), newNode );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null )
        stRoot.setRight( newNode );
      else //recurse down right subtree
      insert( stRoot.getRight(), newNode );
      return;
    }
  }


  /*****************************************************
   * TreeNode search(Collider)
   * returns poColliderer to node containing target,
   * or null if target not found
   *****************************************************/
  TreeNode search( Driver.Asteroid.Collider target )
  {
    return search( target, _root );
  }
  TreeNode search( Driver.Asteroid.Collider target, TreeNode currNode )
  {
    if ( currNode==null || currNode.getValue()==target )
      return currNode;
    else if ( target.focus1.x < currNode.getValue().focus1.x )
      return search( target, currNode.getLeft() );
    else if ( target.focus1.x > currNode.getValue().focus1.x )
      return search( target, currNode.getRight() );
    else
      return null; //to get past compiler
  }


  /*****************************************************
   * Collider height()
   * returns height of this tree (length of longest leaf-to-root path)
   * eg: a 1-node tree has height 1
   *****************************************************/
  public int height()
  {
    return height( _root );
  }
  //recursive helper for height()
  public int height( TreeNode currNode )
  {
    if ( currNode==null ) //Q: Why cannot use .equals() ?
      return 0;
    if ( isLeaf(currNode) )
      return 1;
    else //height is 1 for this node + height of deepest subtree
    return 1 + Math.max( height(currNode.getLeft()), 
      height(currNode.getRight()) );
  }




  /*****************************************************
   * Driver.Asteroid.Collider numLeaves()
   * returns number of leaves in tree
   *****************************************************/
  public int numLeaves()
  {
    return numLeaves( _root );
  }
  public int numLeaves( TreeNode currNode ) { 
    int foo = 0;
    if ( currNode == null )
      return 0;
    foo += numLeaves( currNode.getLeft() );
    if ( isLeaf(currNode) )
      foo++;
    foo += numLeaves( currNode.getRight() );
    return foo;
  }



  //~~~~~~~~~~~~~v~~MISC.HELPERS~~v~~~~~~~~~~~~~~~~~~~
  public boolean isLeaf( TreeNode node ) { 
    return ( node.getLeft() == null && node.getRight() == null );
  }
  //~~~~~~~~~~~~~^~~MISC.HELPERS~~^~~~~~~~~~~~~~~~~~~~


  //main method for testing
  public static void main( String[] args ) 
  {
  }//end main
}//end class