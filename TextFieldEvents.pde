public void handleTextEvents( GEditableTextControl textcontrol, GEvent event ) 
{
   if ( textcontrol == editName && event == GEvent.CHANGED )
   {
      editDone = false;
      showEditButtonSignal( true );
   }
}