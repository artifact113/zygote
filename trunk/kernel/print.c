
static unsigned int line = 0;

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

inline void outportb1(unsigned int port,unsigned char value)
{
    asm volatile ("outb %%al,%%dx"::"d" (port), "a" (value));
};

void update_cursor(int row, int col)
{
        unsigned short position=(row*80) + col;


        outportb1(0x3D4, 0x0E);
        outportb1(0x3D5, (unsigned char)((position>>8)&0xFF));

        outportb1(0x3D4, 0x0F);
        outportb1(0x3D5, (unsigned char)(position&0xFF));
};

unsigned int k_printf(char* message)
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
            } else {
                  vidmem[i]=*message;
                  *message++;
                  ++i;
                  vidmem[i]=0xA;
                  ++i;
            }
        };
	line++;
	update_cursor(line + 2,0);
        return 1;
};

