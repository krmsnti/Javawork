package odevler;

import java.util.Scanner;

public class calisma {

	public static void main(String[] args) {

		Scanner giris = new Scanner(System.in);

		int bakiye, yatir, cek, secim;
		int hataliGiris = 0;
		int gunlukCekilen = 0;
		String isim, soyisim;

		bakiye = 1000;

		System.out.println("İsminizi Giriniz:");
		isim = giris.nextLine();

		System.out.println("Soyisminizi Giriniz:");
		soyisim = giris.nextLine();

		System.out.println("Hoş Geldiniz " + isim + " " + soyisim);

		while (true) {

			System.out.println("\n1-Bakiye Sorgula");
			System.out.println("2-Para Yatır");
			System.out.println("3-Para Çek");
			System.out.println("4-Çıkış");

			secim = giris.nextInt();

			switch (secim) {

			case 1:
				System.out.println("Bakiyeniz: " + bakiye);
				break;

			case 2:
				System.out.println("Yatırılacak miktar:");
				yatir = giris.nextInt();
				if (yatir <= 0) {
					System.out.println("Geçersiz değer girdiniz...");
					break;
				}
				bakiye = bakiye + yatir; // yatırmada çıkarma yapmışsın

				System.out.println("Yeni bakiyeniz: " + bakiye);
				break;

			case 3:
				System.out.println("Çekilecek miktar:");
				cek = giris.nextInt();

				if (cek > bakiye){
					System.out.println("Hatalı miktar girdiniz");
					break;
				}

				bakiye = bakiye - cek;// bak ya burada da bir işlem hatası var

				System.out.println("Yeni bakiyeniz: " + bakiye);
				break;

			case 4:
				System.out.println("Çıkış yapılıyor...");
				giris.close();// girisclose buraa mı olması gerekiyor ki ???
				return;
			// buraya bir return gelebilir

			default:
				System.out.println("Hatalı seçim! Menüye Tekrar Döndürülüyorsunuz...");

			}
		}
}}
