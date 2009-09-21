//****************************************************************************
////**
////**    cpu.c
////**
////**	This is the processor interface. Everything outside of this module
////**	must use this interface when working on processor data.
////**
////**	A processor is a module that manages the very basic data structures
////**	and data within the system. The processor interface provides the interface
////**	for managing processors, processor cores, accessing processor structures,
////**	and more
////**
////****************************************************************************

#include "idt.h"

//! Initializes cpu resources
int i86_cpu_initialize () {

    //! initialize processor tables
    i86_idt_initialize (0x08);

    return 0;
}

//! shuts down cpu resources...Nothing to do yet
void i86_cpu_shutdown () {


}
char* i86_cpu_get_vender () {

	static char	vender[32] = {0};

/*	_asm {
		mov		eax, 0
		cpuid
		mov		dword ptr [vender], ebx
		mov		dword ptr [vender+4], edx
		mov		dword ptr [vender+8], ecx
	}*/

	return vender;
}
