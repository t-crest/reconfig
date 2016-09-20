/*
   Copyright Technical University of Denmark. All rights reserved.
   This file is part of the T-CREST project.
   
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:
   
      1. Redistributions of source code must retain the above copyright notice,
         this list of conditions and the following disclaimer.
   
      2. Redistributions in binary form must reproduce the above copyright
         notice, this list of conditions and the following disclaimer in the
         documentation and/or other materials provided with the distribution.
   
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ``AS IS'' AND ANY EXPRESS
   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
   NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
   DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
   ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
   THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
   
   The views and conclusions contained in the software and documentation are
   those of the authors and should not be interpreted as representing official
   policies, either expressed or implied, of the copyright holder. 
*/

/*
   Description: ??
   
   Author: Luca Pezzarossa (lpez@dtu.dk)
   
   Version:
      1.0 - First functional version
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

static const unsigned char BitSwappTable[] = {
  0x00, 0x80, 0x40, 0xC0, 0x20, 0xA0, 0x60, 0xE0, 0x10, 0x90, 0x50, 0xD0, 0x30, 0xB0, 0x70, 0xF0, 
  0x08, 0x88, 0x48, 0xC8, 0x28, 0xA8, 0x68, 0xE8, 0x18, 0x98, 0x58, 0xD8, 0x38, 0xB8, 0x78, 0xF8, 
  0x04, 0x84, 0x44, 0xC4, 0x24, 0xA4, 0x64, 0xE4, 0x14, 0x94, 0x54, 0xD4, 0x34, 0xB4, 0x74, 0xF4, 
  0x0C, 0x8C, 0x4C, 0xCC, 0x2C, 0xAC, 0x6C, 0xEC, 0x1C, 0x9C, 0x5C, 0xDC, 0x3C, 0xBC, 0x7C, 0xFC, 
  0x02, 0x82, 0x42, 0xC2, 0x22, 0xA2, 0x62, 0xE2, 0x12, 0x92, 0x52, 0xD2, 0x32, 0xB2, 0x72, 0xF2, 
  0x0A, 0x8A, 0x4A, 0xCA, 0x2A, 0xAA, 0x6A, 0xEA, 0x1A, 0x9A, 0x5A, 0xDA, 0x3A, 0xBA, 0x7A, 0xFA,
  0x06, 0x86, 0x46, 0xC6, 0x26, 0xA6, 0x66, 0xE6, 0x16, 0x96, 0x56, 0xD6, 0x36, 0xB6, 0x76, 0xF6, 
  0x0E, 0x8E, 0x4E, 0xCE, 0x2E, 0xAE, 0x6E, 0xEE, 0x1E, 0x9E, 0x5E, 0xDE, 0x3E, 0xBE, 0x7E, 0xFE,
  0x01, 0x81, 0x41, 0xC1, 0x21, 0xA1, 0x61, 0xE1, 0x11, 0x91, 0x51, 0xD1, 0x31, 0xB1, 0x71, 0xF1,
  0x09, 0x89, 0x49, 0xC9, 0x29, 0xA9, 0x69, 0xE9, 0x19, 0x99, 0x59, 0xD9, 0x39, 0xB9, 0x79, 0xF9, 
  0x05, 0x85, 0x45, 0xC5, 0x25, 0xA5, 0x65, 0xE5, 0x15, 0x95, 0x55, 0xD5, 0x35, 0xB5, 0x75, 0xF5,
  0x0D, 0x8D, 0x4D, 0xCD, 0x2D, 0xAD, 0x6D, 0xED, 0x1D, 0x9D, 0x5D, 0xDD, 0x3D, 0xBD, 0x7D, 0xFD,
  0x03, 0x83, 0x43, 0xC3, 0x23, 0xA3, 0x63, 0xE3, 0x13, 0x93, 0x53, 0xD3, 0x33, 0xB3, 0x73, 0xF3, 
  0x0B, 0x8B, 0x4B, 0xCB, 0x2B, 0xAB, 0x6B, 0xEB, 0x1B, 0x9B, 0x5B, 0xDB, 0x3B, 0xBB, 0x7B, 0xFB,
  0x07, 0x87, 0x47, 0xC7, 0x27, 0xA7, 0x67, 0xE7, 0x17, 0x97, 0x57, 0xD7, 0x37, 0xB7, 0x77, 0xF7, 
  0x0F, 0x8F, 0x4F, 0xCF, 0x2F, 0xAF, 0x6F, 0xEF, 0x1F, 0x9F, 0x5F, 0xDF, 0x3F, 0xBF, 0x7F, 0xFF
};

//Please define binaries if you want the pure binary version of the compressed bitfiles and not only the C file
//#define BINARIES

#define BRAM_INITIAL_PENALTY 2
#define BRAM_FINAL_PENALTY 1
#define BRAM_R_W_PENALTY 1

#define CPU_INITIAL_PENALTY 2
#define CPU_FINAL_PENALTY 1
#define CPU_OCP_W_PENALTY 2
#define CPU_W_PENALTY 1

#define RECONFIGURATION_PENALTY 0

#define ESCAPE 1

double entropy_8(unsigned char array[], unsigned int array_length){
	// Start of calculation of 8 bits symbols entropy.
	// Calculating the amount of symbols.
	int n_symbols_8=1;
	int i, j, k, f, o;
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
		n_symbols_8=n_symbols_8+f;
	}

	// Creating symbols list.
	unsigned char * symbols_8 = calloc(n_symbols_8, sizeof(unsigned char));
	if (NULL == symbols_8) {
	  printf("Dynamic memory allocation for entropy calculation failed.\n");
	}
	symbols_8[0]=array[0];
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
			symbols_8[k]=array[i];
			k=k+1;
		}
	}

	// Calculating symbols occourencies.
	unsigned int * occ_8 = calloc(n_symbols_8, sizeof(unsigned int));
	if (NULL == occ_8) {
		printf("Dynamic memory allocation for entropy calculation failed.\n");
	}
	for (i = 0; i<n_symbols_8; i++){//i is the index of the considered symbol
		occ_8[i]=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols_8[i])
			{
				occ_8[i] = occ_8[i]+1;
			}
		}
	}
	free(symbols_8);
	symbols_8 = NULL;

	// Calculating entropy.
	double entropy = 0;

	for (i = 0; i<n_symbols_8; i++){//i is the index of the considered symbol
		entropy = entropy - ((double)occ_8[i]/(double)array_length)*log2((double)occ_8[i]/(double)array_length);
	}
	free(occ_8);
	occ_8 = NULL;
	// End of calculation of 8 bits symbols entropy.
	return entropy;
}

double entropy_16(unsigned short array[], unsigned int array_length){
	// Start of calculation of 16 bits symbols entropy.
	// Calculating the amount of symbols.
	int n_symbols_16=1;
	int i, j, k, f, o;
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
		n_symbols_16=n_symbols_16+f;
	}

	// Creating symbols list.
	unsigned short * symbols_16 = calloc(n_symbols_16, sizeof(unsigned short));
	if (NULL == symbols_16) {
	  printf("Dynamic memory allocation for entropy calculation failed.\n");
	}
	symbols_16[0]=array[0];
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
			symbols_16[k]=array[i];
			k=k+1;
		}
	}

	// Calculating symbols occourencies.
	unsigned int * occ_16 = calloc(n_symbols_16, sizeof(unsigned int));
	if (NULL == occ_16) {
		printf("Dynamic memory allocation for entropy calculation failed.\n");
	}
	for (i = 0; i<n_symbols_16; i++){//i is the index of the considered symbol
		occ_16[i]=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols_16[i])
			{
				occ_16[i] = occ_16[i]+1;
			}
		}
	}
	free(symbols_16);

	// Calculating entropy.
	double entropy = 0;

	for (i = 0; i<n_symbols_16; i++){//i is the index of the considered symbol
		entropy = entropy - ((double)occ_16[i]/(double)array_length)*log2((double)occ_16[i]/(double)array_length);
	}
	free(occ_16);
	// End of calculation of 16 bits symbols entropy.
	return entropy;
}

double entropy_32(unsigned int array[], unsigned int array_length){
	// Start of calculation of 16 bits symbols entropy.
	// Calculating the amount of symbols.
	int n_symbols_32=1;
	int i, j, k, f, o;
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
		n_symbols_32=n_symbols_32+f;
	}

	// Creating symbols list.
	unsigned int * symbols_32 = calloc(n_symbols_32, sizeof(unsigned int));
	if (NULL == symbols_32) {
	  printf("Dynamic memory allocation for entropy calculation failed.\n");
	}
	symbols_32[0]=array[0];
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
			symbols_32[k]=array[i];
			k=k+1;
		}
	}

	// Calculating symbols occourencies.
	unsigned int * occ_32 = calloc(n_symbols_32, sizeof(unsigned int));
	if (NULL == occ_32) {
		printf("Dynamic memory allocation for entropy calculation failed.\n");
	}
	for (i = 0; i<n_symbols_32; i++){//i is the index of the considered symbol
		occ_32[i]=0;
		for (j = 0; j < array_length; j++)//j swaps the array
		{
			if (array[j] == symbols_32[i])
			{
				occ_32[i] = occ_32[i]+1;
			}
		}
	}
	free(symbols_32);

	// Calculating entropy.
	double entropy = 0;

	for (i = 0; i<n_symbols_32; i++){//i is the index of the considered symbol
		entropy = entropy - ((double)occ_32[i]/(double)array_length)*log2((double)occ_32[i]/(double)array_length);
	}
	free(occ_32);
	// End of calculation of 32 bits symbols entropy.
	return entropy;
}

int wcet_bram_8(unsigned char array[], unsigned int array_length){
	//int i, j, o;
	unsigned char escape = ESCAPE; //need to be a parameter
	int wcet=0;

	wcet=wcet+BRAM_INITIAL_PENALTY+BRAM_FINAL_PENALTY+RECONFIGURATION_PENALTY;

	for (int i=0; i<array_length-2; i++){//the last cannot be an escape
		if (array[i] != escape){
			wcet=wcet+BRAM_R_W_PENALTY;
		}else{
			if (array[i+1] == escape ){
				wcet=wcet+2*BRAM_R_W_PENALTY;// in need to read the two caracters (one will not be used)
				i++; //skip one round
			}else{
				wcet=wcet+2*BRAM_R_W_PENALTY;// I need to red the escape
				wcet=wcet+(array[i+1]+1)*BRAM_R_W_PENALTY;
				i++;
				i++; //skip two rounds 
			}
		}
	}
	wcet=wcet+BRAM_R_W_PENALTY;//for the last data not considered in the for loop
	return wcet;
}

int wcet_bram_16(unsigned short array[], unsigned int array_length){
	//int i, j, o;
	unsigned short escape = ESCAPE; //need to be a parameter
	int wcet=0;

	wcet=wcet+BRAM_INITIAL_PENALTY+BRAM_FINAL_PENALTY+RECONFIGURATION_PENALTY;

	for (int i=0; i<array_length-2; i++){//the last cannot be an escape
		if (array[i] != escape){
			wcet=wcet+BRAM_R_W_PENALTY;
		}else{
			if (array[i+1] == escape ){
				wcet=wcet+2*BRAM_R_W_PENALTY;// in need to read the two caracters (one will not be used)
				i++; //skip one round
			}else{
				wcet=wcet+2*BRAM_R_W_PENALTY;// I need to red the escape
				wcet=wcet+(array[i+1]+1)*BRAM_R_W_PENALTY;
				i++;
				i++; //skip two rounds 
			}
		}
	}
	wcet=wcet+BRAM_R_W_PENALTY;//for the last data not considered in the for loop
	return wcet;
}

int wcet_bram_32(unsigned int array[], unsigned int array_length){
	//int i, j, o;
	unsigned int escape = ESCAPE; //need to be a parameter
	int wcet=0;

	wcet=wcet+BRAM_INITIAL_PENALTY+BRAM_FINAL_PENALTY+RECONFIGURATION_PENALTY;

	for (int i=0; i<array_length-2; i++){//the last cannot be an escape
		if (array[i] != escape){
			wcet=wcet+BRAM_R_W_PENALTY;
		}else{
			if (array[i+1] == escape ){
				wcet=wcet+2*BRAM_R_W_PENALTY;// in need to read the two caracters (one will not be used)
				i++; //skip one round
			}else{
				wcet=wcet+2*BRAM_R_W_PENALTY;// I need to red the escape and the count
				wcet=wcet+(array[i+1]+1)*BRAM_R_W_PENALTY;
				i++;
				i++; //skip two rounds 
			}
		}
	}
	wcet=wcet+BRAM_R_W_PENALTY;//for the last data not considered in the for loop
	return wcet;
}

int wcet_cpu_8(unsigned char array[], unsigned int array_length){
	//int i, j, o;
	unsigned char escape = ESCAPE; //need to be a parameter
	int wcet=0;

	wcet=wcet+CPU_INITIAL_PENALTY+CPU_FINAL_PENALTY+RECONFIGURATION_PENALTY;

	for (int i=0; i<array_length-2; i++){//the last cannot be an escape
		if (array[i] != escape){
			wcet=wcet+CPU_OCP_W_PENALTY;
		}else{
			if (array[i+1] == escape ){
				wcet=wcet+2*CPU_OCP_W_PENALTY;// in need to read the two caracters (one will not be used)
				i++; //skip one round
			}else{
				wcet=wcet+3*CPU_OCP_W_PENALTY;// I need to read the escape and the two follwing
				wcet=wcet+(array[i+1]+1-1)*CPU_W_PENALTY;//stalling the ocp for the icap witing time
				i++;
				i++; //skip two rounds 
			}
		}
	}
	wcet=wcet+BRAM_R_W_PENALTY;//for the last data not considered in the for loop
	return wcet;
}

int wcet_cpu_16(unsigned short array[], unsigned int array_length){
	//int i, j, o;
	unsigned short escape = ESCAPE; //need to be a parameter
	int wcet=0;

	wcet=wcet+CPU_INITIAL_PENALTY+CPU_FINAL_PENALTY+RECONFIGURATION_PENALTY;

	for (int i=0; i<array_length-2; i++){//the last cannot be an escape
		if (array[i] != escape){
			wcet=wcet+CPU_OCP_W_PENALTY;
		}else{
			if (array[i+1] == escape ){
				wcet=wcet+2*CPU_OCP_W_PENALTY;// in need to read the two caracters (one will not be used)
				i++; //skip one round
			}else{
				wcet=wcet+3*CPU_OCP_W_PENALTY;// I need to read the escape and the two follwing
				wcet=wcet+(array[i+1]+1-1)*CPU_W_PENALTY;//stalling the ocp for the icap witing time
				i++;
				i++; //skip two rounds 
			}
		}
	}
	wcet=wcet+BRAM_R_W_PENALTY;//for the last data not considered in the for loop
	return wcet;
}

int wcet_cpu_32(unsigned int array[], unsigned int array_length){
	//int i, j, o;
	unsigned int escape = ESCAPE; //need to be a parameter
	int wcet=0;

	wcet=wcet+CPU_INITIAL_PENALTY+CPU_FINAL_PENALTY+RECONFIGURATION_PENALTY;

	for (int i=0; i<array_length-2; i++){//the last cannot be an escape
		if (array[i] != escape){
			wcet=wcet+CPU_OCP_W_PENALTY;
		}else{
			if (array[i+1] == escape ){
				wcet=wcet+2*CPU_OCP_W_PENALTY;// in need to read the two caracters (one will not be used)
				i++; //skip one round
			}else{
				wcet=wcet+3*CPU_OCP_W_PENALTY;// I need to read the escape and the two follwing
				wcet=wcet+(array[i+1]+1-1)*CPU_W_PENALTY;//stalling the ocp for the icap witing time
				i++;
				i++; //skip two rounds 
			}
		}
	}
	wcet=wcet+BRAM_R_W_PENALTY;//for the last data not considered in the for loop
	return wcet;
}

int lre_8(unsigned char array[], unsigned int * array_length){
	int i, j, o;
	int symbols_occ_limit=255; //
	unsigned char escape = ESCAPE; //need to be a parameter

	//Allocating memory space for the symbols and occourrencies arrays
	unsigned char * symbols_8 = calloc(*array_length, sizeof(unsigned char));
	unsigned int * symbols_occ_8 = calloc(*array_length, sizeof(unsigned int));
	o=1;
	j=0;
	for (i=0; i<*array_length-1; i++){
		if (array[i] == array[i+1]){
			o++;
		}else{
			//store the result
			symbols_8[j] = array[i];
			symbols_occ_8[j] = o;
			j++;
			o=1;
		}
	}
	symbols_8[j] = array[*array_length-1];
	int symbols_8_length = j+1;
	//working on the last 2 elements
	if(array[*array_length-2] == array[*array_length-1]){
		symbols_occ_8[j] = o;
	}else{
		symbols_occ_8[j] = 1;
	}
	//compress
	i=0;
	for (j = 0; j < symbols_8_length; j++)
	{
		if (symbols_occ_8[j]==1){
			if (symbols_8[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				i=i+2;
			}else{
				array[i]=symbols_8[j];
				i=i+1;
			}
		}
		if (symbols_occ_8[j]==2){
			if (symbols_8[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				array[i+2]=escape;
				array[i+3]=escape;
				i=i+4;
			}else{
				array[i]=symbols_8[j];
				array[i+1]=symbols_8[j];
				i=i+2;
			}
		}
		if (symbols_occ_8[j]==3){
			if (symbols_8[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				array[i+2]=escape;
				array[i+3]=escape;
				array[i+4]=escape;
				array[i+5]=escape;
				i=i+6;
			}else{
				array[i]=symbols_8[j];
				array[i+1]=symbols_8[j];
				array[i+2]=symbols_8[j];
				i=i+3;
			}
		}
		if (symbols_occ_8[j]>3){
			
			if (symbols_8[j]==escape)
			{
				for (int k = 0; k < symbols_occ_8[j]; k++)
				{
					array[i]=escape;
					array[i+1]=escape;
					i=i+2;
				}
			}else if(symbols_occ_8[j]<=symbols_occ_limit){
				array[i]=escape;
				array[i+1]=symbols_occ_8[j]-1;
				array[i+2]=symbols_8[j];
				i=i+3;
			}else{
				array[i]=escape;
				array[i+1]=symbols_occ_limit-1;
				array[i+2]=symbols_8[j];
				i=i+3;
				symbols_occ_8[j]=symbols_occ_8[j]-symbols_occ_limit;
				j=j-1;//repeat the loop for the same j
			}
		}
	}
	*array_length = i;

	free(symbols_8);
	free(symbols_occ_8);
	return 0;
}

int lre_16(unsigned short array[], unsigned int * array_length){
	int i, j, o;
	int symbols_occ_limit=255; //
	unsigned short escape = ESCAPE; //need to be a parameter

	//Allocating memory space for the symbols and occourrencies arrays
	unsigned short * symbols_16 = calloc(*array_length, sizeof(unsigned char));
	unsigned int * symbols_occ_16 = calloc(*array_length, sizeof(unsigned int));
	o=1;
	j=0;
	for (i=0; i<*array_length-1; i++){
		if (array[i] == array[i+1]){
			o++;
		}else{
			//store the result
			symbols_16[j] = array[i];
			symbols_occ_16[j] = o;
			j++;
			o=1;
		}
	}
	symbols_16[j] = array[*array_length-1];
	int symbols_16_length = j+1;
	//working on the last 2 elements
	if(array[*array_length-2] == array[*array_length-1]){
		symbols_occ_16[j] = o;
	}else{
		symbols_occ_16[j] = 1;
	}
	//compress
	i=0;
	for (j = 0; j < symbols_16_length; j++)
	{
		if (symbols_occ_16[j]==1){
			if (symbols_16[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				i=i+2;
			}else{
				array[i]=symbols_16[j];
				i=i+1;
			}
		}
		if (symbols_occ_16[j]==2){
			if (symbols_16[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				array[i+2]=escape;
				array[i+3]=escape;
				i=i+4;
			}else{
				array[i]=symbols_16[j];
				array[i+1]=symbols_16[j];
				i=i+2;
			}
		}
		if (symbols_occ_16[j]==3){
			if (symbols_16[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				array[i+2]=escape;
				array[i+3]=escape;
				array[i+4]=escape;
				array[i+5]=escape;
				i=i+6;
			}else{
				array[i]=symbols_16[j];
				array[i+1]=symbols_16[j];
				array[i+2]=symbols_16[j];
				i=i+3;
			}
		}
		if (symbols_occ_16[j]>3){
			
			if (symbols_16[j]==escape)
			{
				for (int k = 0; k < symbols_occ_16[j]; k++)
				{
					array[i]=escape;
					array[i+1]=escape;
					i=i+2;
				}
			}else if(symbols_occ_16[j]<=symbols_occ_limit){
				array[i]=escape;
				array[i+1]=symbols_occ_16[j]-1;
				array[i+2]=symbols_16[j];
				i=i+3;
			}else{
				array[i]=escape;
				array[i+1]=symbols_occ_limit-1;
				array[i+2]=symbols_16[j];
				i=i+3;
				symbols_occ_16[j]=symbols_occ_16[j]-symbols_occ_limit;
				j=j-1;//repeat the loop for the same j
			}
		}
	}
	*array_length = i;

	free(symbols_16);
	free(symbols_occ_16);
	return 0;
}

int lre_32(unsigned int array[], unsigned int * array_length){
	int i, j, o;
	int symbols_occ_limit=255; //
	unsigned int escape = ESCAPE; //need to be a parameter

	//Allocating memory space for the symbols and occourrencies arrays
	unsigned int * symbols_32 = calloc(*array_length, sizeof(unsigned int));
	unsigned int * symbols_occ_32 = calloc(*array_length, sizeof(unsigned int));
	o=1;
	j=0;
	for (i=0; i<*array_length-1; i++){
		if (array[i] == array[i+1]){
			o++;
		}else{
			//store the result
			symbols_32[j] = array[i];
			symbols_occ_32[j] = o;
			j++;
			o=1;
		}
	}
	symbols_32[j] = array[*array_length-1];
	int symbols_32_length = j+1;
	//working on the last 2 elements
	if(array[*array_length-2] == array[*array_length-1]){
		symbols_occ_32[j] = o;
	}else{
		symbols_occ_32[j] = 1;
	}
	//compress
	i=0;
	for (j = 0; j < symbols_32_length; j++)
	{
		if (symbols_occ_32[j]==1){
			if (symbols_32[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				i=i+2;
			}else{
				array[i]=symbols_32[j];
				i=i+1;
			}
		}
		if (symbols_occ_32[j]==2){
			if (symbols_32[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				array[i+2]=escape;
				array[i+3]=escape;
				i=i+4;
			}else{
				array[i]=symbols_32[j];
				array[i+1]=symbols_32[j];
				i=i+2;
			}
		}
		if (symbols_occ_32[j]==3){
			if (symbols_32[j]==escape)
			{
				array[i]=escape;
				array[i+1]=escape;
				array[i+2]=escape;
				array[i+3]=escape;
				array[i+4]=escape;
				array[i+5]=escape;
				i=i+6;
			}else{
				array[i]=symbols_32[j];
				array[i+1]=symbols_32[j];
				array[i+2]=symbols_32[j];
				i=i+3;
			}
		}
		if (symbols_occ_32[j]>3){
			
			if (symbols_32[j]==escape)
			{
				for (int k = 0; k < symbols_occ_32[j]; k++)
				{
					array[i]=escape;
					array[i+1]=escape;
					i=i+2;
				}
			}else if(symbols_occ_32[j]<=symbols_occ_limit){
				array[i]=escape;
				array[i+1]=symbols_occ_32[j]-1;
				array[i+2]=symbols_32[j];
				i=i+3;
			}else{
				array[i]=escape;
				array[i+1]=symbols_occ_limit-1;
				array[i+2]=symbols_32[j];
				i=i+3;
				symbols_occ_32[j]=symbols_occ_32[j]-symbols_occ_limit;
				j=j-1;//repeat the loop for the same j
			}
		}
	}
	*array_length = i;

	free(symbols_32);
	free(symbols_occ_32);
	return 0;
}

int addBitFile(int datasize, bool compression, bool bitswapped, char * outfilename, char * id, char * bitfilename){
	FILE * bitfile = NULL;
	FILE * outfile = NULL;
	FILE * outfilebin = NULL;
	//counting the file in bytes
	bitfile = fopen(bitfilename, "r");
	if (NULL == bitfile){
		printf("File opening failed.\n");
		return(-1);
	}
	int bitfilesize = 0;
	while(fgetc( bitfile ) != EOF) bitfilesize++;
		printf("  - raw bitfile size = %d bytes\n", bitfilesize);
	if (fclose(bitfile)!=0) {
		printf("File closing failed.\n");
		return(-1);
	}
	//reading the file content and storing it in memory
	unsigned char * bitfile_8 = calloc(bitfilesize, sizeof(unsigned char));
	if (NULL == bitfile_8){
		printf("Dynamic memory allocation for bitfile conversion failed.\n");
		return(-1);
	}

	bitfile = fopen(bitfilename, "r");
	if (NULL == bitfile){
		printf("File opening failed.\n");
		return(-1);
	}
	for (int i = 0; i < bitfilesize; i++)
		{
			bitfile_8[i] =(unsigned char)(fgetc(bitfile));
		}
	if (fclose(bitfile)!=0) {
		printf("File closing failed.\n");
		return(-1);
	}

	//performing bitswapping if selected
	if (bitswapped){
		for (int i = 0; i < bitfilesize; i++)
		{
			bitfile_8[i]=BitSwappTable[bitfile_8[i]];
		}
	}

	//now the actions depends on the datasize
	if (datasize==8){
		if (compression){
			printf("  - 8-bit based entropy = %lf bit\n  - optimum compression = %.1lf percent\n", entropy_8(bitfile_8, bitfilesize), 100*(8-entropy_8(bitfile_8, bitfilesize))/8);
			int old_bitfilesize = bitfilesize;
			lre_8(bitfile_8, &bitfilesize);
			printf("  - compressed bitfile size = %d bytes\n", bitfilesize);
			printf("  - real compression = %.1lf percent\n", 100*((double)old_bitfilesize-(double)bitfilesize)/(double)old_bitfilesize);
			printf("  - BRAM-stream WCET = %d clock cycles\n", wcet_bram_8(bitfile_8, bitfilesize));
			printf("  - CPU-stream WCET = %d clock cycles\n", wcet_cpu_8(bitfile_8, bitfilesize));
		}
		outfile = fopen(outfilename, "a+");
		if (NULL == outfile){
			printf("File opening failed.\n");
			return(-1);
		}
		fprintf(outfile, "const unsigned int %s_length = %d;\n", id, bitfilesize);
		fprintf(outfile, "const unsigned char %s[%d] = {",id , bitfilesize);
		for (int i = 0; i < bitfilesize; i++)
		{
			if (i != bitfilesize-1)
			{
				fprintf(outfile, "%u, ", (unsigned int)bitfile_8[i]);//N.B. the endian (big/little) may be wrong --in python is big/* code */
			}else{
				fprintf(outfile, "%u};\n\n", (unsigned int)bitfile_8[i]);//N.B. the endian (big/little) may be wrong --in python is big
			}
		}

		fclose(outfile);

		#if defined (BINARIES)
			//generating pure binaries		
			outfilebin = fopen(id, "wb");
			if (NULL == outfilebin){
				printf("File opening failed.\n");
				return(-1);
			}
			fwrite(bitfile_8, 1, bitfilesize, outfile);
			if (fclose(outfilebin) != 0) {
				printf("File closing failed.\n");
				return(-1);
			}
		#endif

		free(bitfile_8);
	}
	if (datasize==16){
		//create 16 bit copy
		unsigned short * bitfile_16 = calloc(bitfilesize/2, sizeof(unsigned short));
		if (NULL == bitfile_16){
			printf("Dynamic memory allocation for bitfile conversion failed.\n");
			return(-1);
		}
		for (int i = 0; i < bitfilesize/2; i++)
		{
			bitfile_16[i] = ((((unsigned short) bitfile_8[2*i]) << 8) & 0xFF00) | (((unsigned short) bitfile_8[2*i+1]) & 0x00FF); //modifiy here if endiannes is not ok
		}
		free(bitfile_8);

		if (compression){
			printf("  - 16-bit based entropy = %lf bit\n  - optimum compression = %.1lf percent\n", entropy_16(bitfile_16, bitfilesize/2), 100*(16-entropy_16(bitfile_16, bitfilesize/2))/16);
			//lre_16(bitfile_16, bitfilesize/2);
			int old_bitfilesize = bitfilesize;
			int bitfilesize_16 = bitfilesize/2;
			lre_16(bitfile_16, &bitfilesize_16);
			bitfilesize = bitfilesize_16*2;
			printf("  - compressed bitfile size = %d bytes\n", bitfilesize);
			printf("  - real compression = %.1lf percent\n", 100*((double)old_bitfilesize-(double)bitfilesize)/(double)old_bitfilesize);
			printf("  - BRAM-stream WCET = %d clock cycles\n", wcet_bram_16(bitfile_16, bitfilesize_16));
			printf("  - CPU-stream WCET = %d clock cycles\n", wcet_cpu_16(bitfile_16, bitfilesize_16));
		}

		outfile = fopen(outfilename, "a+");
		if (NULL == outfile){
			printf("File opening failed.\n");
			return(-1);
		}
		fprintf(outfile, "const unsigned int %s_length = %d;\n", id, bitfilesize/2);
		fprintf(outfile, "const unsigned short %s[%d] = {",id , bitfilesize/2);
		for (int i = 0; i < bitfilesize/2; i++)
		{
			if (i != bitfilesize/2-1)
			{
				fprintf(outfile, "%u, ", bitfile_16[i]);
			}else{
				fprintf(outfile, "%u};\n\n", bitfile_16[i]);
			}
		}
		fclose(outfile);
		
		#if defined (BINARIES)
			//generating pure binaries		
			outfilebin = fopen(id, "wb");
			if (NULL == outfilebin){
				printf("File opening failed.\n");
				return(-1);
			}
			fwrite(bitfile_16, 2, bitfilesize/2, outfile);
			if (fclose(outfilebin) != 0) {
				printf("File closing failed.\n");
				return(-1);
			}
		#endif

		free(bitfile_16);
		
	}
	if (datasize==32){
		//create 32 bit copy

		unsigned int * bitfile_32 = calloc(bitfilesize/4, sizeof(unsigned int));
		if (NULL == bitfile_32){
			printf("Dynamic memory allocation for bitfile conversion failed.\n");
			return(-1);
		}
		for (int i = 0; i < bitfilesize/4; i++)
		{
			bitfile_32[i] = ((((unsigned int) bitfile_8[4*i]) << 24) & 0xFF000000) | ((((unsigned int) bitfile_8[4*i+1]) << 16) & 0x00FF0000) | ((((unsigned int) bitfile_8[4*i+2]) << 8) & 0x0000FF00) | (((unsigned int) bitfile_8[4*i+3]) & 0x000000FF);
		}
		free(bitfile_8);

		if (compression){
			printf("  - 32-bit based entropy = %lf bit\n  - optimum compression = %.1lf percent\n", entropy_32(bitfile_32, bitfilesize/4), 100*(32-entropy_32(bitfile_32, bitfilesize/4))/32);
			//lre_32(bitfile_32, bitfilesize/4);
			int old_bitfilesize = bitfilesize;
			int bitfilesize_32 = bitfilesize/4;
			lre_32(bitfile_32, &bitfilesize_32);
			bitfilesize = bitfilesize_32*4;
			printf("  - compressed bitfile size = %d bytes\n", bitfilesize);
			printf("  - real compression = %.1lf percent\n", 100*((double)old_bitfilesize-(double)bitfilesize)/(double)old_bitfilesize);
			printf("  - BRAM-stream WCET = %d clock cycles\n", wcet_bram_32(bitfile_32, bitfilesize_32));
			printf("  - CPU-stream WCET = %d clock cycles\n", wcet_cpu_32(bitfile_32, bitfilesize_32));
		}
		outfile = fopen(outfilename, "a+");
		if (NULL == outfile){
			printf("File opening failed.\n");
			return(-1);
		}
		fprintf(outfile, "const unsigned int %s_length = %d;\n", id, bitfilesize/4);
		//printf("\nDEBUG !!!!\n\n");
		fprintf(outfile, "const unsigned int %s[%d] = {",id , bitfilesize/4);

		for (int i = 0; i < bitfilesize/4; i++)
		{
			if (i != bitfilesize/4-1)
			{
				fprintf(outfile, "%u, ", bitfile_32[i]);
			}else{
				fprintf(outfile, "%u};\n\n", bitfile_32[i]);
			}
		}
		fclose(outfile);

		#if defined (BINARIES)
			//generating pure binaries		
			outfilebin = fopen(id, "wb");
			if (NULL == outfilebin){
				printf("File opening failed.\n");
				return(-1);
			}
			fwrite(bitfile_32, 4, bitfilesize/4, outfile);
			if (fclose(outfilebin) != 0) {
				printf("File closing failed.\n");
				return(-1);
			}
		#endif

		free(bitfile_32);	
		}
		

	return(0);
}

