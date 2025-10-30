package iut.gon.sae.controller;

import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

import iut.gon.sae.game.Entity.Monster;
import iut.gon.sae.game.Entity.Player;
import iut.gon.sae.game.model.Map.Place;
import iut.gon.sae.game.model.Map.World;

public class Game {
	public int choix;
	
	public void play() {
		Player player = new Player(100, 100, 20,20, 100,100);
		World Sylvarant = new World("Sylvant");
		Random choixtrame = new Random();
		int nombre = choixtrame.nextInt(2);
		
		//trame défaite
		
		if(nombre == 0) {
			trameDefaite();
			
		}
		else {
			trameDefaite();
			
		}
	}
	
	public void trameDefaite() {
		Player player = new Player(100, 100, 20,20, 100,100);
		World Sylvarant = new World("Sylvant");
		Monster monster = new Monster(180, 180, 70,40, "monster");
		
		Place desert = new Place(1,"Forêt de Gaorcchia", "Une forêt dangereuse", true, false);
		Place triet = new Place(2,"Forêt de Gaorcchia", "Une forêt dangereuse", true, false);
		Place iselia = new Place(3,"Forêt de Gaorcchia", "Une forêt dangereuse", true, false);
		desert.PlaceWithMonster(4, desert.getName(),monster, "Une forêt dangereuse",  true, true, false);
		try {
			System.out.println("Welcome in Sylvarant World !");
			System.out.println("You are at Iselia.");
			System.out.println("Un village paisible où les aventuriers commencent leur voyage.");
			System.out.println("What do you want to do ?");
			System.out.println("0 - Move to another place");
			System.out.println("1 - Exit the game");
			Scanner scanner1 = new Scanner(System.in);
			choix = scanner1.nextInt();
			if (choix !=0 && choix != 1) {
				throw new InputMismatchException();
			}
			if(choix == 0) {
				System.out.println("Where do you want to go ?");
				System.out.println("0 - Forêt de Gaoracchia");
				System.out.println(" 1 - Triet");
				System.out.println("2 - Temple de Martel");
				Scanner scanner2 = new Scanner(System.in);
				choix = scanner1.nextInt();
				if (choix !=0 && choix != 1) {
					throw new InputMismatchException();
				}
				
				/*
				 * chemin 1
				 */
				else if(choix == 1) {
					System.out.println("You are at " +desert.getName());
					System.out.println("Une petite oasis dans le désert, réputé pour son marché animé");
					
					System.out.println("What do you want to do ?");
					System.out.println("0 - Move to another place");
					System.out.println("1 - Exit the game");
					Scanner scanner3 = new Scanner(System.in);
					int choix3 = scanner3.nextInt();
					if (choix3 !=0 && choix != 1) {
						throw new InputMismatchException();
					}
					if(choix3 ==0) {
						System.out.println("Where do you want to go ?");
						System.out.println("0 - Temple de la foudre");
						System.out.println("1 - Desert de Triet");
						System.out.println(" 2 - Iselia");
						System.out.println(" 3 - Palmacosta");
						System.out.println(" 4 - Tour du salut");
						Scanner scanner4 = new Scanner(System.in);
						int choix4 = scanner4.nextInt();
						if (choix4 !=0 && choix != 1) {
							throw new InputMismatchException();
						}
						if (choix == 1) {
							System.out.println("A fight begin ! ");
							System.out.println("Player :");
							System.out.println("HP: [" + player.getCurrentHP() +"], ARM: " + player.getArmor() + "ATT: " + player.getAttack() + ", MAN: " + player.getCurrentMana() );
							System.out.println("Monster :");
							System.out.println("HP: [" + monster.getCurrentHP() +"], ARM: " + monster.getArmor() + "ATT: " + monster.getAttack() + "," );
							System.out.println("0 -Basic attack");
							System.out.println("1- Heal (30 mana)");
							System.out.println("2- Poison (25 mana)");
							System.out.println("3- ManaGain (30 mana)");
							System.out.println("4- Strength (30 mana)");
							System.out.println("5- Strength (30 mana)");
							Scanner scanner5 = new Scanner(System.in);
							 choix = scanner5.nextInt();
							if (choix !=0 && choix != 1) {
								throw new InputMismatchException();
							}
							if(choix == 0) {
								
							}
						}
					}
					
					
				}
			
			
			}
				System.exit(0);
		}
		catch(InputMismatchException e) {
			System.out.println("Please write a number between 0 & 2");
			Scanner scanner1 = new Scanner(System.in);
			while (scanner1.nextInt() != 1 && scanner1.nextInt() !=0) {
				System.out.println("Please write a number between 0 & 2");
				 choix = scanner1.nextInt();
			}
		}
	}
}
