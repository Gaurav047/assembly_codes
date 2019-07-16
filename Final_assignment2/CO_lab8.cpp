#include <iostream>
#include <fstream>
#include <cmath>
#include <cstring>

using namespace std;

class directCache{
private:
	int size;
	int numBlocks;
	typedef struct blockNode{
		bool valid;
		unsigned int tag;
	}blockArray;
	blockArray * blk;

public:
	directCache( int SIZE )
	{
		size = SIZE;
		numBlocks = size>>4;
		blk = new blockArray[ numBlocks ];
		for( int i = 0 ; i < numBlocks; ++i )
			blk[i].valid = false;
	}

	bool read( unsigned int add )
	{
		unsigned int tag = add>>4;
		//int index = tag%((int)pow(2, (numBlocks-1)));
		unsigned int index = tag % numBlocks;
		if ( ( ( blk + index )->tag == tag ) && ( blk + index )->valid )
			return true;
		else
		{
			( blk + index ) -> tag = tag;
			( blk + index ) -> valid = true;
			return false;

		}
	}
};


class twoWayCache
{
private:
  int size;
  int numBlocks;
  int approach;

  typedef struct blockNode{
    unsigned int tag;
    bool valid;
    unsigned int blockTime;
  } blockArray;

  unsigned int timeCache;
  blockArray *blk;

public:

  twoWayCache( int SIZE , int ap )
  {
    size=SIZE;
    approach = ap;

    timeCache = 1;
    numBlocks = size>>4;
    blk = new blockArray[ numBlocks ];
    for ( int i = 0 ; i < numBlocks ; ++i )
    {
      blk[i].valid = false;
      blk[i].blockTime = 0;
    }
  }

  bool read(unsigned int add)
  {
    ++timeCache;
    unsigned int tag = add>>4;
    unsigned int index1 = tag%((int)(numBlocks/2));
    unsigned int index2 = 0;

    for ( int i = 0 ; i<2 ; ++i )
    {
      if ( ( blk + ( 2 * index1 + i ) ) -> tag == tag && ( blk + ( 2 * index1 + i ) ) -> valid )
      {
      	if( approach == 1 )
	        ( blk + ( 2 * index1 + i ) ) -> blockTime = timeCache;
        return true;
        break;
      }
    }

    if ( ( blk + ( 2 * index1 ) ) -> blockTime < ( blk + ( 2 * index1 + 1 ) ) -> blockTime )
      index2 = 0;
    else
      index2 = 1;
    ( blk + ( 2 * index1 + index2 ) ) -> tag = tag;
    ( blk + ( 2 * index1 + index2 ) ) -> blockTime = timeCache;
    ( blk + ( 2 * index1 + index2 ) ) -> valid = true;

    return false;
  };
};

double retHit(char * file, int lines, int size, int assoc, int repl)
{

	if( assoc == 0 )	//direct
	{
		directCache obj( size );
			int hit = 0;
		int miss = 0;
		FILE* fp = fopen( file , "r" );

		unsigned int input;
	  for ( int i = 0 ; i < lines ; ++i )
	  {
	    fscanf( fp , "%X" , &input );
	    if( obj.read( input ) )
	    	++hit;
	    else
	    	++miss;
	  }

	  return ( (double)miss )/( hit + miss );
	}
	else
	{
		twoWayCache obj( size, repl );		//repl = 1 : LRU   = 0 : FIFO
		int hit = 0;
		int miss = 0;
		FILE* fp = fopen( file , "r" );

		unsigned int input;
	  for ( int i = 0 ; i < lines ; ++i )
	  {
	    fscanf( fp , "%X" , &input );
	    if( obj.read( input ) )
	    	++hit;
	    else
	    	++miss;
	  }

	  return ( (double)miss )/( hit + miss );
	}

}

