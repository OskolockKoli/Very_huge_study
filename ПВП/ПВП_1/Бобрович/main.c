int main (void) {
    volatile unsigned char a1=0xA1;
    volatile unsigned char b1=0xA1;
    volatile unsigned char c1=0xA1;
    volatile unsigned short a2=0xA1A1;
    volatile unsigned short b2=0xA1A1;
    volatile unsigned short c2=0xB1B1;
    volatile unsigned int a4=0xA1A1A1A1;
    volatile unsigned int b4=0xA1A1A1A1;
    volatile unsigned int c4=0xA1A1A1A1;
    volatile unsigned long long a8=0xA1A1A1A1A1A1A1A1;
    volatile unsigned long long b8=0xA1A1A1A1A1A1A1A1;
    volatile unsigned long long c8=0xA1A1A1A1A1A1A1A1;
    volatile char name1[] = "Nickolay";
    volatile char name2[] = "Bobrovich";
    volatile char name3[] = "4136";
    for(;;){}
    return 0; 
}


