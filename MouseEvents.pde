int xForShape, yForShape;
boolean saveDone = false, storeDone = false, editDone = true;
LinkedList<PVector> eliminated = new LinkedList<PVector>( );

void mouseClicked( )
{
   if ( shapeToggle.getText( ).equals( "Una célula" ) )
   {
      int rowToAdd = 1;
      int colToAdd = 1;
      int row = mouseY;
      int col = mouseX;

      if ( col < X_DISPLACEMENT )
         return;

      if ( row % 4 == 0 )
         row += 1;
      if ( col == GRID_SIZE_X )
         col -= 2;

      if ( col % 4 == 0 )
         col += 1;
      if ( row == GRID_SIZE_Y )
         row -= 2;

      int interval = 1;
      boolean tmpFlag = false;

      while ( !tmpFlag )
      {
         if ( row >= interval && row <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         rowToAdd++;
      }

      tmpFlag = false;
      interval = X_DISPLACEMENT + 1;

      while ( !tmpFlag )
      {
         if ( col >= interval && col <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         colToAdd++;
      }

      if ( aliveCells.remove( new PVector( colToAdd, rowToAdd ) ) )
      {
         aliveCells.add( new PVector( colToAdd, rowToAdd ) );
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
         aliveCells.remove( new PVector( colToAdd, rowToAdd ) );
         grid[ rowToAdd ][ colToAdd ] = "D";
         cellGrid[ rowToAdd - 1 ][ colToAdd - 1 ].setState( "used" );
         return;
      }
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
      addCell( colToAdd, rowToAdd );
   } else if ( mouseX >= X_DISPLACEMENT && mouseButton == LEFT )
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
      for ( PVector vec : shapeStored )
         addCell( ( int )( ( ( xForShape - X_DISPLACEMENT + vec.x ) - 2 ) / 4 ) + 1, ( int )( ( ( yForShape + vec.y ) - 2 ) / 4 ) + 1 );
   } else if ( mouseX >= X_DISPLACEMENT && mouseButton == RIGHT )
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
      for ( PVector vec : shapeStored )
         removeCell( ( int )( ( ( xForShape - X_DISPLACEMENT + vec.x ) - 2 ) / 4 ) + 1, ( int )( ( ( yForShape + vec.y ) - 2 ) / 4 ) + 1 );
   }
}

