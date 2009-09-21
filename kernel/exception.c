//****************************************************************************
//**
//**    exception.c
//**		system exception handlers. These are registered during system
//**		initialization and called automatically when they are encountered
//**
//****************************************************************************

#include "exception.h"

//! For now, all of these interrupt handlers just disable hardware interrupts
//! and calls kernal_panic(). This displays an error and halts the system



//! divide by 0 fault
void divide_by_zero_fault (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Divide by 0");
	for (;;);
}

//! single step
void single_step_trap (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Single step");
	for (;;);
}

//! non maskable  trap
void nmi_trap (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : NMI trap");
	for (;;);
}

//! breakpoint hit
void  breakpoint_trap (unsigned int cs,unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Breakpoint trap");
	for (;;);
}

//! overflow
void overflow_trap (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Overflow trap");
	for (;;);
}

//! bounds check
void bounds_check_fault (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Bounds check fault");
	for (;;);
}

//! invalid opcode / instruction
void invalid_opcode_fault (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Invalid opcode");
	for (;;);
}

//! device not available
void no_device_fault (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Device not found");
	for (;;);
}

//! double fault
void double_fault_abort (unsigned int cs, unsigned int err, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Double fault");
	for (;;);
}

//! invalid Task State Segment (TSS)
void invalid_tss_fault (unsigned int cs,unsigned int err,  unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Invalid TSS");
	for (;;);
}

//! segment not present
void no_segment_fault (unsigned int cs,unsigned int err,  unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Invalid segment");
	for (;;);
}

//! stack fault
void stack_fault ( unsigned int cs,unsigned int err, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Stack fault");
	for (;;);
}

//! general protection fault
void general_protection_fault (unsigned int cs,unsigned int err, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : General Protection Fault");
	for (;;);
}

//! page fault
void page_fault (unsigned int cs,unsigned int err, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Page Fault");
	for (;;);
}

//! Floating Point Unit (FPU) error
void fpu_fault (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : FPU Fault");
	for (;;);
}

//! alignment check
void alignment_check_fault (unsigned int cs,unsigned int err, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Alignment Check");
	for (;;);
}

//! machine check
void machine_check_abort (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : Machine Check");
	for (;;);
}

//! Floating Point Unit (FPU) Single Instruction Multiple Data (SIMD) error
void simd_fpu_fault (unsigned int cs, unsigned int eip, unsigned int eflags) {

//	intstart ();
	k_printf ("Exception : FPU SIMD fault");
	for (;;);
}
