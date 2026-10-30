package odevler;

import java.util.Scanner;

public class odev2 {

	public static void main(String[] args) {
		Scanner giris = new Scanner(System.in);
		float a,b,c,d,e,f,g,h,i,k;
		System.out.println("Kullanılan 'Dakika' miktarını giriniz...:   ");
		a = giris.nextFloat();
		System.out.println("Kullanılan 'SMS' miktarını giriniz...:   ");
		b = giris.nextFloat();
		System.out.println("Kullanılan 'İnternet' miktarını giriniz...:   ");
		c = giris.nextFloat();
		d = (float) (a* 0.5) ;
		e = (float) (b * 0.4);
		f = (float)	(c * 20);
		g = (float) (((d+e+f)*25)/100);
		h = (float) ((d+e+f)+g);
		i = (float) ((h*4)/100);
		k = (float) (h+i);

		System.out.println("Ödenecek faturanız: " +k + " TL");
		giris.close();
		
		

	}

}
