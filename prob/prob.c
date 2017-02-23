#include <stdlib.h>
#include <stdio.h>
#include <math.h>
//#include "./config_1.c"
#include "./config_2.c"

#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

int verbose =0;

//////////////////////////////////////////////////////////////////////////
//This function returns the amount of symbols that apperars in the array,
//length is the amount of elements.

int count_symbols_8(unsigned char array[], unsigned int array_length){
	int s=1, i, j, f;
	for (i=1; i<array_length; i++){
		j=i-1;
		f=1; 
		while (j >= 0){
			if (array[j] == array[i]){
				j=-1;
				f=0;
			}else{
				j=j-1;
			}
		}
		s=s+f;
	}
	return s;
}

int count_symbols_16(unsigned short int array[], unsigned int array_length){
	int s=1, i, j, f;
	for (i=1; i<array_length; i++){
		j=i-1;
		f=1; 
		while (j >= 0){
			if (array[j] == array[i]){
				j=-1;
				f=0;
			}else{
				j=j-1;
			}
		}
		s=s+f;
	}
	return s;
}

int count_symbols_32(unsigned int array[], unsigned int array_length){
	int s=1, i, j, f;
	for (i=1; i<array_length; i++){
		j=i-1;
		f=1; 
		while (j >= 0){
			if (array[j] == array[i]){
				j=-1;
				f=0;
			}else{
				j=j-1;
			}
		}
		s=s+f;
	}
	return s;
}

//////////////////////////////////////////////////////////////////////////
//This function returns an array of all the sysmbols in order of appeareance

void list_symbols_8(unsigned char array[], unsigned int array_length, unsigned char symbols[]){
	int i, j, k, o;
	symbols[0]=array[0];
	k=1;
	for (i=1; i<array_length; i++){
		j=i-1;
		o=0; 
		while (j >= 0){
			if (array[j] == array[i]){
				j=-1;
				o=1; //it is an old element, already registerd
			}else{
				j=j-1;
			}
		}
		if (o == 0)
		{
			symbols[k]=array[i];
			k=k+1;
		}
	}
	return;
}

void list_symbols_16(unsigned short int array[], unsigned int array_length, unsigned short int symbols[]){
	int i, j, k, o;
	symbols[0]=array[0];
	k=1;
	for (i=1; i<array_length; i++){
		j=i-1;
		o=0; 
		while (j >= 0){
			if (array[j] == array[i]){
				j=-1;
				o=1; //it is an old element, already registerd
			}else{
				j=j-1;
			}
		}
		if (o == 0)
		{
			symbols[k]=array[i];
			k=k+1;
		}
	}
	return;
}

void list_symbols_32(unsigned int array[], unsigned int array_length, unsigned int symbols[]){
	int i, j, k, o;
	symbols[0]=array[0];
	k=1;
	for (i=1; i<array_length; i++){
		j=i-1;
		o=0; 
		while (j >= 0){
			if (array[j] == array[i]){
				j=-1;
				o=1; //it is an old element, already registerd
			}else{
				j=j-1;
			}
		}
		if (o == 0)
		{
			symbols[k]=array[i];
			k=k+1;
		}
	}
	return;
}

//////////////////////////////////////////////////////////////////////////
//This function returns an array with the maximum lenght of a sequence of all the symbols

void max_seq_symbols_8(unsigned char array[], unsigned int array_length, unsigned char symbols[], unsigned int symbols_length, unsigned int occ[]){
	int i, j, c;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		c=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				c=c+1;
			}else{
				if (c > occ[i])
				{
					occ[i] = c;
				}
				c=0;
			}
		}
	}
	return;
}

void max_seq_symbols_16(unsigned short int array[], unsigned int array_length, unsigned short int symbols[], unsigned int symbols_length, unsigned int occ[]){
	int i, j, c;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		c=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				c=c+1;
			}else{
				if (c > occ[i])
				{
					occ[i] = c;
				}
				c=0;
			}
		}
	}
	return;
}

void max_seq_symbols_32(unsigned int array[], unsigned int array_length, unsigned int symbols[], unsigned int symbols_length, unsigned int occ[]){
	int i, j, c;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		c=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				c=c+1;
			}else{
				if (c > occ[i])
				{
					occ[i] = c;
				}
				c=0;
			}
		}
	}
	return;
}

//////////////////////////////////////////////////////////////////////////
//This function returns the occurrencyes for every simbol

void occ_symbols_8(unsigned char array[], unsigned int array_length, unsigned char symbols[], unsigned int symbols_length, unsigned int occ[]){
	int i, j;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		occ[i]=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				occ[i] = occ[i]+1;
			}
		}
	}
	return;
}