static int parseXmlFile(char * xmlfilename, char * outfilename) {
	xmlDocPtr doc = NULL;
	xmlNodePtr cur = NULL;
	int tmp;
	int datasize = 32;
	bool compression = false;
	bool bitswapped = false;
	FILE *fp;
	//xmlChar * prop;
	doc = xmlParseFile(xmlfilename);

	if (doc == NULL ) {
		printf("XML file not parsed successfully.\n");
		return (-1);
	}
	
	cur = xmlDocGetRootElement(doc);
	if (cur == NULL) {
		printf("XML file empty.\n");
		xmlFreeDoc(doc);
		return (-1);
	}
	if (xmlStrcmp(cur->name, (const xmlChar *) "bitfiles")) {
		printf("XML file of the wrong type, the root node is not 'bitfiles'.\n");
		xmlFreeDoc(doc);
		return (-1);
	}

	//Search for Description and print it out
	cur = cur->xmlChildrenNode;
	while (cur != NULL) {
			if ((!xmlStrcmp(cur->name, (const xmlChar *)"description"))){
				printf("Description: %s\n", xmlNodeListGetString(doc, cur->xmlChildrenNode, 1));
				//writing header
				fp = fopen(outfilename, "a+");
				if (NULL == fp){
					printf("File opening failed.\n");
					return(-1);
				}
				fprintf(fp, " * Description: %s\n *\n", xmlNodeListGetString(doc, cur->xmlChildrenNode, 1));
				if (fclose(fp) != 0) {
					printf("File closing failed.\n");
					return(-1);
				}
				break; //Only the first description is printed out.
		}
		cur = cur->next;
	}

	//Search for Parameters and print it out
	cur = xmlDocGetRootElement(doc);
	cur = cur->xmlChildrenNode;
	tmp = 0;
	while (cur != NULL) {
			if ((!xmlStrcmp(cur->name, (const xmlChar *)"parameters"))){
				if (!xmlStrcmp(xmlGetProp(cur, "datasize"), (const xmlChar *) "8")) {
					datasize = 8;
					tmp++;
				}
				if (!xmlStrcmp(xmlGetProp(cur, "datasize"), (const xmlChar *) "16")) {
					datasize = 16;
					tmp++;
				}
				if (!xmlStrcmp(xmlGetProp(cur, "datasize"), (const xmlChar *) "32")) {
					datasize = 32;
					tmp++;
				}

				if (!xmlStrcmp(xmlGetProp(cur, "compression"), (const xmlChar *) "true")) {
					compression = true;
					tmp++;
				}
				if (!xmlStrcmp(xmlGetProp(cur, "compression"), (const xmlChar *) "false")) {
					compression = false;
					tmp++;
				}

				if (!xmlStrcmp(xmlGetProp(cur, "bitswapped"), (const xmlChar *) "true")) {
					bitswapped = true;
					tmp++;
				}
				if (!xmlStrcmp(xmlGetProp(cur, "bitswapped"), (const xmlChar *) "false")) {
					bitswapped = false;
					tmp++;
				}
				break;
		}
		cur = cur->next;
	}
	
	if (tmp == 3){
		fp = fopen(outfilename, "a+");
		if (NULL == fp){
			printf("File opening failed.\n");
			return(-1);
		}
		printf("\nParameters:\n  - datasize = %d\n  - compression = ", datasize);
		fprintf(fp, " * Parameters:\n *  - datasize = %d\n *  - compression = ", datasize);
		if (compression){
			printf("enabled\n  - bitswapped = ");
			fprintf(fp, "enabled\n *  - bitswapped = ");
		}else{
			printf("disabled\n  - bitswapped = ");
			fprintf(fp, "disabled\n *  - bitswapped = ");
		}
		if (bitswapped){
			printf("enabled\n");
			fprintf(fp, "enabled\n *\n");
		}else{
			printf("disabled\n");
			fprintf(fp, "disabled\n *\n");
		}
		if (fclose(fp) != 0) {
			printf("File closing failed.\n");
			return(-1);
		}
	}else{
		printf("Impossible to retrive all the parameters in the XML file.\n");
		return(-1);
	}
	

	//Search for Bitfiles, count and print it out
	cur = xmlDocGetRootElement(doc);
	cur = cur->xmlChildrenNode;
	int tot = 0;
	while (cur != NULL) {
			if ((!xmlStrcmp(cur->name, (const xmlChar *)"bitfile"))){
				tot++;
		}
		cur = cur->next;
	}
	if (tot == 0){
		printf("\nThere are not bitfiles to process.\n");
		return(-1);
	}else{
		printf("\nThere are %d bitfile/s to process.\n", tot);
		fp = fopen(outfilename, "a+");
		if (NULL == fp){
			printf("File opening failed.\n");
			return(-1);
		}
		fprintf(fp, " * This file contains %d bitfile/s.\n */\n\n", tot);
		if (fclose(fp) != 0) {
			printf("File closing failed.\n");
			return(-1);
		}
	}

	//Start bitfile conversion
	cur = xmlDocGetRootElement(doc);
	cur = cur->xmlChildrenNode;
	tmp = 0;
	while (cur != NULL) {
		if ((!xmlStrcmp(cur->name, (const xmlChar *)"bitfile"))){
				tmp++;
				printf("\nProcessing bitfile %d of %d:\n  - id = %s\n  - file = %s\n", tmp, tot, xmlGetProp(cur, "id"), xmlGetProp(cur, "file"));
				fp = fopen(outfilename, "a+");
				if (NULL == fp){
					printf("File opening failed.\n");
					return(-1);
				}
				fprintf(fp,"/*\n * Bitfile %d of %d:\n *  - id = %s\n *  - file = %s\n */\n", tmp, tot, xmlGetProp(cur, "id"), xmlGetProp(cur, "file"));
				if (fclose(fp) != 0) {
					printf("File closing failed.\n");
					return(-1);
				}
				addBitFile(datasize, compression, bitswapped, outfilename, xmlGetProp(cur, "id"), xmlGetProp(cur, "file"));//TODO veriufy the return
			}
		cur = cur->next;
	}

	xmlFreeDoc(doc);
	return (0);
}

