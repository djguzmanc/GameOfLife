public void updateGrid( )
{
   if ( aliveCellsCopy.size( ) < 6 )
   {
      LinkedList<PVector> copy = new LinkedList<PVector>( );
      copy.addAll( aliveCells );
      aliveCellsCopy.add( copy );
   } else
   {
      aliveCellsCopy.remove( 0 );
      LinkedList<PVector> copy = new LinkedList<PVector>( );
      copy.addAll( aliveCells );
      aliveCellsCopy.add( copy );
   }
   for ( PVector vec : cellsToAdd )
   {
      aliveCells.add( vec );
      cellGrid[ ( int ) vec.y - 1 ][ ( int ) vec.x - 1 ].setState( "alive" );
      grid[ ( int ) vec.y ][ ( int ) vec.x ] = "A";
   }

   for ( PVector vec : cellsToKill )
   {
      aliveCells.remove( vec );
      cellGrid[ ( int ) vec.y - 1 ][ ( int ) vec.x - 1 ].setState( "used" );
      grid[ ( int ) vec.y ][ ( int ) vec.x ] = "D";
   }

   cellsToKill = new LinkedList<PVector>( );
   cellsToAdd = new LinkedList<PVector>( );
   cellsToCheck = new LinkedList<PVector>( );
}

public void checkAliveCells( )
{
   for ( PVector vec : aliveCells )
   {
      int neighDead = 0;
      for ( int i = 0; i < NEIGHBOORS.length; i++ )
      {
         PVector tmp = new PVector( vec.x, vec.y );
         PVector visit = tmp.add( NEIGHBOORS[ i ] );

         if ( grid[ ( int ) visit.y ][ ( int ) visit.x ].equals( "D" ) )
         {
            neighDead++;
            if ( !cellsToCheck.contains( visit ) )
               cellsToCheck.add( visit );
         }

         if ( grid[ ( int ) visit.y ][ ( int ) visit.x ].equals( "W" ) )
         {
            if ( visit.y == 0 )
               visit.y = MAX_ROW - 1;
            else if ( visit.y == MAX_ROW )
               visit.y = 1;

            if ( visit.x == 0 )
               visit.x = MAX_COL - 1;
            else if ( visit.x == MAX_COL )
               visit.x = 1;

            if ( grid[ ( int ) visit.y ][ ( int ) visit.x ].equals( "D" ) )
            {
               neighDead++;
               if ( !cellsToCheck.contains( visit ) )
                  cellsToCheck.add( visit );
            }
         }
      }

      int neighAlive = 8 - neighDead; 
      if ( !( neighAlive >= 2 && neighAlive <= 3 ) )
         cellsToKill.add( vec );
   }
}

public void checkNeighboors( )
{
   for ( PVector vec : cellsToCheck )
   {
      int neighAlive = 0;
      for ( int i = 0; i < NEIGHBOORS.length; i++ )
      {
         PVector tmp = new PVector( vec.x, vec.y );
         PVector visit = tmp.add( NEIGHBOORS[ i ] );

         if ( grid[ ( int ) visit.y ][ ( int ) visit.x ].equals( "A" ) )
            neighAlive++;

         if ( grid[ ( int ) visit.y ][ ( int ) visit.x ].equals( "W" ) )
         {
            if ( visit.y == 0 )
               visit.y = MAX_ROW - 1;
            else if ( visit.y == MAX_ROW )
               visit.y = 1;

            if ( visit.x == 0 )
               visit.x = MAX_COL - 1;
            else if ( visit.x == MAX_COL )
               visit.x = 1;

            if ( grid[ ( int ) visit.y ][ ( int ) visit.x ].equals( "A" ) )
               neighAlive++;
         }
      }

      if ( neighAlive == 3 )
         cellsToAdd.add( vec );
   }
}