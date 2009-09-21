//****************************************************************************
////**
////**    [string.c]
////**    - [Standard C string routine implimentation]
////**
////****************************************************************************

#include "../include/size_t.h"

//! sets count bytes of dest to val
void *memset(void *dest, char val, size_t count)
{
    unsigned char *temp = (unsigned char *)dest;
	for( ; count != 0; count--, temp[count] = val);
	return dest;
}
