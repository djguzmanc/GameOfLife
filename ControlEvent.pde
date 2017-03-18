void controlEvent( ControlEvent theEvent ) 
{
   if ( theEvent.getController( ) instanceof DropdownList ) 
   {
      int index = ( int ) savedShapes.getValue( );
      shapeStored = allShapes.get( index );
      
      shapeStoredForEdit = new ArrayList<PVector>( );
      for ( PVector vec : shapeStored ) 
         shapeStoredForEdit.add( new PVector( ( ( vec.x / 4 ) * 10 ) + 5, ( ( vec.y / 4 ) * 10 ) + 5, vec.z ) );

      shapeToggle.setText( "Tu figura" );

      shapeLabel.setText( "Figura seleccionada" ).setColorValue( color( 0, 255, 0 ) ).setPosition( X_LABEL + -4, 171 ).setFont( createFont( "Century Gothic", 10 ) );
      edit.setVisible( true );
      remove.setVisible( true );
      storeDone = false;
      savedShapes.open( );

      if ( !aliveCellsAW.isEmpty( ) )
      {
         storeDone = false;
         showButtonSignal( true );
      }
   }
}