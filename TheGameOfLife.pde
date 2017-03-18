import controlP5.*;
import java.util.*;
import g4p_controls.*;  
import sprites.utils.*;
import sprites.*;
import javax.swing.JOptionPane;

Sprite s, k, m;
StopWatch timer2;
float playTime = 0;

PImage isAlive, isDead, usedSpace, isAlive2, enclose, barrelCursor;

ControlP5 cp5, cp52;

final int MAX_ROW = 171;
final int MAX_COL = 303;
final int MAX_ROW_AW = 41;
final int MAX_COL_AW = 41;
final int GRID_SIZE_X = 1349;
final int X_DISPLACEMENT = 35 * 4;
final int GRID_SIZE_Y = 681;
final int GRID_SIZE_X_AW = ( MAX_COL_AW - 1 ) * 10;
final int GRID_SIZE_Y_AW = ( MAX_ROW_AW - 1 ) * 10;
final float X_LABEL = 20, Y_LABEL = 540;

String PATH = null;
final String BACKUP_PATH = "backup.life";

int gen = 0, dialogIndex = -1, confirmIndex;

boolean globalFlag = false, firstMessage;

String grid[][] = new String[ MAX_ROW + 1 ][ MAX_COL + 1 ];
CellState cellGrid[][] = new CellState[ MAX_ROW ][ MAX_COL ];

LinkedList<PVector> aliveCells = new LinkedList<PVector>( );
LinkedList<PVector> aliveCellsAW = new LinkedList<PVector>( );
LinkedList<PVector> aliveCellsEW = new LinkedList<PVector>( );

LinkedList<LinkedList<PVector>> aliveCellsCopy = new LinkedList<LinkedList<PVector>>( );
LinkedList<LinkedList<PVector>> aliveCellsAWCopy = new LinkedList<LinkedList<PVector>>( );
LinkedList<LinkedList<PVector>> aliveCellsEWCopy = new LinkedList<LinkedList<PVector>>( );

LinkedList<PVector> cellsToAdd = new LinkedList<PVector>( );
LinkedList<PVector> cellsToKill = new LinkedList<PVector>( );
LinkedList<PVector> cellsToCheck= new LinkedList<PVector>( );

ArrayList<PVector> shapeStored = new ArrayList<PVector>( );
ArrayList<PVector> shapeStoredForEdit = new ArrayList<PVector>( );

ArrayList<ArrayList<PVector>> allShapes = new ArrayList<ArrayList<PVector>>( );
ArrayList<String> allShapesString = new ArrayList<String>( );

final PVector NEIGHBOORS[] = new PVector[ 8 ];
final PVector NEIGHBOORS2[] = new PVector[ 4 ];

GButton run, killAll, auxiliarWindow, shapeToggle, runModeToggle, nextGen, rules, edit, remove;
GButton shapeDone, clearShape, storeShape, saveShape;
GButton clearShapeE, saveChange, editDoneE;
GButton ok, ok2, cancel, yes, no;

GImageToggleButton btnToggle0, btnToggle1;

GWindow newWindow, dialogWindow, rulesWindow, editWindowRef;

DropdownList savedShapes;

GTextField name, editName;

Textlabel shapeLabel, shapes, enterName;
GLabel rulesLabel;

GTimer timer;

public void setup( )
{
   size( 1349, 681 );
   imageMode( CENTER );
   textSize( 13 );

   cp5 = new ControlP5( this );

   loadImages( );
   loadNeighboors( );
   fillStringMatrix( );
   initCellsState( );
   changeAppIcon( loadImage( "icon.png" ) );

   run = new GButton( this, X_LABEL, 10, 100, 19, "Iniciar ►");
   run.setLocalColorScheme( color( 255, 255, 255 ) );
   run.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   killAll = new GButton( this, X_LABEL, 30, 100, 19, "Remover células" );
   killAll.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   auxiliarWindow = new GButton( this, X_LABEL, 100, 100, 30, "Creador" );
   auxiliarWindow.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   shapeToggle = new GButton( this, X_LABEL, 140, 100, 30, "Una célula" );
   shapeToggle.setLocalColorScheme( color( 15, 24, 140 ) );
   shapeToggle.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   rules = new GButton( this, X_LABEL, 650, 100, 19, "Reglas");
   rules.setLocalColorScheme( color( 255, 255, 255 ) );
   rules.setLocalColor( color( 2, 2, 2 ), color( 255 ) );

   shapeLabel = cp5.addTextlabel( "label1" ).setText( "Ninguna figura seleccionada" ).setPosition( X_LABEL - 15, 171 ).setColorValue( color( 255, 0, 0 ) ).setFont( createFont( "Century Gothic", 9 ) );
   shapes = cp5.addTextlabel( "label2" ).setText( "Tus figuras" ).setPosition( X_LABEL + 10, 280 ).setColorValue( color( 63, 72, 204 ) ).setFont( createFont( "Century Gothic", 14 ) );

   runModeToggle = new GButton( this, X_LABEL, 210, 100, 30, "Paso a paso" );
   runModeToggle.setLocalColorScheme( color( 15, 24, 140 ) );
   runModeToggle.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   nextGen = new GButton( this, X_LABEL + 40, 242, 20, 20, "►" );
   nextGen.setLocalColorScheme( color( 255, 255, 255 ) );
   nextGen.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   nextGen.setVisible( false );

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

   edit = new GButton( this, X_LABEL - 10, 620, 60, 19, "Editar" );
   edit.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   edit.setVisible( false );
   remove = new GButton( this, X_LABEL + 55, 620, 60, 19, "Remover" );
   remove.setLocalColor( color( 2, 2, 2 ), color( 255 ) );
   remove.setVisible( false );

   //writeFile( BACKUP_PATH, allShapesString );
   updateDropList( );

   timer = new GTimer( this, this, "displayLabel", 1000 );

   addCell( 150, 100 );
   addCell( 151, 100 );
   addCell( 151, 98 );
   addCell( 153, 99 );
   addCell( 154, 100 );
   addCell( 155, 100 );
   addCell( 156, 100 );
   
   for ( int i = 0; i < MAX_ROW; i++ )
      for ( int j = 0; j < MAX_COL; j++ )
         cellGrid[ i ][ j ].paintCell( this );
}