void occ_symbols_16(unsigned short int array[], unsigned int array_length, unsigned short int symbols[], unsigned int symbols_length, unsigned int occ[]){
	int i, j;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		occ[i]=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				occ[i] = occ[i]+1;
			}
		}
	}
	return;
}

void occ_symbols_32(unsigned int array[], unsigned int array_length, unsigned int symbols[], unsigned int symbols_length, unsigned int occ[]){
	int i, j;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		occ[i]=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				occ[i] = occ[i]+1;
			}
		}
	}
	return;
}

//////////////////////////////////////////////////////////////////////////
//This function returns the occurrencyes for every simbol

double entropy_8(unsigned char array[], unsigned int array_length){
	if (verbose == 1) printf("Start of calculation of 8 bits symbols entropy.\n");
	if (verbose == 1) printf("Calculating the amount of symbols.\n");
	int n_symbols_8=count_symbols_8(array, array_length);
	if (verbose == 1) printf("Creating symbols list.\n");
	unsigned char * symbols_8 = calloc(n_symbols_8, sizeof(unsigned char));
	if (NULL == symbols_8) {
	  printf("ERROR: memory allocation failed.\n");
	}
	list_symbols_8(array, array_length, symbols_8);
	if (verbose == 1) printf("Calculating symbols occourencies.\n");
	unsigned int * occ_8 = calloc(n_symbols_8, sizeof(unsigned int));
	if (NULL == occ_8) {
		printf("ERROR: memory allocation failed.\n");
	}
	occ_symbols_8(array, array_length, symbols_8, n_symbols_8, occ_8);
	free(symbols_8);
	if (verbose == 1) printf("Calculating entropy.\n");
	double entropy = 0;

	for (int i = 0; i<n_symbols_8; i++){//i is the index of the considered symbol
		entropy = entropy - ((double)occ_8[i]/(double)array_length)*log2((double)occ_8[i]/(double)array_length);
	}
	free(occ_8);
	if (verbose == 1) printf("End of calculation of 8 bits symbols entropy.\n");
	return entropy;
}

double entropy_16(unsigned short int array[], unsigned int array_length){
	if (verbose == 1) printf("Start of calculation of 16 bits symbols entropy.\n");
	if (verbose == 1) printf("Calculating the amount of symbols.\n");
	int n_symbols_16=count_symbols_16(array, array_length);
	if (verbose == 1) printf("Creating symbols list.\n");
	unsigned short int * symbols_16 = calloc(n_symbols_16, sizeof(unsigned short int));
	if (NULL == symbols_16) {
	  printf("ERROR: memory allocation failed.\n");
	}
	list_symbols_16(array, array_length, symbols_16);
	if (verbose == 1) printf("Calculating symbols occourencies.\n");
	unsigned int * occ_16 = calloc(n_symbols_16, sizeof(unsigned int));
	if (NULL == occ_16) {
	  printf("ERROR: memory allocation failed.\n");
	}
	occ_symbols_16(array, array_length, symbols_16, n_symbols_16, occ_16);
	free(symbols_16);
	if (verbose == 1) printf("Calculating entropy.\n");
	double entropy = 0;

	for (int i = 0; i<n_symbols_16; i++){//i is the index of the considered symbol
		entropy = entropy - ((double)occ_16[i]/(double)array_length)*log2((double)occ_16[i]/(double)array_length);
	}
	free(occ_16);
	if (verbose == 1) printf("End of calculation of 16 bits symbols entropy.\n");
	return entropy;
}

double entropy_32(unsigned int array[], unsigned int array_length){
	if (verbose == 1) printf("Start of calculation of 32 bits symbols entropy.\n");
	if (verbose == 1) printf("Calculating the amount of symbols.\n");
	int n_symbols_32=count_symbols_32(array, array_length);
	if (verbose == 1) printf("Creating symbols list.\n");
	unsigned int * symbols_32 = calloc(n_symbols_32, sizeof(unsigned int));
	if (NULL == symbols_32) {
	  printf("ERROR: memory allocation failed.\n");
	}
	list_symbols_32(array, array_length, symbols_32);
	if (verbose == 1) printf("Calculating symbols occourencies.\n");
	unsigned int * occ_32 = calloc(n_symbols_32, sizeof(unsigned int));
	if (NULL == occ_32) {
	  printf("ERROR: memory allocation failed.\n");
	}
	occ_symbols_32(array, array_length, symbols_32, n_symbols_32, occ_32);
	free(symbols_32);
	if (verbose == 1) printf("Calculating entropy.\n");
	double entropy = 0;

	for (int i = 0; i<n_symbols_32; i++){//i is the index of the considered symbol
		entropy = entropy - ((double)occ_32[i]/(double)array_length)*log2((double)occ_32[i]/(double)array_length);
	}
	free(occ_32);
	if (verbose == 1) printf("End of calculation of 32 bits symbols entropy.\n");
	return entropy;
}

