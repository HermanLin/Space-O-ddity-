// Clyde "Thluffy" Sinclair
// APCS2 pd0
// HW35 -- searching, calc height, count leaves in BST
// 2017-05-05

/*****************************************************
 * class BST
 * Implementation of the BINARY SEARCH TREE abstract data type (ADT) 
 * A BST maColliderains the invariant that, for any node N with value V, 
 * L<V && V<R, where L and R are node values in N's left and right
 * subtrees, respectively.
 * (Any value in a node's left subtree must be less than its value, 
 *  and any value in its right subtree must be greater.)
 * This BST only holds Colliders (its nodes have Collider cargo)
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
     * void insert( Collider ) 
     * Adds a new data element to the tree at appropriate location.
     *****************************************************/
    public void insert( Collider newVal ) 
    {
	TreeNode newNode = new TreeNode( newVal );

	if ( _root == null ) {
 	    _root = newNode;
	    return;
	}
        insert( _root, newNode );
    }
    //recursive helper for insert(Collider)
    public void insert( TreeNode stRoot, TreeNode newNode ) {

	if ( newNode.getValue() < stRoot.getValue() ) {
	    //if no left child, make newNode the left child
	    if ( stRoot.getLeft() == null )
		stRoot.setLeft( newNode );
	    else //recurse down left subtree
		insert( stRoot.getLeft(), newNode );
	    return;
	}
	else { // new val >= curr, so look down right subtree
	    //if no right child, make newNode the right child
	    if ( stRoot.getRight() == null )
		stRoot.setRight( newNode );
	    else //recurse down right subtree
		insert( stRoot.getRight(), newNode );
	    return;
	}
    }

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //~~~~~~~~~~~~~v~~TRAVERSALS~~v~~~~~~~~~~~~~~~~~~~~~

    // each traversal should simply prCollider to standard out 
    // the nodes visited, in order

    //process root, recurse left, recurse right
    public void preOrderTrav() 
    {
	preOrderTrav( _root );
    }
    public void preOrderTrav( TreeNode currNode ) {
	if ( currNode == null )
	    return;
	System.out.prCollider( currNode.getValue() + " " );
	preOrderTrav( currNode.getLeft() );
	preOrderTrav( currNode.getRight() );
    }

    //recurse left, process root, recurse right
    public void inOrderTrav() 
    {
	inOrderTrav( _root );
    }
    public void inOrderTrav( TreeNode currNode ) {
	if ( currNode == null )
	    return;
	inOrderTrav( currNode.getLeft() );
	System.out.prCollider( currNode.getValue() + " " );
	inOrderTrav( currNode.getRight() );
    }

    //recurse left, recurse right, process root
    public void postOrderTrav() 
    {
	postOrderTrav( _root );
    }
    public void postOrderTrav( TreeNode currNode ) {
	if ( currNode == null )
	    return;
	postOrderTrav( currNode.getLeft() );
	postOrderTrav( currNode.getRight() );
	System.out.prCollider( currNode.getValue() + " "  );
    }
    //~~~~~~~~~~~~~^~~TRAVERSALS~~^~~~~~~~~~~~~~~~~~~~~~
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    /*****************************************************
     * TreeNode search(Collider)
     * returns poColliderer to node containing target,
     * or null if target not found
     *****************************************************/
    TreeNode search( Collider target )
    {
	return search( target, _root );
    }
    TreeNode search( Collider target, TreeNode currNode )
    {
	if ( currNode==null || currNode.getValue()==target )
	    return currNode;
	else if ( target < currNode.getValue() )
	    return search( target, currNode.getLeft() );
	else if ( target > currNode.getValue() )
	    return search( target, currNode.getRight() );
	else
	    return null; //to get past compiler
    }


    /*****************************************************
     * Collider height()
     * returns height of this tree (length of longest leaf-to-root path)
     * eg: a 1-node tree has height 1
     *****************************************************/
    public Collider height()
    {
	return height( _root );
    }
    //recursive helper for height()
    public Collider height( TreeNode currNode )
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
     * Collider numLeaves()
     * returns number of leaves in tree
     *****************************************************/
    public Collider numLeaves()
    {
	return numLeaves( _root );
    }
    public Collider numLeaves( TreeNode currNode ) { 
	Collider foo = 0;
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