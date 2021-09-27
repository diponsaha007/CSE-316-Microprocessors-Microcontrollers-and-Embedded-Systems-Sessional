/*
 * ADC_LCD.c
 *
 * Created: 6/3/2021 9:01:17 PM
 * Author : APURBA SAHA
 */ 

#define F_CPU 1000000
#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7
#include <avr/io.h>
#include <util/delay.h>
#include "lcd.h"

int gun(double x, double y)
{
	double val = (x*y);
	int v = val;
	return v;
}
double round(double var)
{
	double v = (var * 100 + .5);
	int value = (int)v;
	return (double)value / 100.00;
}

int main(void)
{
	DDRD = 0xFF;
	DDRC = 0xFF;
	ADMUX = 0b00100111;
	ADCSRA = 0b10000001;
	int result = 1;
	Lcd4_Init();
	while(1)
	{
		ADCSRA |=(1<<ADSC);
		while(ADCSRA & (1<<ADSC)){
			;
		}
		result = ADCL;
		result>>=6;
		
		result |=( (int)ADCH)<<2;
		double voltage = (double)result*4.00/1024.00;
		voltage = round(voltage);
		char ans[5];
		ans[0] = (gun(voltage,1.00)%10)+'0';
		ans[1] ='.';
		ans[2] =(gun(voltage,10.00)%10) +'0';
		ans[3] =(gun(voltage,100.00)%10) +'0';
		ans[4]='\0';
		
		Lcd4_Set_Cursor(1,1);
		Lcd4_Write_String("Voltage : ");
		Lcd4_Write_String(ans);
	}
}

