package odevler;

import java.util.Scanner;

public class odevCalisma {

    public static void main(String[] args) {

        Scanner giris = new Scanner(System.in);

        int bakiye, yatir, cek, secim;
        String isim, soyisim;

        bakiye = 1000;

        System.out.println("Lütfen Giriş Yapınız...");

        System.out.print("İsminizi Giriniz: ");
        isim = giris.nextLine();

        System.out.print("Soyisminizi Giriniz: ");
        soyisim = giris.nextLine();

        System.out.println("\nHoş Geldiniz " + isim + " " + soyisim);

        while (true) {

            System.out.println("\nYapılacak işlemi giriniz:");
            System.out.println("1-Bakiye Sorgula");
            System.out.println("2-Para Yatır");
            System.out.println("3-Para Çek");
            System.out.println("4-Çıkış");

            secim = giris.nextInt();

            switch (secim) {

            case 1:
                System.out.println("Bakiyeniz: " + bakiye + " TL");
                break;

            case 2:
                System.out.println("Yatırılacak Miktarı Giriniz: ");
                yatir = giris.nextInt();

                bakiye = bakiye + yatir;

                System.out.println("Yeni Bakiyeniz: " + bakiye);
                break;

            case 3:
                System.out.println("Hesaptan Çekilecek Miktarı Giriniz: ");
                cek = giris.nextInt();

                if (cek <= bakiye && cek > 0) {
                    bakiye = bakiye - cek;
                    System.out.println("Yeni Bakiyeniz: " + bakiye);
                } else {
                    System.out.println("Yetersiz Bakiye veya Geçersiz Tutar!");
                }

                break;

            case 4:
                System.out.println("Çıkış Yapılıyor. İyi Günler!");
                giris.close();
                return;

            default:
                System.out.println("Hatalı Seçim Yaptınız!");

            }
        }
    }
}