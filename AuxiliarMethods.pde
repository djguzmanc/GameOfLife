void loadImages( )
{
   isAlive = loadImage( "live.png" );
   isAlive2 = loadImage( "live.png" );
   isAlive2.resize( 9, 9 );
   isDead = loadImage( "dead.png" );
   usedSpace = loadImage( "used.png" );
   enclose = loadImage( "enclose.png" );

   barrelCursor = loadImage( "barrelButton.png" );
   barrelCursor.mask( loadImage( "barrelButtonM.png" ) );

   if ( isAlive == null || isDead == null || usedSpace == null || enclose == null || barrelCursor == null || loadImage( "barrelButtonM.png" ) == null )
   {
      JOptionPane.showMessageDialog( null, "La carpeta data ha sido eliminada, movida o modificada. El programa debe descargarse de nuevo." );
      exit( );
   }

   timer2 = new StopWatch( );
   timer2.reset( );
}

void updateAllSprites( float deltaTime ) 
{
   if ( s != null )
      s.update( deltaTime );
   if ( k != null )
      k.update( deltaTime );
   if ( m != null )
      m.update( deltaTime );
}

void loadNeighboors( )
{
   NEIGHBOORS[ 0 ] = new PVector( 0, 1 );
   NEIGHBOORS[ 1 ] = new PVector( 1, 0 );
   NEIGHBOORS[ 2 ] = new PVector( 1, 1 );
   NEIGHBOORS[ 3 ] = new PVector( 1, -1 );
   NEIGHBOORS[ 4 ] = new PVector( -1, 1 );
   NEIGHBOORS[ 5 ] = new PVector( 0, -1 );
   NEIGHBOORS[ 6 ] = new PVector( -1, 0 );
   NEIGHBOORS[ 7 ] = new PVector( -1, -1 );

   NEIGHBOORS2[ 0 ] = new PVector( 1, 0, 0 );
   NEIGHBOORS2[ 1 ] = new PVector( -1, 0, 0 );
   NEIGHBOORS2[ 2 ] = new PVector( 0, 1, 0 );
   NEIGHBOORS2[ 3 ] = new PVector( 0, -1, 0 );
}

void fillStringMatrix( )
{
   for ( int i = 0; i < MAX_ROW + 1; i++ )
      grid[ i ][ 0 ] = grid[ i ][ MAX_COL ] = "W";

   for ( int i = 0; i < MAX_COL + 1; i++ )
      grid[ 0 ][ i ] = grid[ MAX_ROW ][ i ] = "W";

   for ( int i = 1; i < MAX_ROW; i++ )
      for ( int j = 1; j < MAX_COL; j++ )
         grid[ i ][ j ] = "D";
}

void initCellsState( )
{
   for ( int i = 0; i < MAX_ROW; i++ )
      for ( int j = 0; j < MAX_COL; j++ )
         cellGrid[ i ][ j ] = new CellState( "dead", new PVector( j * 4 + 2 + X_DISPLACEMENT, i * 4 + 2 ) );
}

void addCell( int x, int y )
{
   if ( y <= 0 )
      y = MAX_ROW + y - 1;
   else if ( y >= MAX_ROW )
      y = y - MAX_ROW + 1;

   if ( x <= 0 )
      x = MAX_COL + x - 1;
   else if ( x >= MAX_COL )
      x = x - MAX_COL + 1;

   if ( !aliveCells.contains( new PVector( x, y ) ) )
      aliveCells.add( new PVector( x, y ) );

   grid[ y ][ x ] = "A";
   cellGrid[ y - 1 ][ x - 1 ].setState( "alive" );
}

void removeCell( int x, int y )
{
   if ( y <= 0 )
      y = MAX_ROW + y - 1;
   else if ( y >= MAX_ROW )
      y = y - MAX_ROW + 1;

   if ( x <= 0 )
      x = MAX_COL + x - 1;
   else if ( x >= MAX_COL )
      x = x - MAX_COL + 1;

   if ( aliveCells.remove( new PVector( x, y ) ) )
   {
      grid[ y ][ x ] = "D";
      cellGrid[ y - 1 ][ x - 1 ].setState( "used" );
   }
}

void cleanGrid( )
{
   initCellsState( );
   for ( int i = 1; i < MAX_ROW; i++ )
      for ( int j = 1; j < MAX_COL; j++ )
         grid[ i ][ j ] = "D";
}