void splash(){
		printf
		("\n-------------------------------------------------------------------------\n");
	printf
		("-                      convbitstream application 1.0 :-)                -\n");
	printf
		("-                                 by LucaPezza                          -\n");
	printf
		("-------------------------------------------------------------------------\n\n");
	return;
}


int main(int argc, char **argv) {
	if (argc == 3){
		//Start application execution.
		splash();
		char * xmlfilename;
		char * outfilename;
		xmlfilename = argv[1];
		outfilename = argv[2];

		//writing header
		FILE *fp;
		fp = fopen(outfilename, "w+");
		if (NULL == fp){
			printf("File opening failed.\n");
			return(0);
		}
		fprintf(fp, "/*\n * Partial bitfile/s autogenerated with the command: convbitfile\n * XML source file: %s\n *\n", xmlfilename);
		if (fclose(fp) != 0) {
			printf("File closing failed.\n");
			return(-1);
		}

		if (parseXmlFile(xmlfilename, outfilename) == 0){
			//writing trailer
			FILE *fp;
			fp = fopen(outfilename, "a+");
			if (NULL == fp){
				printf("File opening failed.\n");
				return(0);
			}
			fprintf(fp, "/*\n * End of file.\n */\n");
			if (fclose(fp) != 0) {
				printf("File closing failed.\n");
				return(-1);
			}
			printf("\nEnd of convbitfile.\n");
		}else{
		printf("Error during convbitfile execution.\n");
		}

	}else{
		//Report error
		if (argc < 3) printf("Too few arguments. ");
		if (argc > 3) printf("Too many arguments. ");
		printf("Usage: convbitfile [xmlfile] [outfile].\n");
	}
	return (0);
}
