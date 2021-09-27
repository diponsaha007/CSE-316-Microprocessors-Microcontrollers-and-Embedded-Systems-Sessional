/*
 * LEDMatrix.c
 *
 * Created: 4/11/2021 10:31:09 AM
 * Author : APURBA SAHA
 */ 

#define F_CPU 1000000

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

unsigned char bits[8] = {0b00000000 , 0b11111011 , 0b11111011 , 0b11011011, 0b11011011, 0b11011111 ,0b11011111,0b00000000 };

short is_static;

unsigned char setbit(short i)
{
	short x = 0 ;
	x|=(1<<i);
	return (unsigned char)x;
}

void shift_right()
{
	unsigned char tmp = bits[7];
	for(short i= 7; i>=1;i--)
	{
		bits[i] = bits[i-1];
	}
	bits[0] = tmp;
}
ISR(INT0_vect)
{
	is_static^=1;
}

int main(void)
{
	/* Replace with your application code */
	DDRA = 0b11111111;
	DDRB = 0b11111111;
	GICR = (1<<INT0);
	MCUCR = MCUCR & 0b11111111;
	sei();
	
	is_static = 1;
	while (1)
	{
		for(short t =0 ; t < 50 ; t++){
			for(short i=0;i<8;i++)
			{
				PORTA = setbit(i);
				PORTB = ~(bits[i]);
				_delay_ms(1);
			}
		}
		if(!is_static)
		{
			shift_right();
		}
	}
}