void setupAuxiliarWindow( )
{
   newWindow = GWindow.getWindow( this, "Creador de figuras", 700, 50, GRID_SIZE_X_AW + 150, GRID_SIZE_Y_AW + 1, JAVA2D );

   s = new Sprite( newWindow, "buttonSignal.png", "buttonSignalM.png", 1, 6, 100 );
   s.setFrame( 5 );
   s.setXY( 474, 240 );
   k = new Sprite( newWindow, "buttonSignal.png", "buttonSignalM.png", 1, 6, 100 );
   k.setFrame( 1 );
   k.setXY( 474, 300 );

   s.setVisible( false );
   k.setVisible( false );

   newWindow.addDrawHandler( this, "windowDraw" );
   newWindow.addMouseHandler( this, "windowMouse" );
   newWindow.addKeyHandler( this, "windowKey" );
   newWindow.imageMode( CENTER );

   btnToggle0 = new GImageToggleButton( newWindow, 460, 330, "toggle.png", 0, 0 );

   shapeDone = new GButton( newWindow, 445, 100, 60, 40, "Listo" );
   shapeDone.setLocalColorScheme( color( 255, 255, 255 ) );
   shapeDone.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   if ( aliveCellsAW.isEmpty( ) )
      clearShape = new GButton( newWindow, 425, 160, 100, 40, "Llenar" );
   else
      clearShape = new GButton( newWindow, 425, 160, 100, 40, "Limpiar" );
   clearShape.setLocalColor( color( 2, 2, 2 ), color( 255 ) );

   storeShape = new GButton( newWindow, 425, 220, 100, 40, "Seleccionar figura" );
   storeShape.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   saveShape = new GButton( newWindow, 425, 280, 100, 40, "Guardar figura" );
   saveShape.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
}

void setupEditWindow( )
{
   editWindowRef = GWindow.getWindow( this, "Edita tu Figura", 700, 50, GRID_SIZE_X_AW + 150, GRID_SIZE_Y_AW + 1, JAVA2D );

   m = new Sprite( editWindowRef, "buttonSignal.png", "buttonSignalM.png", 1, 6, 100 );
   m.setFrameSequence( 1, 6, 0.09 );
   m.setXY( 474, 240 );

   m.setVisible( false );

   editWindowRef.addDrawHandler( this, "editWindowDraw" );
   editWindowRef.addMouseHandler( this, "editWindowMouse" );
   editWindowRef.addKeyHandler( this, "editWindowKey" );
   editWindowRef.imageMode( CENTER );

   editName =  new GTextField( editWindowRef, 410, 300, 130, 20 );
   editName.setText( savedShapes.getLabel( ) );

   btnToggle1 = new GImageToggleButton( editWindowRef, 460, 330, "toggle.png", 0, 0 );

   editDoneE = new GButton( editWindowRef, 445, 100, 60, 40, "Listo" );
   editDoneE.setLocalColorScheme( color( 255, 255, 255 ) );
   editDoneE.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   saveChange = new GButton( editWindowRef, 425, 220, 100, 40, "Guardar cambio" );
   saveChange.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   if ( !aliveCellsEW.isEmpty( ) )
      clearShapeE = new GButton( editWindowRef, 425, 160, 100, 40, "Limpiar" );
   else
      clearShapeE = new GButton( editWindowRef, 425, 160, 100, 40, "Llenar" );
   clearShapeE.setLocalColor( color( 2, 2, 2 ), color( 255 ) );

   for ( int i = 0; i < shapeStored.size( ); i++ )
      aliveCellsEW.add( new PVector( ( ( shapeStored.get( i ).x / 4 ) * 10 ) + 5, ( ( shapeStored.get( i ).y / 4 ) * 10 ) + 5 ) );
}

void setupRulesWindow( )
{
   rulesWindow = GWindow.getWindow( this, "Rules", 500, 100, 300, 400, JAVA2D );
   rulesWindow.addDrawHandler( this, "windowDraw3" );
   ok2 = new GButton( rulesWindow, 110, 340, 80, 20, "Ok" );
   ok2.setLocalColorScheme( color( 15, 24, 140 ) );
   ok2.setLocalColor( color( 2, 2, 2 ), color( 255 ) );

   String si = "1. Cualquier célula viva con menos de dos vecinas vivas muere, por baja población. \n\n2. Cualquier célula viva con dos o tres vecinas vivas vivirá en la siguiente generación. \n\n3. Cualquier célula viva con más de tres vecinas vivas muere, por sobrepoblación. \n\n4. Cualquier célula muerta con exactamente tres vecinas vivas vivirá, por reproducción.";
   rulesLabel = new GLabel( rulesWindow, 10, 30, 280, 300, si );
   rulesLabel.setTextAlign( GAlign.JUSTIFY, GAlign.JUSTIFY );
   rulesLabel.setTextBold( );
   rulesLabel.setFont( FontManager.getFont( "Century Gothic", 14, 14 ) );
}

