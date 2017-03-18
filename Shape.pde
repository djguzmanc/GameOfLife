class Shape
{
   String name;
   ArrayList<PVector> coordenates;

   public Shape( String name, ArrayList<PVector> coordenates )
   {
      this.name = name;
      this.coordenates = coordenates;
   }

   @Override
      public String toString( )
   {
      StringBuilder s = new StringBuilder( );

      s.append( name + ";" );

      for ( PVector vec : coordenates )
      {
         StringBuilder k = new StringBuilder( );
         char a[] = vec.toString( ).toCharArray( );
         for ( int i = 0; i < a.length; i++ )
            if ( a[ i ] != ' ' && a[ i ] != '[' && a[ i ] != ']' )
               k.append( a[ i ] );
         s.append( new String( k ) + "S" );
      }

      s.setLength( s.length( ) - 1 );

      return new String( s );
   }
}