//Due to how large this one is it gets its own file
/datum/job/chaplain
	title = "Chaplain"
	flag = CHAPLAIN
	department = "Civilian"
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#dddddd"
	addcional_access = list(access_maint_tunnels)
	minimal_access = list(access_morgue, access_chapel_office, access_crematorium)
	alt_titles = list("Counselor")

	uniform = /obj/item/clothing/under/rank/chaplain
	pda = /obj/item/device/pda/chaplain

	equip(var/mob/living/carbon/human/H)
		if(!..())	return 0

		var/obj/item/storage/bible/B = new /obj/item/storage/bible(H) //BS12 EDIT
		H.equip_to_slot_or_del(B, slot_l_hand)
		spawn(0)
			var/religion_name = "Christianity"
			var/new_religion = sanitize(input(H, "You are the crew services officer. Would you like to change your religion? Default is Christianity, in SPACE.", "Name change", religion_name), MAX_NAME_LEN)

			if (!new_religion)
				new_religion = religion_name

			switch(lowertext(new_religion))
				if("christianity")
					B.name = pick("The Holy Bible","The Dead Sea Scrolls")
				if("satanism")
					B.name = "The Unholy Bible"
				if("cthulu")
					B.name = "The Necronomicon"
				if("islam")
					B.name = "Quran"
				if("scientology")
					B.name = pick("The Biography of L. Ron Hubbard","Dianetics")
				if("chaos")
					B.name = "The Book of Lorgar"
				if("imperium")
					B.name = "Uplifting Primer"
				if("toolboxia")
					B.name = "Toolbox Manifesto"
				if("homosexuality")
					B.name = "Guys Gone Wild"
				if("lol", "wtf", "gay", "penis", "ass", "poo", "badmin", "shitmin", "deadmin", "cock", "cocks")
					B.name = pick("Woodys Got Wood: The Aftermath", "War of the Cocks", "Sweet Bro and Hella Jef: Expanded Edition")
					H.setBrainLoss(100)
				if("science")
					B.name = pick("Principle of Relativity", "Quantum Enigma: Physics Encounters Consciousness", "Programming the Universe", "Quantum Physics and Theology", "String Theory for Dummies", "How To: Build Your Own Warp Drive", "The Mysteries of Bluespace", "Playing God: Collector's Edition")
				else
					B.name = "The Holy Book of [new_religion]"

		spawn(1)
			var/deity_name = "Space Jesus"
			var/new_deity = sanitize(input(H, "Would you like to change your deity? Default is Space Jesus.", "Name change", deity_name), MAX_NAME_LEN)

			if ((length(new_deity) == 0) || (new_deity == "Space Jesus") )
				new_deity = deity_name
			B.deity_name = new_deity

			var/accepted = 0
			var/outoftime = 0
			spawn(200) // 20 seconds to choose
				outoftime = 1
			var/new_book_style = "Bible"

			while(!accepted)
				if(!B) break // prevents possible runtime errors
				new_book_style = input(H,"Which bible style would you like?") in list("Bible", "Koran", "Scrapbook", "Creeper", "White Bible", "Holy Light", "Athiest", "Tome", "The King in Yellow", "Ithaqua", "Scientology", "the bible melts", "Necronomicon", "Imperial Cult")
				switch(new_book_style)
					if("Koran")
						B.icon_state = "koran"
						for(var/area/chapel/main/A in all_areas)
							for(var/turf/T in A.contents)
								if(T.icon_state == "carpetsymbol")
									T.set_dir(4)
					if("Scrapbook")
						B.icon_state = "scrapbook"
					if("Creeper")
						B.icon_state = "creeper"
					if("White Bible")
						B.icon_state = "white"
					if("Holy Light")
						B.icon_state = "holylight"
					if("Athiest")
						B.icon_state = "athiest"
						for(var/area/chapel/main/A in all_areas)
							for(var/turf/T in A.contents)
								if(T.icon_state == "carpetsymbol")
									T.set_dir(10)
					if("Tome")
						B.icon_state = "tome"
					if("The King in Yellow")
						B.icon_state = "kingyellow"
					if("Ithaqua")
						B.icon_state = "ithaqua"
					if("Scientology")
						B.icon_state = "scientology"
						for(var/area/chapel/main/A in all_areas)
							for(var/turf/T in A.contents)
								if(T.icon_state == "carpetsymbol")
									T.set_dir(8)
					if("the bible melts")
						B.icon_state = "melted"
					if("Necronomicon")
						B.icon_state = "necronomicon"
					if("Imperial Cult")
						B.icon_state = "imperial_cult"
						new /obj/item/clothing/accessory/amulet/aquila(B)
						new /obj/item/clothing/accessory/amulet/aquila(B)
						new /obj/item/clothing/accessory/amulet/aquila(B)
					else
						// if christian bible, revert to default
						B.icon_state = "bible"
						for(var/area/chapel/main/A in all_areas)
							for(var/turf/T in A.contents)
								if(T.icon_state == "carpetsymbol")
									T.set_dir(2)

				H.update_inv_l_hand() // so that it updates the bible's item_state in his hand

				switch(input(H,"Look at your bible - is this what you want?") in list("Yes","No"))
					if("Yes")
						accepted = 1
					if("No")
						if(outoftime)
							H << "Welp, out of time, buddy. You're stuck. Next time choose faster."
							accepted = 1

			if(ticker)
				ticker.Bible_icon_state = B.icon_state
				ticker.Bible_item_state = B.item_state
				ticker.Bible_name = B.name
				ticker.Bible_deity_name = B.deity_name
		return 1
