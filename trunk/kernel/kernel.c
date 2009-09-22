
#include "../arch/x86/cpu.h"
#include "../include/hw_init.h"
#include "display.h"
#include "print.h"
#include "exception.h"

int _k_main()
{
	int i;

	/*Initialize hardware drivers*/
	hw_initialize();

	//! install our exception handlers
	setvect (0,  divide_by_zero_fault);
	setvect (1,  single_step_trap);
	setvect (2,  nmi_trap);
	setvect (3,  breakpoint_trap);
	setvect (4,  overflow_trap);
	setvect (5,  bounds_check_fault);
	setvect (6,  invalid_opcode_fault);
	setvect (7,  no_device_fault);
	setvect (8,  double_fault_abort);
	setvect (10, invalid_tss_fault);
	setvect (11, no_segment_fault);
	setvect (12, stack_fault);
	setvect (13, general_protection_fault);
	setvect (14, page_fault);
	setvect (16, fpu_fault);
	setvect (17, alignment_check_fault);
	setvect (18, machine_check_abort);
	setvect (19, simd_fpu_fault);

	ClrScr (0x13);
	GotoXY (0,0);
	SetColor (0x12);

	Puts ("\n		     zygote OS v0.01\n");
	SetColor (0x17);
	Puts ("Enabled A20!\n\n");
	Puts ("Initialized GDT and IDT!\n\n");
	Puts ("Installed PIC, PIT, and exception handlers!\n\n");
	Printf ("Cpu vender: %s \n\n", get_cpu_vender ());
	Puts ("Hitting any key will fire the default handlers \n");

	
	//To test divide by zero exception
	//i = 10/0;
	for(;;) {
	}
	
};

