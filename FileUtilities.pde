public ArrayList<String> readFile ( String fileName )
{
   ArrayList<String> answer = new ArrayList<String>( );
   try 
   {
      BufferedReader reader = createReader( fileName );
      while ( true )
      {
         String line = reader.readLine( );
         if ( line != null )
            answer.add( line );
         else
            break;
      }
      reader.close( );
   } 
   catch ( Exception e ) 
   {
      System.err.println( "Error in FilesUtilities.readFile." );
      e.printStackTrace( );
      return null;
   }

   return answer;
}

public boolean writeFile ( String fileName, ArrayList<String> lines )
{
   try 
   {
      PrintWriter writter = createWriter( fileName );
      for ( String line : lines ) 
      {
         writter.println( line );
      }
      writter.flush( );
      writter.close( );
   } 
   catch ( Exception e ) 
   {
      System.err.println( "Error en  FileUtilities.writeFile" );
      e.printStackTrace( );
      return false;
   }

   return true;
}