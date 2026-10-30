package odev1;

import java.util.Scanner;

public class odev1 {

	public static void main(String[] args) {
		Scanner giris = new Scanner(System.in);
		float s1;
		System.out.println("Uzunluk Değerini giriniz(Metre m*) = ");
		s1 = giris.nextInt();
		byte menu;
		System.out.println("1-mm\n2-cm\n3-dm\n4-m\n5-dkm\n6-hm\n7-km");
		menu = giris.nextByte();
		switch (menu) {
		case 1:
			System.out.println(s1*1000);
			break;
		case 2:
			System.out.println(s1*100);
			break;
		case 3:
			System.out.println(s1*10);
			break;
		case 4:
			System.out.println(s1);
			break;
		case 5:
			System.out.println(s1/10);
			break;
		case 6:
			System.out.println(s1/100);
			break;
		case 7:
			System.out.println(s1/1000);
			break;
			


		default:
			System.out.println("Geçersiz karakter girdiniz...");

		

	}

}
}