void changeAppIcon( PImage img )
{
   PGraphics pg = createGraphics( 16, 16, JAVA2D );
   pg.beginDraw( );
   pg.image( img, 0, 0, 16, 16 );
   pg.endDraw( );

   frame.setIconImage( pg.image );
} 

void updateDropList( )
{
   ArrayList<String> backup = readFile( BACKUP_PATH );

   if ( backup == null )
   {
      JOptionPane.showMessageDialog( null, "El archivo interno de almacenamiento fue movido o fue eliminado, el programa debe reiniciarse. Las figuras creadas anteriomente no se recuperarán." );

      ArrayList<String> line = new ArrayList<String>( );

      String a = "INITIAL_MESSAGE;not_showed";
      line.add( a );
      a = "PATH;default";     
      line.add( a );
      a = "Pulsar;68.0,60.0,0.0S64.0,60.0,0.0S60.0,60.0,0.0S52.0,68.0,0.0S52.0,72.0,0.0S52.0,76.0,0.0S60.0,80.0,0.0S64.0,80.0,0.0S68.0,80.0,0.0S72.0,76.0,0.0S72.0,72.0,0.0S72.0,68.0,0.0S80.0,68.0,0.0S80.0,72.0,0.0S80.0,76.0,0.0S84.0,80.0,0.0S88.0,80.0,0.0S92.0,80.0,0.0S84.0,60.0,0.0S88.0,60.0,0.0S92.0,60.0,0.0S100.0,76.0,0.0S100.0,72.0,0.0S100.0,68.0,0.0S68.0,88.0,0.0S64.0,88.0,0.0S60.0,88.0,0.0S72.0,92.0,0.0S72.0,96.0,0.0S72.0,100.0,0.0S68.0,108.0,0.0S64.0,108.0,0.0S60.0,108.0,0.0S52.0,100.0,0.0S52.0,96.0,0.0S52.0,92.0,0.0S80.0,92.0,0.0S80.0,96.0,0.0S80.0,100.0,0.0S84.0,88.0,0.0S88.0,88.0,0.0S92.0,88.0,0.0S84.0,108.0,0.0S88.0,108.0,0.0S92.0,108.0,0.0S100.0,92.0,0.0S100.0,96.0,0.0S100.0,100.0,0.0";
      line.add( a );
      a = "Pentadecathlon;64.0,64.0,0.0S64.0,68.0,0.0S64.0,72.0,0.0S64.0,76.0,0.0S64.0,80.0,0.0S64.0,84.0,0.0S64.0,88.0,0.0S64.0,92.0,0.0S68.0,92.0,0.0S68.0,84.0,0.0S68.0,80.0,0.0S68.0,76.0,0.0S68.0,72.0,0.0S72.0,92.0,0.0S72.0,88.0,0.0S72.0,84.0,0.0S72.0,80.0,0.0S72.0,76.0,0.0S72.0,72.0,0.0S72.0,68.0,0.0S72.0,64.0,0.0S68.0,64.0,0.0";
      line.add( a );
      a = "The R-pentomino;68.0,80.0,0.0S72.0,80.0,0.0S72.0,84.0,0.0S72.0,76.0,0.0S76.0,76.0,0.0";
      line.add( a );
      a = "Acorn;60.0,88.0,0.0S64.0,88.0,0.0S64.0,80.0,0.0S72.0,84.0,0.0S76.0,88.0,0.0S80.0,88.0,0.0S84.0,88.0,0.0";
      line.add( a );
      a = "Die hard;56.0,84.0,0.0S60.0,84.0,0.0S60.0,88.0,0.0S76.0,88.0,0.0S80.0,88.0,0.0S84.0,88.0,0.0S80.0,80.0,0.0";
      line.add( a );
      a = "Gosper glider gun;4.0,64.0,0.0S4.0,68.0,0.0S0.0,68.0,0.0S0.0,64.0,0.0S40.0,64.0,0.0S40.0,68.0,0.0S40.0,72.0,0.0S44.0,76.0,0.0S44.0,60.0,0.0S52.0,56.0,0.0S48.0,56.0,0.0S48.0,80.0,0.0S52.0,80.0,0.0S56.0,68.0,0.0S64.0,64.0,0.0S64.0,68.0,0.0S64.0,72.0,0.0S60.0,60.0,0.0S60.0,76.0,0.0S68.0,68.0,0.0S80.0,64.0,0.0S80.0,60.0,0.0S80.0,56.0,0.0S84.0,56.0,0.0S84.0,60.0,0.0S84.0,64.0,0.0S88.0,52.0,0.0S88.0,68.0,0.0S96.0,52.0,0.0S96.0,48.0,0.0S96.0,68.0,0.0S96.0,72.0,0.0S136.0,56.0,0.0S140.0,56.0,0.0S140.0,60.0,0.0S136.0,60.0,0.0";
      line.add( a );
      a = "?;0.0,72.0,0.0S4.0,72.0,0.0S8.0,72.0,0.0S12.0,72.0,0.0S16.0,72.0,0.0S20.0,72.0,0.0S24.0,72.0,0.0S28.0,72.0,0.0S36.0,72.0,0.0S40.0,72.0,0.0S44.0,72.0,0.0S48.0,72.0,0.0S52.0,72.0,0.0S68.0,72.0,0.0S72.0,72.0,0.0S76.0,72.0,0.0S104.0,72.0,0.0S108.0,72.0,0.0S112.0,72.0,0.0S116.0,72.0,0.0S120.0,72.0,0.0S124.0,72.0,0.0S128.0,72.0,0.0S136.0,72.0,0.0S140.0,72.0,0.0S144.0,72.0,0.0S148.0,72.0,0.0S152.0,72.0,0.0";
      line.add( a );

      if ( !writeFile( BACKUP_PATH, line ) )
      {
         JOptionPane.showMessageDialog( null, "Algo ha ocurrido y el archivo interno no pudo ser creado." );
         exit( );
      }

      exit( );
   } else
   {
      if ( backup.get( 0 ).equals( "INITIAL_MESSAGE;not_showed" ) )
      {
         JOptionPane.showMessageDialog( null, "Bienvenido. Parece que es la primer vez que se abre este programa, antes de empezar: " );
         boolean done = false;
         String input = null;

         do
         {
            input = JOptionPane.showInputDialog( "Ingresa un nombre para el archivo en el cual se almacenarán las figuras creadas: " );
            if ( isFileNameValid( input ) )
               done = true;
         } 
         while ( !done );

         String a = "Pulsar;68.0,60.0,0.0S64.0,60.0,0.0S60.0,60.0,0.0S52.0,68.0,0.0S52.0,72.0,0.0S52.0,76.0,0.0S60.0,80.0,0.0S64.0,80.0,0.0S68.0,80.0,0.0S72.0,76.0,0.0S72.0,72.0,0.0S72.0,68.0,0.0S80.0,68.0,0.0S80.0,72.0,0.0S80.0,76.0,0.0S84.0,80.0,0.0S88.0,80.0,0.0S92.0,80.0,0.0S84.0,60.0,0.0S88.0,60.0,0.0S92.0,60.0,0.0S100.0,76.0,0.0S100.0,72.0,0.0S100.0,68.0,0.0S68.0,88.0,0.0S64.0,88.0,0.0S60.0,88.0,0.0S72.0,92.0,0.0S72.0,96.0,0.0S72.0,100.0,0.0S68.0,108.0,0.0S64.0,108.0,0.0S60.0,108.0,0.0S52.0,100.0,0.0S52.0,96.0,0.0S52.0,92.0,0.0S80.0,92.0,0.0S80.0,96.0,0.0S80.0,100.0,0.0S84.0,88.0,0.0S88.0,88.0,0.0S92.0,88.0,0.0S84.0,108.0,0.0S88.0,108.0,0.0S92.0,108.0,0.0S100.0,92.0,0.0S100.0,96.0,0.0S100.0,100.0,0.0";
         allShapesString.add( a );
         a = "Pentadecathlon;64.0,64.0,0.0S64.0,68.0,0.0S64.0,72.0,0.0S64.0,76.0,0.0S64.0,80.0,0.0S64.0,84.0,0.0S64.0,88.0,0.0S64.0,92.0,0.0S68.0,92.0,0.0S68.0,84.0,0.0S68.0,80.0,0.0S68.0,76.0,0.0S68.0,72.0,0.0S72.0,92.0,0.0S72.0,88.0,0.0S72.0,84.0,0.0S72.0,80.0,0.0S72.0,76.0,0.0S72.0,72.0,0.0S72.0,68.0,0.0S72.0,64.0,0.0S68.0,64.0,0.0";
         allShapesString.add( a );
         a = "The R-pentomino;68.0,80.0,0.0S72.0,80.0,0.0S72.0,84.0,0.0S72.0,76.0,0.0S76.0,76.0,0.0";
         allShapesString.add( a );
         a = "Acorn;60.0,88.0,0.0S64.0,88.0,0.0S64.0,80.0,0.0S72.0,84.0,0.0S76.0,88.0,0.0S80.0,88.0,0.0S84.0,88.0,0.0";
         allShapesString.add( a );
         a = "Die hard;56.0,84.0,0.0S60.0,84.0,0.0S60.0,88.0,0.0S76.0,88.0,0.0S80.0,88.0,0.0S84.0,88.0,0.0S80.0,80.0,0.0";
         allShapesString.add( a );
         a = "Gosper glider gun;4.0,64.0,0.0S4.0,68.0,0.0S0.0,68.0,0.0S0.0,64.0,0.0S40.0,64.0,0.0S40.0,68.0,0.0S40.0,72.0,0.0S44.0,76.0,0.0S44.0,60.0,0.0S52.0,56.0,0.0S48.0,56.0,0.0S48.0,80.0,0.0S52.0,80.0,0.0S56.0,68.0,0.0S64.0,64.0,0.0S64.0,68.0,0.0S64.0,72.0,0.0S60.0,60.0,0.0S60.0,76.0,0.0S68.0,68.0,0.0S80.0,64.0,0.0S80.0,60.0,0.0S80.0,56.0,0.0S84.0,56.0,0.0S84.0,60.0,0.0S84.0,64.0,0.0S88.0,52.0,0.0S88.0,68.0,0.0S96.0,52.0,0.0S96.0,48.0,0.0S96.0,68.0,0.0S96.0,72.0,0.0S136.0,56.0,0.0S140.0,56.0,0.0S140.0,60.0,0.0S136.0,60.0,0.0";
         allShapesString.add( a );
         a = "?;0.0,72.0,0.0S4.0,72.0,0.0S8.0,72.0,0.0S12.0,72.0,0.0S16.0,72.0,0.0S20.0,72.0,0.0S24.0,72.0,0.0S28.0,72.0,0.0S36.0,72.0,0.0S40.0,72.0,0.0S44.0,72.0,0.0S48.0,72.0,0.0S52.0,72.0,0.0S68.0,72.0,0.0S72.0,72.0,0.0S76.0,72.0,0.0S104.0,72.0,0.0S108.0,72.0,0.0S112.0,72.0,0.0S116.0,72.0,0.0S120.0,72.0,0.0S124.0,72.0,0.0S128.0,72.0,0.0S136.0,72.0,0.0S140.0,72.0,0.0S144.0,72.0,0.0S148.0,72.0,0.0S152.0,72.0,0.0";
         allShapesString.add( a );

         try
         {
            if ( !writeFile( input + ".life", allShapesString ) )
            {
               JOptionPane.showMessageDialog( null, "Algo ha ocurrido y el archivo " + input + ".life " + "no pudo ser creado." );
               exit( );
            }
            PATH = input + ".life";
            backup.set( 1, "PATH;" + input + ".life" );
            backup.set( 0, "INITIAL_MESSAGE;showed" );
            if ( !writeFile( BACKUP_PATH, backup ) )
            {
               JOptionPane.showMessageDialog( null, "Algo ha ocurrido y el archivo interno no pudo ser modificado." );
               exit( );
            }
         } 
         catch( Exception e )
         {
            e.printStackTrace( );
         }
      } else
      {
         PATH = backup.get( 1 ).split( "[;]+" )[ 1 ];
      }
   }

   ArrayList<String> readedStrings = readFile( PATH );

   if ( readedStrings == null )
   {
      JOptionPane.showMessageDialog( null, "El archivo " + PATH + " fue movido o eliminado. Backup en progreso..." );

      backup = readFile( BACKUP_PATH );

      for ( int i = 2; i < backup.size( ); i++ )
         allShapesString.add( backup.get( i ) );

      if ( !writeFile( PATH, allShapesString ) )
      {
         JOptionPane.showMessageDialog( null, "Algo ha ocurrido y el archivo " + PATH + " interno no pudo ser creado." );
         exit( );
      }
      readedStrings = readFile( PATH );
   }

   allShapesString = new ArrayList<String>( );
   allShapes = new ArrayList<ArrayList<PVector>>( );
   allShapesString.addAll( readedStrings );

   for ( int i = 0; i < readedStrings.size( ); i++ )
   {
      String data[] = readedStrings.get( i ).split( "[;]+" );
      String data2[] = data[ 1 ].split( "S" );
      ArrayList<PVector> tmp = new ArrayList<PVector>( );
      for ( int j = 0; j < data2.length; j++ )
      {
         String data3[] = data2[ j ].split( "," );
         tmp.add( new PVector( Float.parseFloat( data3[ 0 ] ), Float.parseFloat( data3[ 1 ] ), Float.parseFloat( data3[ 2 ] ) ) );
      }

      savedShapes.addItem( data[ 0 ], allShapes.size( ) );
      allShapes.add( tmp );
   }
}

