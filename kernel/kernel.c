#define __packed

void k_clear_screen()
{
	unsigned int* vidmem = (unsigned int*) 0xb8000;
	unsigned int i=0;
	while(i<(80*25))
	{
		vidmem[i] = 0x0A20; // intensive green on black, Space (0x20)
		++i;
	};
};

unsigned int k_printf(char* message, unsigned int line, char attribute)
{
	char* vidmem = (char*) 0xb8000;
	unsigned int i = line*80*2;

	while(*message!=0)
	{
		if(*message=='\n') // check for a new line
	    {
	      line++;
	      i=(line*80*2);
	      *message++;
	    }
        else
        {
		  vidmem[i]=*message;
		  *message++;
		  ++i;
		  vidmem[i]=attribute;
		  ++i;
        }
	};
	return 1;
};

inline void outportb(unsigned int port,unsigned char value)
{
    asm volatile ("outb %%al,%%dx"::"d" (port), "a" (value));
};

void update_cursor(int row, int col)
{
	unsigned short position=(row*80) + col;

	
	outportb(0x3D4, 0x0E);
	outportb(0x3D5, (unsigned char)((position>>8)&0xFF));
		
	outportb(0x3D4, 0x0F);
	outportb(0x3D5, (unsigned char)(position&0xFF));
};

int _k_main()
{
	k_clear_screen();

	k_printf("   ************************************************", 0, 0xA);
	k_printf("   *                                              *", 1, 0xA);
	k_printf("   *          Welcome to Zygote OS.               *", 2, 0xA);
	k_printf("   *                                              *", 3, 0xA);
	k_printf("   *        The C kernel has been loaded.         *", 4, 0xA);
	k_printf("   *                                              *", 5, 0xA);
	k_printf("   ************************************************", 6, 0xA);

	update_cursor(8, 0);
	return 0;
};

