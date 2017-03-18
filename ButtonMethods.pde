PApplet app;
String message;
float xForLabel, yForLabel;

public void handleButtonEvents( GButton button, GEvent event )
{
   if ( button == run && event == GEvent.CLICKED )
   {
      globalFlag = !globalFlag;
      if ( globalFlag )
      {
         run.setText( "Pausa ◄" );
         runModeToggle.setText( "Paso a paso" );
         nextGen.setVisible( false );
      } else
         run.setText( "Iniciar ►" );
   } else if ( button == killAll && event == GEvent.CLICKED )
   {
      cleanGrid( );
      globalFlag = false;
      run.setText( "Iniciar ►" );
      gen = 0;
      aliveCells = new LinkedList<PVector>( );
   } else if ( button == auxiliarWindow && event == GEvent.CLICKED )
   {
      if ( newWindow == null )
         setupAuxiliarWindow( );
      else
         newWindow.setVisible( true );
   } else if ( button == shapeDone && event == GEvent.CLICKED )
   {
      newWindow.setVisible( false );
      aliveCellsAWCopy = new LinkedList<LinkedList<PVector>>( );
   } else if ( button == editDoneE && event == GEvent.CLICKED )
   {
      editWindowRef.setVisible( false );
      aliveCellsEWCopy = new LinkedList<LinkedList<PVector>>( );
   } else if ( button == clearShape && event == GEvent.CLICKED )
   {
      if ( clearShape.getText( ).equals( "Limpiar" ) )
      {
         if ( aliveCellsAWCopy.size( ) < 6 )
         {
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsAW );
            aliveCellsAWCopy.add( copy );
         } else
         {
            aliveCellsAWCopy.remove( 0 );
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsAW );
            aliveCellsAWCopy.add( copy );
         }
         aliveCellsAW = new LinkedList<PVector>( );
         clearShape.setText( "Llenar" );
         saveDone = true;
         storeDone = true;
         showButtonSignal( false );
      } else 
      {
         if ( aliveCellsAWCopy.size( ) < 6 )
         {
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsAW );
            aliveCellsAWCopy.add( copy );
         } else
         {
            aliveCellsAWCopy.remove( 0 );
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsAW );
            aliveCellsAWCopy.add( copy );
         }
         for ( int i = 0; i < MAX_ROW_AW - 1; i++ )
            for ( int j = 0; j < MAX_COL_AW - 1; j++ )
               aliveCellsAW.add( new PVector( j * 10 + 5, i * 10 + 5 ) );
         clearShape.setText( "Limpiar" );
         saveDone = false;
         storeDone = false;
         showButtonSignal( true );
      }
   } else if ( button == clearShapeE && event == GEvent.CLICKED )
   {
      if ( clearShapeE.getText( ).equals( "Limpiar" ) )
      {
         if ( aliveCellsEWCopy.size( ) < 6 )
         {
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsEW );
            aliveCellsEWCopy.add( copy );
         } else
         {
            aliveCellsEWCopy.remove( 0 );
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsEW );
            aliveCellsEWCopy.add( copy );
         }
         aliveCellsEW = new LinkedList<PVector>( );
         clearShapeE.setText( "Llenar" );
         editDone = true;
         showEditButtonSignal( false );
      } else 
      {
         if ( aliveCellsEWCopy.size( ) < 6 )
         {
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsEW );
            aliveCellsEWCopy.add( copy );
         } else
         {
            aliveCellsEWCopy.remove( 0 );
            LinkedList<PVector> copy = new LinkedList<PVector>( );
            copy.addAll( aliveCellsEW );
            aliveCellsEWCopy.add( copy );
         }
         for ( int i = 0; i < MAX_ROW_AW - 1; i++ )
            for ( int j = 0; j < MAX_COL_AW - 1; j++ )
               aliveCellsEW.add( new PVector( j * 10 + 5, i * 10 + 5 ) );
         clearShapeE.setText( "Limpiar" );
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
   } else if ( button == storeShape && event == GEvent.CLICKED )
   {
      if ( !aliveCellsAW.isEmpty( ) )
      {
         shapeLabel.setText( "Figura seleccionada" ).setColorValue( color( 0, 255, 0 ) ).setPosition( X_LABEL - 4, 171 ).setFont( createFont( "Century Gothic", 10 ) );
         shapeStored = new ArrayList<PVector>( );

         for ( int i = 0; i < aliveCellsAW.size( ); i++ )
            shapeStored.add( new PVector( ( ( aliveCellsAW.get( i ).x - 5 ) / 10 ) * 4, ( ( aliveCellsAW.get( i ).y - 5 ) / 10 ) * 4, i ) );

         storeDone = true;
         showButtonSignal( false );

         edit.setVisible( false );
         remove.setVisible( false );
         savedShapes.setLabel( "Selecciona una figura" );
         savedShapes.open( );
      }
   } else if ( button == shapeToggle && event == GEvent.CLICKED )
   {
      if ( shapeToggle.getText( ).equals( "Una célula" ) && !shapeLabel.getStringValue( ).equals( "Ninguna figura seleccionada" ) )
      {
         shapeToggle.setText( "Tu figura" );
      } else
      {
         shapeToggle.setText( "Una célula" );
      }
   } else if ( button == runModeToggle && event == GEvent.CLICKED )
   {
      if ( runModeToggle.getText( ).equals( "Paso a paso" ) )
      {
         runModeToggle.setText( "Modo contínuo" );
         nextGen.setVisible( true );
         globalFlag = false;
         run.setText( "Iniciar ►" );
      } else
      {
         runModeToggle.setText( "Paso a paso" );
         nextGen.setVisible( false );
      }
   } else if ( button == nextGen && event == GEvent.CLICKED )
   {
      checkAliveCells( );
      checkNeighboors( );   
      updateGrid( );
      gen++;
   } else if ( button == saveShape && event == GEvent.CLICKED )
   {
      if ( !aliveCellsAW.isEmpty( ) )
         showInputDialog( "Por favor ingresa un nombre para la figura..." );
   } else if ( button == ok && event == GEvent.CLICKED )
   {
      switch( dialogIndex )
      {
      case 2:

         if ( name.getText( ).equals( "" ) )
         {
            JOptionPane.showMessageDialog( null, "¡El campo no puede estar vacío!" );
            return;
         }

         for ( String s : allShapesString )
            if ( s.split( "[;]+" )[ 0 ].equals( name.getText( ) ) )
            {
               JOptionPane.showMessageDialog( null, "Ya existe una figura con ese nombre." );
               return;
            }

         ArrayList<PVector> tmp = new ArrayList<PVector>( );

         for ( int i = 0; i < aliveCellsAW.size( ); i++ )
            tmp.add( new PVector( ( ( aliveCellsAW.get( i ).x - 5 ) / 10 ) * 4, ( ( aliveCellsAW.get( i ).y - 5 ) / 10 ) * 4, i ) );

         Shape newShape = new Shape( name.getText( ), tmp );

         savedShapes.addItem( newShape.name, allShapes.size( ) - 1 );
         allShapes.add( tmp );

         allShapesString.add( newShape.toString( ) );

         saveData( );

         if ( storeDone )
         {
            savedShapes.setLabel( newShape.name );
            savedShapes.setValue( allShapes.size( ) - 1 );
            edit.setVisible( true );
            remove.setVisible( true );
         }

         name.setText( "" );

         saveDone = true;
         showButtonSignal( false );
         dialogWindow.setVisible( false );
         break;

      default:
         rulesWindow.setVisible( false );
         break;
      }
   } else if ( button == cancel && event == GEvent.CLICKED )
   {
      dialogWindow.setVisible( false );
   } else if ( button == rules && event == GEvent.CLICKED )
   {
      if ( rulesWindow != null )
         rulesWindow.setVisible( true );
      else
         setupRulesWindow( );
   } else if ( button == yes && event == GEvent.CLICKED )
   {
      confirmIndex = 1;
   } else if ( button == no && event == GEvent.CLICKED )
   {
      confirmIndex = 0;
   } else if ( button == edit && event == GEvent.CLICKED )
   {
      String examples[] = { "Pulsar", "Pentadecathlon", "The R-pentomino", "Gosper glider gun", "?", "Die hard", "Acorn" };

      for ( int i = 0; i < examples.length; i++)
         if ( savedShapes.getLabel( ).equals( examples[ i ] ) )
         {
            JOptionPane.showMessageDialog( null, "Esta figura no puede ser editada." );
            return;
         }
      if ( editWindowRef == null )
         setupEditWindow( );
      else
      {
         editWindowRef.setVisible( true );
         editName.setText( savedShapes.getLabel( ) );
      }

      clearShapeE.setText( "Limpiar" );

      aliveCellsEW = new LinkedList<PVector>( );

      for ( int i = 0; i < shapeStored.size( ); i++ )
         aliveCellsEW.add( new PVector( ( ( shapeStored.get( i ).x / 4 ) * 10 ) + 5, ( ( shapeStored.get( i ).y / 4 ) * 10 ) + 5, shapeStored.get( i ).z ) );
   } else if ( button == remove && event == GEvent.CLICKED )
   {
      String examples[] = { "Pulsar", "Pentadecathlon", "The R-pentomino", "Gosper glider gun", "?", "Die hard", "Acorn" };

      for ( int i = 0; i < examples.length; i++)
         if ( savedShapes.getLabel( ).equals( examples[ i ] ) )
         {
            JOptionPane.showMessageDialog( null, "Esta figura no puede ser removida." );
            return;
         }

      int answer = JOptionPane.showConfirmDialog( null, "¿Estás seguro de remover esta figura?" );

      switch( answer )
      {
      case JOptionPane.YES_OPTION:
         shapeStored = new ArrayList<PVector>( );
         allShapes.remove( ( int ) savedShapes.getValue( ) );
         allShapesString.remove( ( int ) savedShapes.getValue( ) );

         savedShapes.removeItem( savedShapes.getLabel( ) );
         savedShapes.setLabel( "Selecciona una figura" );

         saveData( );

         edit.setVisible( false );
         remove.setVisible( false );

         shapeToggle.setText( "Una célula" );
         shapeLabel.setText( "Ninguna figura seleccionada" ).setColorValue( color( 255, 0, 0 ) ).setPosition( X_LABEL - 15, 171 ).setFont( createFont( "Century Gothic", 9 ) );

         savedShapes.open( );
         break;

      case JOptionPane.NO_OPTION:

         break;
      case JOptionPane.CANCEL_OPTION:
         JOptionPane.showMessageDialog( null, "Operación cancelada.");
         break;
      }
   } else if ( button == saveChange && event == GEvent.CLICKED )
   {
      if ( !aliveCellsEW.isEmpty( ) && !editDone )
      {
         if ( editName.getText( ).equals( "" ) )
         {
            JOptionPane.showMessageDialog( null, "¡El campo no puede estar vacío!" );
            return;
         }

         for ( String s : allShapesString )
            if ( s.split( "[;]+" )[ 0 ].equals( editName.getText( ) ) )
            {
               if ( !s.split( "[;]+" )[ 0 ].equals( savedShapes.getLabel( ) ) )
               {
                  JOptionPane.showMessageDialog( null, "Ya existe una figura con ese nombre." );
                  return;
               }
            }

         int answer = JOptionPane.showConfirmDialog( null, "¿Estás seguro de modificar esta figura?" );

         switch( answer )
         {
         case JOptionPane.YES_OPTION:

            shapeStored = new ArrayList<PVector>( );
            shapeStoredForEdit = new ArrayList<PVector>( );

            for ( int i = 0; i < aliveCellsEW.size( ); i++ )
            {
               shapeStored.add( new PVector( ( ( aliveCellsEW.get( i ).x - 5 ) / 10 ) * 4, ( ( aliveCellsEW.get( i ).y - 5 ) / 10 ) * 4, i ) );
               shapeStoredForEdit.add( new PVector( ( ( aliveCellsEW.get( i ).x - 5 ) / 10 ) * 4, ( ( aliveCellsEW.get( i ).y - 5 ) / 10 ) * 4, i ) );
            }

            ArrayList<PVector> tmp = new ArrayList<PVector>( );
            tmp.addAll( shapeStored );

            allShapes.set( ( int ) savedShapes.getValue( ), tmp );

            float index = savedShapes.getValue( );

            Shape newShape = new Shape( editName.getText( ), tmp );

            allShapesString.set( ( int ) savedShapes.getValue( ), newShape.toString( ) );

            saveData( );

            savedShapes.remove( );
            savedShapes = cp5.addDropdownList( "Selecciona una figura" ).setPosition( X_LABEL - 10, 300 );
            savedShapes.setBackgroundColor( color( 8, 11, 116 ) );
            savedShapes.setItemHeight( 20 );
            savedShapes.setBarHeight( 15 );
            savedShapes.setColorBackground( color( 115, 117, 216 ) );
            savedShapes.setColorActive( color( 255, 255, 255 ) );
            savedShapes.setColorForeground( color( 227, 230, 255 ) );
            savedShapes.setColorLabel( color( 8, 11, 116 ) );
            savedShapes.setSize( 120, 140 );
            savedShapes.setColorValueLabel( color( 8, 11, 116 ) );
            savedShapes.setOpen( true );

            updateDropList( );

            savedShapes.setLabel( editName.getText( ) );
            savedShapes.setValue( index );

            savedShapes.open( );

            editDone = true;
            showEditButtonSignal( false );
            break;
         case JOptionPane.NO_OPTION:

            break;
         case JOptionPane.CANCEL_OPTION:
            JOptionPane.showMessageDialog( null, "Operación cancelada.");
            break;
         }
      }
   } else if ( button == ok2 && event == GEvent.CLICKED )
   {
      rulesWindow.setVisible( false );
   }
}

public void handleToggleButtonEvents( GImageToggleButton button, GEvent event ) 
{
}