void showButtonSignal( boolean f )
{
   if ( f )
   {
      if ( !storeDone )
      {
         s.setFrameSequence( 1, 6, 0.09 );
         s.setVisible( f );
      }
      if ( !saveDone )
      {
         k.setFrameSequence( 1, 6, 0.09 );
         k.setVisible( f );
      }
   } else
   {
      if ( storeDone )
      {
         s.setFrame( 5 );
         s.setVisible( f );
      }
      if ( saveDone )
      {
         k.setFrame( 1 );
         k.setVisible( f );
      }
   }
}

void showEditButtonSignal( boolean f )
{
   if ( f )
   {
      if ( !editDone )
      {
         m.setFrameSequence( 1, 6, 0.09 );
         m.setVisible( f );
      }
   } else
   {
      if ( editDone )
      {
         m.setFrame( 5 );
         m.setVisible( f );
      }
   }
}

void showInputDialog( String s )
{
   dialogIndex = 2;
   dialogWindow = GWindow.getWindow( this, "Ventana de nombrado", 850, 150, 265, 100, JAVA2D );
   dialogWindow.addDrawHandler( this, "windowDraw2" );

   name = new GTextField( dialogWindow, 32, 45, 200, 20 );
   name.setPromptText( "Escribe aquí" );

   cp52 = new ControlP5( dialogWindow );
   enterName = cp52.addTextlabel( "label3" ).setText( s ).setPosition( 2, 10 ).setColorValue( color( 8, 11, 116 ) ).setFont( createFont( "Century Gothic", 12 ) );

   ok = new GButton( dialogWindow, 45, 75, 80, 20, "Ok" );
   ok.setLocalColorScheme( color( 15, 24, 140 ) );
   ok.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   cancel = new GButton( dialogWindow, 140, 75, 80, 20, "Cancelar" );
   cancel.setLocalColorScheme( color( 15, 24, 140 ) );
   cancel.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
}

