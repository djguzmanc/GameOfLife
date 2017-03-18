class PVectorComparator implements Comparator<PVector>
{
   int compare( PVector a, PVector b )
   {
      if ( a.z < b.z )
         return -1;
      else if ( a.z > b.z )
         return 1;
      else
         return 0;
   }
}