int main( int argc, char ** argv )
{
	unsigned int nl=0;
	FILE* f=fopen(argv[1],"r");
	char ch;
	while (EOF != (ch=getc(f)))
		if (ch=='\n')
		  ++nl;
	fclose(f);

	/*cout<<retHit( argv[1], nl, 1024 , 0, 0);
 	cout<<retHit( argv[1], nl, 2048 , 0, 0);
 	cout<<retHit( argv[1], nl, 4096 , 0, 0);
 	cout<<retHit( argv[1], nl, 8192 , 0, 0);
 	cout<<retHit( argv[1], nl, 16384, 0, 0);
 	cout<<endl;
 	cout<<retHit( argv[1], nl, 1024 , 1, 1);
 	cout<<retHit( argv[1], nl, 2048 , 1, 1);
 	cout<<retHit( argv[1], nl, 4096 , 1, 1);
 	cout<<retHit( argv[1], nl, 8192 , 1, 1);
 	cout<<retHit( argv[1], nl, 16384, 1, 1);
 	cout<<retHit( argv[1], nl, 1024 , 1, 0);
 	cout<<retHit( argv[1], nl, 2048 , 1, 0);
 	cout<<retHit( argv[1], nl, 4096 , 1, 0);
 	cout<<retHit( argv[1], nl, 8192 , 1, 0);
 	cout<<retHit( argv[1], nl, 16384, 1, 0);
 	*/
  //fseek(f,0,SEEK_SET );

  //directCache c1[10] = {directCache(1024),directCache(2048),directCache(4096),directCache(8192),directCache(16384),directCache(1024),directCache(2048),directCache(4096),directCache(8192),directCache(16384)};
  //twoWayCache c2[10] = {twoWayCache(1024,1),twoWayCache(2048,1),twoWayCache(4096,1),twoWayCache(8192,1),twoWayCache(16384,1), twoWayCache(1024,0),twoWayCache(2048,0),twoWayCache(4096,0),twoWayCache(8192,0),twoWayCache(16384,0)};

  double **rate = new double * [ 2 ];
  rate [ 0 ] = new double [ 5 ];
  rate [ 1 ] = new double [ 10 ];

 	rate[ 0 ][ 0 ] = retHit( argv[1], nl, 1024 , 0, 0);
 	rate[ 0 ][ 1 ] = retHit( argv[1], nl, 2048 , 0, 0);
 	rate[ 0 ][ 2 ] = retHit( argv[1], nl, 4096 , 0, 0);
 	rate[ 0 ][ 3 ] = retHit( argv[1], nl, 8192 , 0, 0);
 	rate[ 0 ][ 4 ] = retHit( argv[1], nl, 16384, 0, 0);

 	rate[ 1 ][ 0 ] = retHit( argv[1], nl, 1024 , 1, 1);
 	rate[ 1 ][ 1 ] = retHit( argv[1], nl, 2048 , 1, 1);
 	rate[ 1 ][ 2 ] = retHit( argv[1], nl, 4096 , 1, 1);
 	rate[ 1 ][ 3 ] = retHit( argv[1], nl, 8192 , 1, 1);
 	rate[ 1 ][ 4 ] = retHit( argv[1], nl, 16384, 1, 1);
 	rate[ 1 ][ 5 ] = retHit( argv[1], nl, 1024 , 1, 0);
 	rate[ 1 ][ 6 ] = retHit( argv[1], nl, 2048 , 1, 0);
 	rate[ 1 ][ 7 ] = retHit( argv[1], nl, 4096 , 1, 0);
 	rate[ 1 ][ 8 ] = retHit( argv[1], nl, 8192 , 1, 0);
 	rate[ 1 ][ 9 ] = retHit( argv[1], nl, 16384, 1, 0);


 	FILE * fo;
  fo = fopen( "out.csv", "w" );
  //fprintf(f, "LRU FIFO ,,,LRU,,,,,FIFO\n" );
  fprintf(fo, "Mapping/Size,1024,2048,4096,8192,16384\n" );
  fprintf(fo, "Direct" );
  for (int i=0;i<5;++i)
    fprintf( fo, ", %e" , rate[ 0 ][ i ] );
  fprintf(fo, "\nMapping/Size,1024,2048,4096,8192,16384,1024,2048,4096,8192,16384\n" );
  fprintf(fo, "\nLRU/FIFO ,,,LRU,,,,,FIFO\n" );
  fprintf(fo, "2-Way");
  for (int i=0;i<10;++i)
    fprintf( fo, ", %e" , rate[ 1 ][ i ] );
  fclose( fo );
  return 0;
}
