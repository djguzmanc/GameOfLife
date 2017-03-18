LinkedList<String> keys = new LinkedList<String>( );
LinkedList<String> keysAW = new LinkedList<String>( );
LinkedList<String> keysEW = new LinkedList<String>( );

void keyPressed( )
{
   if ( !keys.contains( Integer.toString( keyCode ) ) )
      keys.add( Integer.toString( keyCode ) );
}

void keyReleased( )
{
   if ( keys.contains( "17" ) && keys.contains( "90" ) && aliveCellsCopy.size( ) > 0 && !globalFlag )
   {      
      if ( gen > 0 )
         gen--;

      for ( PVector vec : aliveCells )
      {
         cellGrid[ ( int ) vec.y - 1 ][ ( int ) vec.x - 1 ].setState( "dead" );
         grid[ ( int ) vec.y ][ ( int ) vec.x ] = "D";
      }

      aliveCells = aliveCellsCopy.remove( aliveCellsCopy.size( ) - 1 );
      for ( PVector vec : aliveCells )
      {
         cellGrid[ ( int ) vec.y - 1 ][ ( int ) vec.x - 1 ].setState( "alive" );
         grid[ ( int ) vec.y ][ ( int ) vec.x ] = "A";
      }
   }
   keys.remove( Integer.toString( keyCode ) );
   if ( shapeToggle.getText( ).equals( "Tu figura" ) )
      if ( keyCode == RIGHT )
      {
         for ( PVector vec : shapeStored )
         {
            vec.x /= 4;
            vec.y /= 4;

            float x = vec.x;
            vec.x = vec.y;
            vec.y = x;

            vec.x = MAX_COL_AW - 2 - vec.x;

            vec.x *= 4;
            vec.y *= 4;
         }
      } else if ( keyCode == LEFT )
      {
         for ( PVector vec : shapeStored )
         {
            vec.x /= 4;
            vec.y /= 4;

            float x = vec.x;
            vec.x = vec.y;
            vec.y = x;

            vec.y = MAX_ROW_AW - 2 - vec.y;

            vec.x *= 4;
            vec.y *= 4;
         }
      }
}

public void windowKey( PApplet applet, GWinData windata, KeyEvent keyEvent ) 
{ 
   switch( keyEvent.getAction( ) )
   {
   case KeyEvent.PRESS:
      if ( !keysAW.contains( Integer.toString( applet.keyCode ) ) )
         keysAW.add( Integer.toString( applet.keyCode ) );
      break;
   case KeyEvent.RELEASE:
      if ( keysAW.contains( "17" ) && keysAW.contains( "90" ) && aliveCellsAWCopy.size( ) > 0 )
      {
         aliveCellsAW = aliveCellsAWCopy.remove( aliveCellsAWCopy.size( ) - 1 );
         if ( aliveCellsAW.isEmpty( ) )
         {
            saveDone = true;
            storeDone = true;
            showButtonSignal( false );
         }
      }
      keysAW.remove( Integer.toString( applet.keyCode ) );
      break;
   }
}

public void editWindowKey( PApplet applet, GWinData windata, KeyEvent keyEvent ) 
{
   switch( keyEvent.getAction( ) )
   {
   case KeyEvent.PRESS:
      if ( !keysEW.contains( Integer.toString( applet.keyCode ) ) )
         keysEW.add( Integer.toString( applet.keyCode ) );
      break;
   case KeyEvent.RELEASE:
      if ( keysEW.contains( "17" ) && keysEW.contains( "90" ) && aliveCellsEWCopy.size( ) > 0 )
      {
         aliveCellsEW = aliveCellsEWCopy.remove( aliveCellsEWCopy.size( ) - 1 );
         
         if ( !compareLists( shapeStoredForEdit, aliveCellsEW ) )
         {
            editDone = false;
            showEditButtonSignal( true );
         } else
         {
            editDone = true;
            showEditButtonSignal( false );
         }
      }
      keysEW.remove( Integer.toString( applet.keyCode ) );
      break;
   }
}