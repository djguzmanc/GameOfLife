public class CellState
{
   private String state;
   private PVector position;

   public CellState( String state, PVector position )
   {
      this.state = state;
      this.position = position;
   }

   public String getState( )
   {
      return state;
   }

   public void setState( String state )
   {
      this.state = state;
   }

   public void paintCell( PApplet applet )
   {
      if ( state.equals( "dead" ) )
         applet.image( isDead, position.x, position.y );
      else if ( state.equals( "alive" ) )
         applet.image( isAlive, position.x, position.y );
      else if ( state.equals( "used" ) )
         applet.image( usedSpace, position.x, position.y );
   }
}