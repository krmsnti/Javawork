
package odevler;

import java.util.Scanner;

public class odevler {

    public static void main(String[] args) {

        Scanner giris = new Scanner(System.in);

        String A;
        int medeni;
        int cocuk;
        float B, K, C, M, P, D;

        System.out.println("Kullanıcı Adı:");
        A = giris.next();

        System.out.println("Brüt Maaşınızı Giriniz:");
        B = giris.nextFloat();

        System.out.println("Medeni Durumunuzu Belirtiniz:");
        System.out.println("Evli = 1");
        System.out.println("Bekar = 2");

        medeni = giris.nextInt();

        switch (medeni) {
        case 1:
            // Evliyse gelecek
            K = (B + 5000);

            System.out.println("Çocuk Var mı ");
            System.out.println("Var = 3");
            System.out.println("Yok = 4");

            medeni = giris.nextInt();

            switch (medeni) {
            case 3:
                // COCUK VARSA
                System.out.println("Çocuk Sayısını Giriniz:");
                cocuk = giris.nextInt();

                M = (K + (cocuk * 1000));
                D = (M - (25 * M / 100));
                System.out.println("Sayın "+A+" Güncellenmiş Brüt Maaşınız = "+D);
                break;

            case 4:
                // COCUK YOKSA
                P = (K - (25 * K / 100));
                System.out.println("Sayın "+A+" Güncellenmiş Brüt Maaşınız = "+P);
                break;
            }
            break;

        case 2:
            // Evli değilse gelecek
            C = (B - (25 * B / 100));
            System.out.println("Sayın "+A+" Güncellenmiş Brüt Maaşınız = "+C);
            break;

        default:
            System.out.println("Geçersiz yanıt verdiniz!");
        }

        giris.close();
    }
}
