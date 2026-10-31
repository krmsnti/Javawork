package odevler;

import java.util.Random;
import java.util.Scanner;

public class sayiTahmin {

	public static void main(String[] args) {
		Scanner giris = new Scanner(System.in);
		int tahmin;
		int deneme = 0;
		
		Random randomizer = new Random();
		int tutulanSayi = randomizer.nextInt(100) + 1;
		while (true) {
			System.out.println("Seçilen Sayıyı Tahmin Ediniz");
			tahmin = giris.nextInt();
			if (tahmin < tutulanSayi) {
				System.out.println("Arttır");
				deneme = (deneme+ 1);
				
			}
			if (tahmin > tutulanSayi) {
				System.out.println("Azalt");
				deneme = (deneme+ 1);
				
			}

			if (tahmin == tutulanSayi) {
				System.out.println("Tebrikler Doğru Bildiniz");
				return;
			}
				
			if (deneme == 3) {
				System.out.println("Maalesef hakkınızı Kaybettiniz. Seçilen sayı "+tutulanSayi);
				return;
				
				}
			}

		}

	}


