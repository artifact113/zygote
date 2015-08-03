operating system written from scratch in assembly(nasm) and C.

22 SEPTEMBER 2009

---

stable version [r31](https://code.google.com/p/zygote/source/detail?r=31)

completed

1)Initialised IDT(Interrupt Descriptor Table)

2)Programmed PIC(Programmable Interrupt Controller) and PIT(Programmable Interrupt Timer)

3)Installed PIC, PIT and Exception handlers.


SCREEN SHOTS

http://code.google.com/p/zygote/wiki/PicPitExeHandlers


11 SEPTEMBER 2009

---


Last stable version is [r20](https://code.google.com/p/zygote/source/detail?r=20).

completed

1) 1st stage boot loader which boots and loads 2nd stage boot loader.

2) 2nd stage boot loader enables A20, installs GDT, loads the C kernel and jumps to     Protected Mode.


3) A small C print module.

Development Host : Fedora 11


Target           : Vmware Workstation

SCREEN SHOTS in wiki.


http://code.google.com/p/zygote/wiki/ScreenShots?ts=1252657935&updated=ScreenShots