public void draw( )
{
   background( 0 );

   fill( 136, 0, 21 );
   rect( 0, 0, X_DISPLACEMENT, GRID_SIZE_Y );

   for ( int i = 0; i < MAX_ROW; i++ )
      for ( int j = 0; j < MAX_COL; j++ )
         cellGrid[ i ][ j ].paintCell( this );

   if ( shapeToggle.getText( ).equals( "Tu figura" ) && mouseX >= X_DISPLACEMENT && ( newWindow == null || !newWindow.isVisible( ) ) && ( editWindowRef == null || !editWindowRef.isVisible( ) ) )
      for ( int i = 0; i < shapeStored.size( ); i++ )
         image( enclose, xForShape + shapeStored.get( i ).x, yForShape + shapeStored.get( i ).y );

   if ( globalFlag )
   {
      checkAliveCells( );
      checkNeighboors( );   
      updateGrid( );
      gen++;
   }

   fill( 0, 255, 255 );
   text( "Celulas vivas: " + aliveCells.size( ), X_LABEL - 8, 70 );
   text( "Generación: " + gen, X_LABEL - 8, 90 );
}

public void windowDraw( PApplet applet, GWinData data )
{
   if ( newWindow.isVisible( ) )
   {
      applet.background( 0 );

      applet.fill( 78, 50, 233 );
      applet.rect( 0, 0, ( MAX_COL_AW - 1 ) * 10, ( MAX_ROW_AW - 1 ) * 10 );

      applet.fill( 136, 0, 21 );
      applet.rect( GRID_SIZE_X_AW, 0, GRID_SIZE_X_AW + 150, GRID_SIZE_Y_AW );

      for ( int i = 0; i < aliveCellsAW.size( ); i++ )
         applet.image( isAlive2, aliveCellsAW.get( i ).x, aliveCellsAW.get( i ).y );

      for ( int i = 0; i < MAX_ROW_AW; i++ )
         applet.line( 0, i * 10, ( MAX_COL_AW - 1 ) * 10, i * 10 );  

      for ( int i = 0; i < MAX_COL_AW; i++ )
         applet.line( i * 10, 0, i * 10, ( MAX_ROW_AW - 1 ) * 10 );

      s.draw( );
      k.draw( );

      playTime = ( float ) timer2.getRunTime( );
      float deltaTime = ( float ) timer2.getElapsedTime( );
      updateAllSprites( deltaTime );
   }
}

public void editWindowDraw( PApplet applet, GWinData data )
{
   if ( editWindowRef.isVisible( ) )
   {
      applet.background( 0 );

      applet.fill( 78, 50, 233 );
      applet.rect( 0, 0, ( MAX_COL_AW - 1 ) * 10, ( MAX_ROW_AW - 1 ) * 10 );

      applet.fill( 136, 0, 21 );
      applet.rect( GRID_SIZE_X_AW, 0, GRID_SIZE_X_AW + 150, GRID_SIZE_Y_AW );


      for ( int i = 0; i < aliveCellsEW.size( ); i++ )
         applet.image( isAlive2, aliveCellsEW.get( i ).x, aliveCellsEW.get( i ).y );

      for ( int i = 0; i < MAX_ROW_AW; i++ )
         applet.line( 0, i * 10, ( MAX_COL_AW - 1 ) * 10, i * 10 );  

      for ( int i = 0; i < MAX_COL_AW; i++ )
         applet.line( i * 10, 0, i * 10, ( MAX_ROW_AW - 1 ) * 10 );

      m.draw( );

      playTime = ( float ) timer2.getRunTime( );
      float deltaTime = ( float ) timer2.getElapsedTime( );
      updateAllSprites( deltaTime );
   }
}

public void windowDraw2( PApplet applet, GWinData data )
{
   applet.background( 115, 117, 216 );
}

public void windowDraw3( PApplet applet, GWinData data )
{
   applet.background( 115, 117, 216 );
}