void mouseMoved( )
{
   if ( shapeToggle.getText( ).equals( "Tu figura" ) )
   {
      int rowToAdd = 1;
      int colToAdd = 1;
      int row = mouseY;
      int col = mouseX;

      if ( col < X_DISPLACEMENT )
         return;

      if ( row % 4 == 0 )
         row += 1;
      if ( col % 4 == 0 )
         col += 1;
      if ( col == GRID_SIZE_X )
         col -= 2;
      if ( row == GRID_SIZE_Y )
         row -= 2;

      int interval = 1;
      boolean tmpFlag = false;

      while ( !tmpFlag )
      {
         if ( row >= interval && row <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         rowToAdd++;
      }

      tmpFlag = false;
      interval = X_DISPLACEMENT + 1;

      while ( !tmpFlag )
      {
         if ( col >= interval && col <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         colToAdd++;
      }

      xForShape = ( colToAdd + 3 ) * 4 + 2 + X_DISPLACEMENT;
      yForShape = ( rowToAdd + 2 ) * 4 + 2;
   }
}

void mouseDragged( )
{
   if ( mouseButton == LEFT && !shapeToggle.getText( ).equals( "Tu figura" ) )
   {
      int rowToAdd = 1;
      int colToAdd = 1;
      int row = mouseY;
      int col = mouseX;

      if ( col < 130 )
         return;

      if ( row < 0 )
         row = 1;
      else if ( col > GRID_SIZE_X )
         col = GRID_SIZE_X - 2;
      if ( col < X_DISPLACEMENT )
         col = X_DISPLACEMENT + 1;
      else if ( row > GRID_SIZE_Y )
         row = GRID_SIZE_Y - 2;

      if ( row % 4 == 0 )
         row += 1;
      if ( col % 4 == 0 )
         col += 1;
      if ( col == GRID_SIZE_X )
         col -= 2;
      if ( row == GRID_SIZE_Y )
         row -= 2;

      int interval = 1;
      boolean tmpFlag = false;

      while ( !tmpFlag )
      {
         if ( row >= interval && row <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         rowToAdd++;
      }

      tmpFlag = false;
      interval = X_DISPLACEMENT + 1;

      while ( !tmpFlag )
      {
         if ( col >= interval && col <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         colToAdd++;
      }

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

      addCell( colToAdd, rowToAdd );

      addCell( colToAdd, rowToAdd - 1 );
      addCell( colToAdd, rowToAdd - 2 );
      addCell( colToAdd, rowToAdd + 1 );
      addCell( colToAdd, rowToAdd + 2 );

      addCell( colToAdd + 1, rowToAdd - 1 );
      addCell( colToAdd + 1, rowToAdd );
      addCell( colToAdd + 1, rowToAdd + 1 );

      addCell( colToAdd - 1, rowToAdd - 1 );
      addCell( colToAdd - 1, rowToAdd );
      addCell( colToAdd - 1, rowToAdd + 1 );

      addCell( colToAdd + 2, rowToAdd );

      addCell( colToAdd - 2, rowToAdd );
   } else if ( mouseButton == RIGHT && !shapeToggle.getText( ).equals( "Tu figura" ) )
   {
      int rowToAdd = 1;
      int colToAdd = 1;
      int row = mouseY;
      int col = mouseX;

      if ( row < 0 )
         row = 1;
      else if ( col > GRID_SIZE_X )
         col = GRID_SIZE_X - 2;
      if ( col < X_DISPLACEMENT )
         col = X_DISPLACEMENT + 1;
      else if ( row > GRID_SIZE_Y )
         row = GRID_SIZE_Y - 2;

      if ( row % 4 == 0 )
         row += 1;
      if ( col % 4 == 0 )
         col += 1;
      if ( col == GRID_SIZE_X )
         col -= 2;
      if ( row == GRID_SIZE_Y )
         row -= 2;

      int interval = 1;
      boolean tmpFlag = false;

      while ( !tmpFlag )
      {
         if ( row >= interval && row <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         rowToAdd++;
      }

      tmpFlag = false;
      interval = X_DISPLACEMENT + 1;

      while ( !tmpFlag )
      {
         if ( col >= interval && col <= interval + 2 )
         {
            tmpFlag = true;
            break;
         }

         interval += 4;
         colToAdd++;
      }

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

      removeCell( colToAdd, rowToAdd );

      removeCell( colToAdd, rowToAdd - 1 );
      removeCell( colToAdd, rowToAdd - 2 );
      removeCell( colToAdd, rowToAdd + 1 );
      removeCell( colToAdd, rowToAdd + 2 );

      removeCell( colToAdd + 1, rowToAdd - 1 );
      removeCell( colToAdd + 1, rowToAdd );
      removeCell( colToAdd + 1, rowToAdd + 1 );

      removeCell( colToAdd - 1, rowToAdd - 1 );
      removeCell( colToAdd - 1, rowToAdd );
      removeCell( colToAdd - 1, rowToAdd + 1 );

      removeCell( colToAdd + 2, rowToAdd );

      removeCell( colToAdd - 2, rowToAdd );
   }
}

public void windowMouse( PApplet applet, GWinData data, MouseEvent event ) 
{
   switch( event.getAction( ) )
   {
   case MouseEvent.DRAG:
      if ( applet.mouseButton == LEFT )
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW || col < 0 )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW || row < 0 )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }
         if ( !aliveCellsAW.contains( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
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
            aliveCellsAW.add( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
            clearShape.setText( "Limpiar" );
            saveDone = false;
            storeDone = false;
            showButtonSignal( true );
         }
      } else if ( applet.mouseButton == RIGHT )
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW || col < 0 )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW || row < 0 )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }

         if ( aliveCellsAW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
         {
            saveDone = false;
            storeDone = false;
            showButtonSignal( true );
            aliveCellsAW.add( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
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
            aliveCellsAW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
            if ( aliveCellsAW.isEmpty( ) )
            {
               saveDone = true;
               storeDone = true;
               showButtonSignal( false );
            }
            if ( aliveCellsAW.isEmpty( ) )
               clearShape.setText( "Llenar" );
         }
      }
      break;

   case MouseEvent.CLICK:
      if ( btnToggle0.getState( ) == 0 ) 
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }

         if ( !aliveCellsAW.contains( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
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
            aliveCellsAW.add( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
            clearShape.setText( "Limpiar" );
            saveDone = false;
            storeDone = false;
            showButtonSignal( true );
         } else
         {
            if ( aliveCellsAW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
            {
               aliveCellsAW.add( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
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
               aliveCellsAW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
               saveDone = false;
               storeDone = false;
               showButtonSignal( true );
               if ( aliveCellsAW.isEmpty( ) )
               {
                  saveDone = true;
                  storeDone = true;
                  showButtonSignal( false );
               }
               if ( aliveCellsAW.isEmpty( ) )
                  clearShape.setText( "Llenar" );
            }
         }
      } else 
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }
         if ( applet.mouseButton == LEFT )   
         {
            if ( !aliveCellsAW.contains( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
            {
               PVector clicked = new PVector( colToAdd, rowToAdd );
               ArrayList<PVector> toCheck = new ArrayList<PVector>( );
               toCheck.add( clicked );

               PVector here = toCheck.remove( 0 );

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

               if ( !aliveCellsAW.contains( new PVector( here.x * 10 + 5, here.y * 10 + 5 ) ) )
                  aliveCellsAW.add( new PVector( here.x * 10 + 5, here.y * 10 + 5 ) );

               while ( here != null )
               {
                  for ( int i = 0; i < NEIGHBOORS2.length; i++ )
                  {
                     PVector tmp = new PVector( here.x, here.y );
                     PVector visit = tmp.add( NEIGHBOORS2[ i ] );

                     if ( !aliveCellsAW.contains( new PVector( visit.x * 10 + 5, visit.y * 10 + 5 ) ) && visit.x < MAX_COL_AW - 1 && visit.x > -1 && visit.y < MAX_ROW_AW - 1 && visit.y > -1 )
                     {
                        aliveCellsAW.add( new PVector( visit.x * 10 + 5, visit.y * 10 + 5 ) );
                        toCheck.add( new PVector( visit.x, visit.y ) );
                     }
                  }
                  if ( toCheck.size( ) != 0 )
                     here = toCheck.remove( 0 );
                  else
                     here = null;
               }

               clearShape.setText( "Limpiar" );
               saveDone = false;
               storeDone = false;
               showButtonSignal( true );
            }
         } else if ( applet.mouseButton == RIGHT )
         {
            if ( aliveCellsAW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
            {
               PVector clicked = new PVector( colToAdd, rowToAdd );
               ArrayList<PVector> toCheck = new ArrayList<PVector>( );
               toCheck.add( clicked );

               PVector here = toCheck.remove( 0 );
               aliveCellsAW.add( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
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
               aliveCellsAW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );

               while ( here != null )
               {
                  for ( int i = 0; i < NEIGHBOORS2.length; i++ )
                  {
                     PVector tmp = new PVector( here.x, here.y );
                     PVector visit = tmp.add( NEIGHBOORS2[ i ] );

                     if ( aliveCellsAW.remove( new PVector( visit.x * 10 + 5, visit.y * 10 + 5 ) ) && visit.x < MAX_COL_AW - 1 && visit.x > -1 && visit.y < MAX_ROW_AW - 1 && visit.y > -1 )
                        toCheck.add( new PVector( visit.x, visit.y ) );
                  }
                  if ( toCheck.size( ) != 0 )
                     here = toCheck.remove( 0 );
                  else
                     here = null;
               }
               if ( aliveCellsAW.isEmpty( ) )
               {
                  clearShape.setText( "Llenar" );
                  saveDone = true;
                  storeDone = true;
                  showButtonSignal( false );
               }
            }
         }
         break;
      }
   }
}

public void editWindowMouse( PApplet applet, GWinData data, MouseEvent event ) 
{
   switch( event.getAction( ) )
   {
   case MouseEvent.DRAG:
      if ( applet.mouseButton == LEFT )
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW || col < 0 )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW || row < 0 )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }

         if ( !aliveCellsEW.contains( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
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

            PVector k = new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 );

            for ( int i = 0; i < eliminated.size( ); i++ )
               if ( eliminated.get( i ).equals( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
               {
                  k = eliminated.get( i );
                  eliminated.remove( i );
                  break;
               }

            aliveCellsEW.add( k );

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
      } else if ( applet.mouseButton == RIGHT )
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW || col < 0 )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW || row < 0 )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }

         int index = -1;
         for ( int i = 0; i < aliveCellsEW.size( ); i++ )
            if ( aliveCellsEW.get( i ).equals( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) ) )
            {
               index = i;
               break;
            } 

         if ( index != -1 )
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
            aliveCellsEW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );
            PVector elim = new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5, index );
            eliminated.add( elim );
            if ( !compareLists( shapeStoredForEdit, aliveCellsEW ) )
            {
               editDone = false;
               showEditButtonSignal( true );
            } else
            {
               editDone = true;
               showEditButtonSignal( false );
            }
            if ( aliveCellsEW.isEmpty( ) )
            {
               editDone = true;
               showEditButtonSignal( false );
               clearShapeE.setText( "Llenar" );
            }
         }
      }

      break;

   case MouseEvent.CLICK:
      if ( btnToggle1.getState( ) == 0 ) 
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }

         int index = contains( aliveCellsEW, new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );

         if ( index == -1 )
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

            PVector k = new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5, aliveCellsEW.size( ) );

            int elimIndex = contains( eliminated, k );

            if ( elimIndex != -1 )
            {
               k = eliminated.get( elimIndex );
               eliminated.remove( elimIndex );
            }

            aliveCellsEW.add( k );

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

            aliveCellsEW.remove( index );
            PVector elim = new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5, index );
            eliminated.add( elim );
            if ( !compareLists( shapeStoredForEdit, aliveCellsEW ) )
            {
               editDone = false;
               showEditButtonSignal( true );
            } else
            {
               editDone = true;
               showEditButtonSignal( false );
            }
            if ( aliveCellsEW.isEmpty( ) )
            {
               editDone = true;
               showEditButtonSignal( false );
            }
            if ( aliveCellsEW.isEmpty( ) )
               clearShapeE.setText( "Llenar" );
         }
      } else 
      {
         int rowToAdd = 0;
         int colToAdd = 0;
         int row = applet.mouseY;
         int col = applet.mouseX;

         if ( row % 10 == 0 )
            row += 1;
         if ( col % 10 == 0 )
            col += 1;

         if ( col == GRID_SIZE_X_AW )
            col = GRID_SIZE_X_AW - 1;
         else if ( col > GRID_SIZE_X_AW )
            return;

         if ( row == GRID_SIZE_Y_AW )
            row = GRID_SIZE_Y_AW - 1;
         else if ( row > GRID_SIZE_Y_AW )
            return;

         int interval = 1;
         boolean tmpFlag = false;

         while ( !tmpFlag )
         {
            if ( row >= interval && row <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            rowToAdd++;
         }

         tmpFlag = false;
         interval = 1;

         while ( !tmpFlag )
         {
            if ( col >= interval && col <= interval + 8 )
            {
               tmpFlag = true;
               break;
            }

            interval += 10;
            colToAdd++;
         }
         if ( applet.mouseButton == LEFT )   
         {
            int index = contains( aliveCellsEW, new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );

            if ( index == -1 )
            {
               PVector clicked = new PVector( colToAdd, rowToAdd );
               ArrayList<PVector> toCheck = new ArrayList<PVector>( );
               toCheck.add( clicked );

               PVector here = toCheck.remove( 0 );

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

               PVector k = new PVector( here.x * 10 + 5, here.y * 10 + 5, aliveCellsEW.size( ) );

               int elimIndex = contains( eliminated, k );

               if ( elimIndex != -1 )
               {
                  k = eliminated.get( elimIndex );
                  eliminated.remove( elimIndex );
               }

               aliveCellsEW.add( k );

               while ( here != null )
               {
                  for ( int i = 0; i < NEIGHBOORS2.length; i++ )
                  {
                     PVector tmp = new PVector( here.x, here.y );
                     PVector visit = tmp.add( NEIGHBOORS2[ i ] );

                     int toAddIndex = contains( aliveCellsEW, new PVector( visit.x * 10 + 5, visit.y * 10 + 5 ) );

                     if ( toAddIndex == -1 && visit.x < MAX_COL_AW - 1 && visit.x > -1 && visit.y < MAX_ROW_AW - 1 && visit.y > -1 )
                     {
                        k = new PVector( visit.x * 10 + 5, visit.y * 10 + 5, aliveCellsEW.size( ) );

                        elimIndex = contains( eliminated, k );

                        if ( elimIndex != -1 )
                        {
                           k = eliminated.get( elimIndex );
                           eliminated.remove( elimIndex );
                        }

                        aliveCellsEW.add( k );

                        toCheck.add( new PVector( visit.x, visit.y ) );
                     }
                  }
                  if ( toCheck.size( ) != 0 )
                     here = toCheck.remove( 0 );
                  else
                     here = null;
               }

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
         } else if ( applet.mouseButton == RIGHT )
         {
            int index = contains( aliveCellsEW, new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5 ) );

            if ( index != -1 )
            {
               PVector clicked = new PVector( colToAdd, rowToAdd, index );
               ArrayList<PVector> toCheck = new ArrayList<PVector>( );
               toCheck.add( clicked );

               PVector here = toCheck.remove( 0 );

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

               aliveCellsEW.remove( new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5, index ) );
               PVector elim = new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5, index );
               eliminated.add( elim );

               while ( here != null )
               {
                  for ( int i = 0; i < NEIGHBOORS2.length; i++ )
                  {
                     PVector tmp = new PVector( here.x, here.y, here.z );
                     PVector visit = tmp.add( NEIGHBOORS2[ i ] );

                     if ( aliveCellsEW.remove( new PVector( visit.x * 10 + 5, visit.y * 10 + 5, visit.z ) ) && visit.x < MAX_COL_AW - 1 && visit.x > -1 && visit.y < MAX_ROW_AW - 1 && visit.y > -1 )
                     {
                        toCheck.add( new PVector( visit.x, visit.y ) );
                        elim = new PVector( colToAdd * 10 + 5, rowToAdd * 10 + 5, visit.z );
                        eliminated.add( elim );
                     }
                  }
                  if ( toCheck.size( ) != 0 )
                     here = toCheck.remove( 0 );
                  else
                     here = null;
               }

               if ( !compareLists( shapeStoredForEdit, aliveCellsEW ) )
               {
                  editDone = false;
                  showEditButtonSignal( true );
               } else
               {
                  editDone = true;
                  showEditButtonSignal( false );
               }

               if ( aliveCellsEW.isEmpty( ) )
               {
                  clearShapeE.setText( "Llenar" );
                  editDone = true;
                  showEditButtonSignal( false );
               }
            }
         }
         break;
      }
   }
}