#define say() do{}while(0)

int r_l_encode_8(unsigned char array[], unsigned int array_length){ //, unsigned char escape, unsigned char r_l_array[], unsigned int r_l_array_length){
	if (verbose == 1) printf("Start of compression.\n");
	
	unsigned char * array_8 = calloc(length_8, sizeof(unsigned char));
	if (NULL == array_8) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}


	/*if (verbose == 1) printf("Calculating the amount of symbols.\n");
	int n_symbols_8=count_symbols_8(array, array_length);
	if (verbose == 1) printf("Creating symbols list.\n");
	unsigned char * symbols_8 = calloc(n_symbols_8, sizeof(unsigned char));
	if (NULL == symbols_8) {
	  printf("ERROR: memory allocation failed.\n");
	}
	list_symbols_8(array, array_length, symbols_8);
	int i, j, c;
	for (i = 0; i<symbols_length; i++){//i is the index of the considered symbol
		c=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols[i])
			{
				c=c+1;
			}else{
				if (c > occ[i])
				{
					occ[i] = c;
				}
				c=0;
			}
		}
	}*/
	return 0;
}


int main (void){
	int factor=1;
	unsigned int length_8=factor*RECON_1_LENGHT;


	unsigned char * array_8 = calloc(length_8, sizeof(unsigned char));
	if (NULL == array_8) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	for (int i = 0; i < length_8; i++)
	{
		array_8[i]=recon_1_array[i % RECON_1_LENGHT];
	}

	unsigned int length_16=length_8/2;
	unsigned short int * array_16 = (unsigned short int *) array_8;
	unsigned int length_32=length_8/4;
	unsigned int * array_32 = (unsigned int *) array_8;

///////////////////////////////////////////////////////////////////////

	int n_symbols_8=count_symbols_8(array_8, length_8);
	printf("Simbols 8: %d out of %d \n", n_symbols_8, length_8);

	printf("Entropy 8: %lf \n", entropy_8(array_8, length_8));

/*	unsigned char * symbols_8 = calloc(n_symbols_8, sizeof(unsigned char));
	if (NULL == symbols_8) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	list_symbols_8(array_8, length_8, symbols_8);

	unsigned int * occ_8 = calloc(n_symbols_8, sizeof(unsigned int));
	if (NULL == occ_8) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	max_seq_symbols_8(array_8, length_8, symbols_8, n_symbols_8, occ_8);

	for (int i = 0; i < n_symbols_8; i++)
	{
		if (occ_8[i]>3)
		{
			printf("%02X:%d \n", symbols_8[i], occ_8[i]);
		}
	}
*/	printf("\n");
	

//////////////////////////////////////////////////////////////////////

	int n_symbols_16=count_symbols_16(array_16, length_16);
	printf("Simbols 16: %d out of %d \n", n_symbols_16, length_16);

	printf("Entropy 16: %lf \n", entropy_16(array_16, length_16));

/*	unsigned short int * symbols_16 = calloc(n_symbols_16, sizeof(unsigned short int));
	if (NULL == symbols_16) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	list_symbols_16(array_16, length_16, symbols_16);

	unsigned int * occ_16 = calloc(n_symbols_16, sizeof(unsigned int));
	if (NULL == occ_16) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	max_seq_symbols_16(array_16, length_16, symbols_16, n_symbols_16, occ_16);

	for (int i = 0; i < n_symbols_16; i++)
	{
		if (occ_16[i]>3)
		{
			printf("%04X:%d \n", symbols_16[i], occ_16[i]);
		}
	}
*/	printf("\n");

///////////////////////////////////////////////////////////////////////

	int n_symbols_32=count_symbols_32(array_32, length_32);
	printf("Simbols 32: %d out of %d \n", n_symbols_32, length_32);

	printf("Entropy 32: %lf \n", entropy_32(array_32, length_32));

/*	unsigned int * symbols_32 = calloc(n_symbols_32, sizeof(unsigned int));
	if (NULL == symbols_32) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	list_symbols_32(array_32, length_32, symbols_32);

	unsigned int * occ_32 = calloc(n_symbols_32, sizeof(unsigned int));
	if (NULL == occ_32) {
	  printf("ERROR: malloc failed!!\n");
	  return(-1);
	}

	max_seq_symbols_32(array_32, length_32, symbols_32, n_symbols_32, occ_32);

	for (int i = 0; i < n_symbols_32; i++)
	{
		if (occ_32[i]>3)
		{
			printf("%08X:%d \n", symbols_32[i], occ_32[i]);
		}
	}
*/	printf("\n");

	free(array_8);

	return 0;
}