public static boolean isFileNameValid( String file )
{
   File f = new File( file );
   try 
   {
      f.getCanonicalPath( );
      return true;
   } 
   catch ( IOException e )
   {
      return false;
   }
}

void saveData( )
{
   if ( !writeFile( PATH, allShapesString ) )
   {
      JOptionPane.showMessageDialog( null, "Algo ocurrió mientras se guardaban los cambios. Guardado cancelado." );
      return;
   }

   ArrayList<String> backup = readFile( BACKUP_PATH );

   if ( backup == null )
   {
      JOptionPane.showMessageDialog( null, "El archivo de almacenamiento interno fue movido o eliminado. Backup cancelado." );
      return;
   }

   ArrayList<String> all = new ArrayList<String>( );
   all.add( backup.get( 0 ) );
   all.add( backup.get( 1 ) );

   all.addAll( allShapesString );

   writeFile( BACKUP_PATH, all );
}

boolean compareLists( ArrayList<PVector> a, LinkedList<PVector> b )
{
   ArrayList<PVector> c = new ArrayList<PVector>( a.size( ) );
   ArrayList<PVector> d = new ArrayList<PVector>( b.size( ) );

   c.addAll( a );
   d.addAll( b );

   c.sort( new PVectorComparator( ) );
   d.sort( new PVectorComparator( ) );

   return c.equals( d );
}

int contains( LinkedList<PVector> list, PVector b )
{
   for ( int i = 0; i < list.size( ); i++ )
      if ( list.get( i ).x == b.x && list.get( i ).y == b.y )
         return i;
   return -1;
}