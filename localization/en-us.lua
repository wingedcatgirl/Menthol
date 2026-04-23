--local chdp = SMODS.find_mod("ChDp")[1] --What were we using this for, again...?

return {
	["misc"] = {
		["dictionary"] = {
			--Card noises
			["k_minty_drowned"] = "Drowned!",
			["k_minty_nommed"] = "Nom!",
			["k_minty_stopped"] = "Stopped!",
			["k_minty_storm"] = "Storm!",
			["k_minty_wiped"] = "Wiped!",
			["k_minty_forward"] = "Forward!",
			["k_minty_abandon"] = "Voting to abandon...",
			["k_minty_victory"] = "Victory!",
			["k_minty_inactive"] = "Inactive!",
			["k_minty_active"] = "Active!",
			["k_minty_sliced"] = "Sliced!",
			["k_minty_bang"] = "Bang!",
			["k_minty_kaboom"] = "Kablooie!",
			["k_minty_shaked"] = "Shaked!",
			["k_minty_bye"] = "Bye-bye!",
			["k_minty_rescheduled"] = "Rescheduled!",
			["k_minty_ordered"] = "Ordered!",
			["k_minty_printed"] = "Printed!",
			["k_minty_spread"] = "Spread!",
			["k_minty_confiscated"] = "Confiscated!",
			["k_minty_crystal"] = "Crystal!",
			k_minty_ratio = "L + ratio!",
			k_minty_bouyant = "Buoyant!",

			--Option text
			option_minty_flavor = "Flavor text",
			option_minty_crossover = "Include crossover content (where possible)",
			option_minty_slaterename = "Rename Stone to Slate",
			option_minty_ticking = "Ticking cards",
			option_minty_3lock = "3 suit availability",
			option_minty_nodumbshit = "Disable bad jokes",
			option_minty_devmode = "Dev mode",
			option_minty_notrace = "Suppress trace messages",

			--Names of things
			["k_minty_treat"] = "Treat",
			["b_minty_treat_cards"] = "Treat Cards",
			["k_minty_treat_packs"] = "Treat Pack",
			["k_minty_cobalt"] = "Cobalt",
			["b_minty_cobalt_cards"] = "Cobalt Cards",
			["k_minty_everycard_packs"] = "Pack of Every Card",
			["k_minty_mod_packs"] = "Mod Pack",

			--Misc junk
			["k_minty_random_mod"] = "a random mod",
			["k_mod_singular"] = "Mod",
			["k_minty_first_suit"] = "first played suit",
			["k_minty_no_suit"] = "no suit",
			["k_minty_all_suits"] = "all suit",
			["k_minty_yep"] = "Yep!",
			["k_minty_unbalanced"] = "Unbalanced",
			["k_minty_cube"] = "Hand must contain exactly 4 cards",
			["k_minty_psycube"] = "What have you done?!",
			["k_minty_challenge"] = "Challenge",
			["k_minty_special"] = "Special",
			["k_minty_hands"] = "hands per round",
			["k_minty_size"] = "hand size",
			["k_minty_discards"] = "discards per round",
			["k_minty_jokers"] = "Joker slots",
			["k_minty_selection"] = "selection limit",
			["k_minty_treasureplaceholder"] = "a random stat",
			k_minty_cease_sing = "The Blind delivers a cease-and-desist",
			k_minty_desist_sing = "notice for your ill-gotten card!",
			k_minty_cease_pl = "The Blind delivers a cease-and-desist",
			k_minty_desist_pl = "notice for your ill-gotten cards!",
		},
		["v_dictionary"] = {
			["a_minty_chipgain"] = "+#1# Chips",
			["a_minty_multandchips"] = "+#1# Mult, +#2# Chips",
			["a_minty_chipsandmult"] = "+#1# Chips, +#2# Mult",
			["v_minty_blackjack"] = "Hand must total #1# (is #2#)",
			["v_minty_forbidden_hand"] = "Hands containing #1# are forbidden",
			["v_minty_not_permitted_hand"] = "#1# is not a permitted hand (see challenge info)",
		},
		["v_text"] = {
			["ch_c_all_minty_counterfeit"] = {
				"All cards are {C:attention}Counterfeit{}"
			},
			["ch_c_minty_ante_dollarpenalty"] = {
				"Starting Ante {C:attention}#1#{}, {C:mult}-1{} Mult per {C:gold}$1{} held"
			},
			["ch_c_minty_showman"] = {
				"{C:attention}#1#{} can appear multiple times"
			},
			["ch_c_minty_blackjack"] = {
				"Scored hand must add up to {C:attention}#1#{}",
			},
			["ch_c_minty_blackjack2"] = {
				"{C:inactive,s:0.8}(Face cards are 10; Aces are 11 or 1)",
			},
			["ch_c_minty_must_hand"] = {
				"Only {C:attention}#1#{} hands are allowed"
			},
			["ch_c_minty_banned_hand"] = {
				"Hands containing {C:attention}#1#{} are forbidden"
			},
		},
		["suits_plural"] = {
			["minty_3s"] = "3s",
		},
		["suits_singular"] = {
			["minty_3s"] = "3",
		},
		["ranks"] = {
			["minty_face"] = "Face",
			["minty_number"] = "Number",
		},
		["labels"] = {
			["minty_cement_seal"] = "Cement Seal",
			["m_minty_marble"] = "Marble Card",
			["m_minty_garbled"] = "Garbled Card",
			["gemslot_catseye"] = "Cat's Eye",
			["minty_counterfeit"] = "Counterfeit",
			["minty_hooked"] = "Hooked",
			minty_pirated = "Pirated",
			minty_cat_ears = "Cat Ears",
			["k_minty_challenge"] = "Challenge",
			["k_minty_special"] = "Special",
			minty_drained = "Drained",
		},
		["challenge_names"] = {
			["c_minty_raidnight"] = "Day One Raid Night",
			["c_minty_raidnightsavage"] = "Day One Raid Night (Savage)",
			["c_minty_backalley"] = "Back Alleys",
			["c_minty_evilbackalley"] = "Deadly Back Alleys",
			["c_minty_cosmoport"] = "My Own Cosmoport",
			["c_minty_taxfraud"] = "Tax Fraud",
		},
		["achievement_names"] = {
			["ach_minty_leftstakes"] = "Stakes a little to the left",
			["ach_minty_lefterstakes"] = "Stakes rather more to the left",
			["ach_minty_lefteststakes"] = "Stakes lefter than Marx himself",
			["ach_minty_conqueror_of_hell"] = "Conqueror of Hell",
			["ach_minty_template"] = "Template",
			["ach_minty_nyanpletionist"] = "Nyanpletionist",
			ach_minty_nyanpletionist_plus = "Nyanpletionist+",
			ach_minty_nyanpletionist_plusplus = "Nyanpletionist++"
		},
		["achievement_descriptions"] = {
			["ach_minty_leftstakes"] = "Win on at least Scarlet Stake",
			["ach_minty_lefterstakes"] = "Win on at least Void Stake",
			["ach_minty_lefteststakes"] = "Win on at least #CA7CA7 Stake",
			["ach_minty_conqueror_of_hell"] = "Win on at least Rose Gold Stake (How?!)",
			["ach_minty_template"] = "Achievement",
			ach_minty_nyanpletionist = "Discover all Menthol items",
			ach_minty_nyanpletionist_plus = "Win with all Menthol decks on #CA7CA7 Stake or higher",
			ach_minty_nyanpletionist_plusplus = "Earn a #CA7CA7 or better sticker on all Menthol Jokers"
		},
		["poker_hands"] = {
			["minty_Handful"] = "Handful of Rocks",
			["minty_flush_handful"] = "Handful of Rock",
			["minty_spec_handful"] = "Conglomerate",
			["minty_spectrum"] = "Spectrum" --dummy hand name for deadly back alleys
		},
		["poker_hand_descriptions"] = {
			["minty_Handful"] = {
				"5 {C:attention}Rock Cards{}"
			},
			["minty_flush_handful"] = {
				"5 {C:attention}Rock Cards{} of",
				"the {C:attention}same{} enhancement"
			},
			["minty_spec_handful"] = {
				"5 {C:attention}Rock Cards{} of",
				"{C:attention}different{} enhancements"
			},
		},
		["quips"] = {
			["minty_de_ref"] = {
				"Play one of these",
				"High Card or Flush Five",
				"builds, or {C:attention}log off!{}"
			}
		}
	},
	["descriptions"] = {
		--[[ For now, this is only for translations; leave it commented in US English. and/or if it's not done yet
		["Mod"] = {
			["Menthol"] = {
				["name"] = "Menthol",
				["text"] = {
					"cat mod for cats",
					"... I mean this mod contains Minty's silly little content ideas."
				},
			},
		},
		--]]
		["Joker"] = {
			["j_minty_cube"] = {
				["unlock"] = {
					"Win a run playing more hands",
					"requiring {C:attention}4{} cards than",
					"hands {C:attention}impossible{} with 4 cards",
				},
				["name"] = "Cube Joker",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult",
					"Played hand must contain",
					"exactly {C:attention}4{} cards",
				},
			},
			["j_minty_cube_flavor"] = {
				["name"] = "Cube Joker",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult",
					"Played hand must contain",
					"exactly {C:attention}4{} cards",
					" ",
					"{C:inactive,s:0.8}YOU'RE a cube!",
				},
			},
			["j_minty_youtube"] = {
				["name"] = "YouTube",
				["text"] = {
					"{C:green}#1# in #2#{} chance of",
					"{X:mult,C:white}X#3#{} Mult"
				},
				["unlock"] = {
					"Overkill a {C:attention}Boss Blind{}",
					"by a factor of {X:mult,C:white}#1#{}"
				},
			},
			["j_minty_youtube_flavor"] = {
				["name"] = "YouTube",
				["text"] = {
					"{C:green}#1# in #2#{} chance of",
					"{X:mult,C:white}X#3#{} Mult",
					" ",
					"{C:inactive,s:0.8}What? It's an expected result",
					"{C:inactive,s:0.8}of {X:inactive,C:white,s:0.8}X#4#{C:inactive,s:0.8}, it's totally balanced!",
				},
			},
			["j_minty_youtube_flavor_alt"] = {
				["name"] = "YouTube",
				["text"] = {
					"{C:green}#1# in #2#{} chance of",
					"{X:mult,C:white}X#3#{} Mult",
					" ",
					"{C:inactive,s:0.8}What? It's an expected{}",
					"{C:inactive,s:0.8}result of... uh-oh.{}",
				},
			},
			["j_minty_inkbleed"] = {
				["name"] = "Inkbleed",
				["text"] = {
					"{C:attention}Enhancements{} sharing names",
					"also share {C:attention}effects{}"
				},
				["unlock"] = {
					"Play with at least",
					"{C:attention}#1#{} mods active",
					"{C:inactive}(Currently #2#){}"
				}
			},
			["j_minty_inkbleed_flavor"] = {
				["name"] = "Inkbleed",
				["text"] = {
					"{C:attention}Enhancements{} sharing names",
					"also share {C:attention}effects{}",
					" ",
					"{C:inactive,s:0.8}Also try Entropy and/or ArtBox!{}"
				},
			},
			["j_minty_clock"] = {
				["name"] = "The Time Being",
				["text"] = {
					"{C:mult}+Mult{} equal to current {C:attention}hour{}",
					"{C:chips}+Chips{} equal to current {C:attention}minute{}",
					"{C:money}+$#3#{} at end of round and {C:mult}self-destruct{}",
					"if current {C:attention}second{} equals either value"
				},
			},
			["j_minty_clock_flavor"] = {
				["name"] = "The Time Being",
				["text"] = {
					"{C:mult}+Mult{} equal to current {C:attention}hour{}",
					"{C:chips}+Chips{} equal to current {C:attention}minute{}",
					"{C:money}+$#3#{} at end of round and {C:mult}self-destruct{}",
					"if current {C:attention}second{} equals either value",
					" ",
					"{C:inactive,s:0.8}You run will be better for the Time Being"
				},
			},
			["j_minty_flexweirdo"] = {
				["name"] = "JWCMCAHGSMBIBITSASUD",
				["text"] = {
					"Cards of {C:attention}#1#{}",
					"give {C:mult}+#2#{} Mult when scored"
				},
			},
			["j_minty_shadowcrystal"] = {
				["name"] = "Shadow Crystal",
				["text"] = {
					"Cards of {C:attention}#1#{}",
					"give {C:money}$#2#{}, {C:chips}+#3#{} Chips",
					"{C:mult}+#4#{} Mult, or {X:mult,C:white}X#5#{} Mult",
					"when scored",
				},
			},
			["j_minty_shadowcrystal_flavor"] = {
				["name"] = "Shadow Crystal",
				["text"] = {
					"Cards of {C:attention}#1#{}",
					"give {C:money}$#2#{}, {C:chips}+#3#{} Chips",
					"{C:mult}+#4#{} Mult, or {X:mult,C:white}X#5#{} Mult",
					"when scored",
					" ",
					"{C:inactive,s:0.8}The prophecy's text does not{}",
					"{C:inactive,s:0.8}warp in the crystal's lens.{}",
				},
			},
			["j_minty_superboss"] = {
				["name"] = "Superboss",
				["text"] = {
					"Cards of {C:attention}#1#{}",
					"give {C:money}$#2#{}, {C:chips}+#3#{} Chips",
					"{C:mult}+#4#{} Mult, or {X:mult,C:white}X#5#{} Mult",
					"when scored, which increases",
					"if hand contains {C:attention}#6#{} or more",
					"cards of {C:attention}#1#{}"
				},
			},
			["j_minty_superboss_flavor"] = {
				["name"] = "Superboss",
				["text"] = {
					"Cards of {C:attention}#1#{}",
					"give {C:money}$#2#{}, {C:chips}+#3#{} Chips",
					"{C:mult}+#4#{} Mult, or {X:mult,C:white}X#5#{} Mult",
					"when scored, which increases",
					"if hand contains {C:attention}#6#{} or more",
					"cards of {C:attention}#1#{}",
					" ",
					"{C:inactive,s:0.8}WHY. WHY DID YOU GIVE THAT TO HIM.{}",
				},
			},
			["j_minty_bigpockets"] = {
				["name"] = "Big Pockets",
				["text"] = {
					"{C:mult}+#1#{} consumeable slots"
				},
			},
			["j_minty_bigpockets_flavor"] = {
				["name"] = "Big Pockets",
				["text"] = {
					"{C:mult}+#1#{} consumeable slots",
					" ",
					"{C:inactive,s:0.8}... or are you just happy to see me?"
				},
			},
			["j_minty_doctor"] = {
				["name"] = "Doctor",
				["text"] = {
					"After {C:green}#1#{} hand#3#, {C:attention}permanently{}",
					"gain {B:1,C:white}#2#{} Mult",
					"{C:green}Unknown chance{} to {C:attention}reschedule{}",
					"at end of round"
				},
			},
			["j_minty_doctor_flavor"] = {
				["name"] = "Doctor",
				["text"] = {
					"After {C:green}#1#{} hand#3#, {C:attention}permanently{}",
					"gain {B:1,C:white}#2#{} Mult",
					"{C:green}Unknown chance{} to {C:attention}reschedule{}",
					"at end of round",
					" ",
					"{C:inactive,s:0.8}\"Vent art\"? No, this is a doctor.{}",
					"{C:inactive,s:0.8}They've got the classic head mirror, see?{}"
				},
			},
			["j_minty_doctor_active"] = {
				["name"] = "Doctor",
				["text"] = {
					"{B:1,C:white}#2#{} Mult",
				},
			},
			["j_minty_doctor_active_flavor"] = {
				["name"] = "Doctor",
				["text"] = {
					"{B:1,C:white}#2#{} Mult",
					"{C:inactive,s:0.8}Seriously? Lucky bastard.{}"
				},
			},
			["j_minty_duckhat"] = {
				["name"] = "Duck in a Top Hat Thursday",
				["text"] = {
					"{C:money}+$#1#{} to interest cap",
					"{C:money}+$#3#{} at end of round",
					"{C:money}+$#2#{} value at end of round to",
					"self and a random other Joker",
				},
			},
			["j_minty_duckhat_flavor"] = {
				["name"] = "Duck in a Top Hat Thursday",
				["text"] = {
					"{C:money}+$#1#{} to interest cap",
					"{C:money}+$#3#{} at end of round",
					"{C:money}+$#2#{} value at end of round to",
					"self and a random other Joker",
					" ",
					"{C:inactive,s:0.8}Quack, good #4#."
				},
			},
			["j_minty_jacobsladder"] = {
				["unlock"] = {
					"Play a hand containing",
					"{C:attention}5{} or more suits"
				},
				["name"] = "Jacob's Ladder",
				["text"] = {
					"If scored hand contains {C:attention}#1#{}",
					"or more suits, {C:legendary}balance{}",
					"{C:chips}Chips{} and {C:mult}Mult{}",
				},
			},
			["j_minty_jacobsladder_flavor"] = {
				["name"] = "Jacob's Ladder",
				["text"] = {
					"If scored hand contains {C:attention}#1#{}",
					"or more suits, {C:legendary}balance{}",
					"{C:chips}Chips{} and {C:mult}Mult{}",
					" ",
					"{C:inactive,s:0.8}What do you mean, 'why'?",
					"{C:inactive,s:0.8}For SCIENCE, obviously!",
				},
			},
			["j_minty_cakesword"] = {
				["name"] = "Cake Sword",
				["text"] = {
					"Blind size reduced by {C:mult}#1#%{}",
					"when entering; loses {C:mult}#2#%{} per hit",
				},
			},
			["j_minty_cakesword_flavor"] = {
				["name"] = "Cake Sword",
				["text"] = {
					"Blind size reduced by {C:mult}#1#%{}",
					"when entering; loses {C:mult}#2#%{} per hit",
					" ",
					"{C:inactive,s:0.8}You should see the cake gun.{}"
				},
			},
			["j_minty_cakegun"] = {
				["name"] = "Cake Gun",
				["text"] = {
					"Blind size reduced by {C:mult}#1#%{}",
					"when entering; {C:mult}#2#{} shot#3# remain#4#",
				},
			},
			["j_minty_cakegun_flavor"] = {
				["name"] = "Cake Gun",
				["text"] = {
					"Blind size reduced by {C:mult}#1#%{}",
					"when entering; {C:mult}#2#{} shot#3# remain#4#",
					" ",
					"{C:inactive,s:0.8}Oh, there it is.{}"
				},
			},
			["j_minty_finity_calico"] = {
				["name"] = "Calico on the Counter",
				["text"] = {
					"{C:attention}#1# in #2#{} cards {C:mult}flipped{} on draw,",
					"{C:attention}#1# in #2#{} cards {C:mult}debuffed{} on draw",
					"{C:mult}Flipped{} or {C:mult}debuffed{} cards {C:attention}always score{}",
					"{C:mult}Flipped{} cards give {C:mult}+#3#{} Mult",
					"{C:mult}Debuffed{} cards give {X:mult,C:white}X#4#{} Mult",
				},
			},
			["j_minty_finity_calico_flavor"] = {
				["name"] = "Calico on the Counter",
				["text"] = {
					"{C:attention}#1# in #2#{} cards {C:mult}flipped{} on draw,",
					"{C:attention}#1# in #2#{} cards {C:mult}debuffed{} on draw",
					"{C:mult}Flipped{} or {C:mult}debuffed{} cards {C:attention}always score{}",
					"{C:mult}Flipped{} cards give {C:mult}+#3#{} Mult",
					"{C:mult}Debuffed{} cards give {X:mult,C:white}X#4#{} Mult",
					" ",
					"{C:inactive,s:0.8}Yeah, I made a mess, but{}",
					"{C:inactive,s:0.8}you like it better that way.{}",
				},
			},
			["j_minty_catcafe"] = {
				["name"] = "Cat Cafe",
				["text"] = {
					"{C:spectral}Kity{} Jokers give",
					"{C:chips}+#1#{} Chips",
				},
			},
			["j_minty_catcafe_flavor"] = {
				["name"] = "Cat Cafe",
				["text"] = {
					"{C:spectral}Kity{} Jokers give",
					"{C:chips}+#1#{} Chips",
					" ",
					"{C:inactive,s:0.8}The staff are cats.{}",
					"{C:inactive,s:0.8}The patrons... are also cats.{}"
				},
			},
			["j_minty_peywet"] = {
				["name"] = "Smack Barm Pey Wet",
				["text"] = {
					"In {C:attention}Wigan{} it's",
					"{C:green}good as gravy{}"
				},
			},
			["j_minty_copycat"] = {
				["name"] = "Copy Cat",
				["text"] = {
					"Copies the effect of a {C:attention}random{} other Joker",
					"{C:inactive}(Changes target at end of shop){}",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}){}",
				},
			},
			["j_minty_copycat_flavor"] = {
				["name"] = "Copy Cat",
				["text"] = {
					"Copies the effect of a {C:attention}random{} other Joker",
					"{C:inactive}(Changes target at end of shop){}",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}){}",
					" ",
					"{C:inactive,s:0.8}*perfectly echoed meow noises*",
				},
			},
			["j_minty_hyperfix"] = {
				["name"] = "Angel of Hyperfixation",
				["text"] = {
					"{B:1,C:white}#1##2#{} Mult for every blind",
					"cleared or skipped before",
					"buying your first Joker",
					"{C:inactive}(Currently {B:1,C:white}#1##3#{C:inactive})",
				},
			},
			["j_minty_hyperfix_flavor"] = {
				["name"] = "Angel of Hyperfixation",
				["text"] = {
					"{B:1,C:white}#1##2#{} Mult for every blind",
					"cleared or skipped before",
					"buying your first Joker",
					"{C:inactive}(Currently {B:1,C:white}#1##3#{C:inactive})",
					" ",
					"{C:inactive,s:0.8}Sure, I'll get it done eventually,",
					"{C:inactive,s:0.8}But it's always at the last minute...",
				},
			},
			["j_minty_languageEgg"] = {
				["unlock"] = {
					"Win a run in a language",
					"other than {C:attention}English{}"
				},
				["name"] = "Language Egg",
				["text"] = {
					"{C:mult}+#1#{} Mult for each round",
					"completed with a unique",
					"{C:attention}language{} setting this game",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
				},
			},
			["j_minty_languageEgg_flavor"] = {
				["name"] = "Language Egg",
				["text"] = {
					"{C:mult}+#1#{} Mult for each round",
					"completed with a unique",
					"{C:attention}language{} setting this game",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}",
					" ",
					"{C:inactive,s:0.8}Best enjoyed in the atheism corner"
				},
			},
			["j_minty_neko"] = {
				["name"] = "neko.exe",
				["text"] = {
					"{C:chips}+#1#{} Chips",
					"{C:attention}Chases{} your mouse around!"
				},
			},
			["j_minty_neko_flavor"] = {
				["name"] = "neko.exe",
				["text"] = {
					"{C:chips}+#1#{} Chips",
					"{C:attention}Chases{} your mouse around!",
					" ",
					"{C:inactive,s:0.8}Adorable since 1989"
				},
			},
			["j_minty_phasebus"] = {
				["name"] = "Phase Bus",
				["text"] = {
					"At end of round,",
					"create a {C:spectral}Spectral{} card",
					"if no {C:attention}face cards{}",
					"were scored that round",
					"{C:inactive}(Must have room){}",
					" ",
					"{C:inactive}(Currently: #1#!){}",
				},
			},
			["j_minty_phasebus_flavor"] = {
				["name"] = "Phase Bus",
				["text"] = {
					"At end of round,",
					"create a {C:spectral}Spectral{} card",
					"if no {C:attention}face cards{}",
					"were scored that round",
					"{C:inactive}(Must have room){}",
					" ",
					"{C:inactive}(Currently: #1#!){}",
					" ",
					"{C:inactive,s:0.8}No eating language eggs{}",
					"{C:inactive,s:0.8}allowed on the bus.{}",
				},
			},
			["j_minty_catpicmachine_modest"] = {
				["name"] = "ilo pi sitelen soweli",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult if a",
					"{C:attention}Cat Tag{} is held",
				},
			},
			["j_minty_catpicmachine_modest_flavor"] = {
				["name"] = "ilo pi sitelen soweli",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult if a",
					"{C:attention}Cat Tag{} is held",
					" ",
					"{C:inactive,s:0.8}The internet is for cats!",
				},
			},
			["j_minty_catpicmachine_mainline"] = {
				["name"] = "ilo pi sitelen soweli",
				["text"] = {
					"{X:mult,C:white}X#2#{} Mult for each",
					"{C:attention}Cat Tag{} held",
					"{C:inactive}(With levels considered)"
				},
			},
			["j_minty_catpicmachine_mainline_flavor"] = {
				["name"] = "ilo pi sitelen soweli",
				["text"] = {
					"{X:mult,C:white}X#2#{} Mult for each",
					"{C:attention}Cat Tag{} held",
					"{C:inactive}(With levels considered)",
					" ",
					"{C:inactive,s:0.8}The internet is for cats!",
				},
			},
			["j_minty_catpicmachine_madness"] = {
				["name"] = "ilo pi sitelen soweli",
				["text"] = {
					"{X:minty_3s,C:white}?#3#{} Mult for each",
					"{C:attention}Cat Tag{} held",
					"{C:inactive}(operator based on",
					"{C:inactive}Cat Tag's level)",
				},
			},
			["j_minty_catpicmachine_madness_flavor"] = {
				["name"] = "ilo pi sitelen soweli",
				["text"] = {
					"{X:minty_3s,C:white}?#3#{} Mult for each",
					"{C:attention}Cat Tag{} held",
					"{C:inactive}(operator based on",
					"{C:inactive}Cat Tag's level)",
					" ",
					"{C:inactive,s:0.8}The internet is for cats!",
				},
			},
			["j_minty_lucky"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Lucky",
				["text"] = {
					"Multiplies all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities{} by {C:mult}#1#{}",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}#1# in 3{C:inactive})",
				},
			},
			["j_minty_lucky_flavor"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Lucky",
				["text"] = {
					"Multiplies all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities{} by {C:mult}#1#{}",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}#1# in 3{C:inactive})",
					" ",
					"{C:inactive,s:0.8}Black cats are lucky",
					"{C:inactive,s:0.8}because you get to",
					"{C:inactive,s:0.8}pet a cat!",
				},
			},
			["j_minty_lune"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Lune",
				["text"] = {
					"Divides all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities{} by {C:mult}#1#{}",
					"{C:inactive}(ex: {C:green}#1# in 100{C:inactive} -> {C:green}1 in 100{C:inactive})",
				},
			},
			["j_minty_lune_flavor"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Lune",
				["text"] = {
					"Divides all {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities{} by {C:mult}#1#{}",
					"{C:inactive}(ex: {C:green}#1# in 100{C:inactive} -> {C:green}1 in 100{C:inactive})",
					" ",
					"{C:inactive,s:0.8}Till all complete.{}",
				},
			},
			["j_minty_stormy"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Stormy",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult, then retrigger",
					"once for each time a previous",
					"Joker triggered this hand"
				},
			},
			["j_minty_stormy_flavor"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Stormy",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult, then retrigger",
					"once for each time a previous",
					"Joker triggered this hand",
					" ",
					"{C:inactive,s:0.8}(It works.)",
				},
			},
			["j_minty_patchy"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Patchy",
				["text"] = {
					"Played {C:minty_3s}3s{} give",
					"{X:mult,C:white} X#1# {} Mult when scored",
					"and retrigger",
				},
			},
			["j_minty_patchy_flavor"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Patchy",
				["text"] = {
					"Played {C:minty_3s}3s{} give",
					"{X:mult,C:white} X#1# {} Mult when scored",
					"and retrigger",
					" ",
					"{C:inactive,s:0.8}BITING YOU BITING",
					"{C:inactive,s:0.8}YOU BITING YOU :3",
				},
			},
			["j_minty_minty"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Minty",
				["text"] = {
					"{B:1,C:white}#7##1#{} Mult, {C:attention}#4#{} time#6#",
					"For every {C:attention}#3#{}{C:inactive}(#2#){} {C:minty_3s}3s{} scored,",
					"gain a repetition and",
					"increase target by #5#",
				},
			},
			["j_minty_minty_flavor"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Minty",
				["text"] = {
					"{B:1,C:white}#7##1#{} Mult, {C:attention}#4#{} time#6#",
					"For every {C:attention}#3#{}{C:inactive}(#2#){} {C:minty_3s}3s{} scored,",
					"gain a repetition and",
					"increase target by #5#",
					" ",
					"{C:inactive,s:0.8}Of COURSE I'm in here, it's...{}",
					"{C:inactive,s:0.8}... er... never mind that, actually."
				},
			},
			["j_minty_garfielf"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Garfielf",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult",
					"If a {C:minty_3s}3{} is scored,",
					"{C:attention}destroy{} unscored non-{C:minty_3s}3s{}",
					"and gain {X:mult,C:white}X#2#{} Mult each",
				},
			},
			["j_minty_garfielf_flavor"] = {
				["unlock"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				},
				["name"] = "Garfielf",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult",
					"If a {C:minty_3s}3{} is scored,",
					"{C:attention}destroy{} unscored non-{C:minty_3s}3s{}",
					"and gain {X:mult,C:white}X#2#{} Mult each",
					" ",
					"{C:inactive,s:0.8}\"Where are the #3#s of #4#?\"",
					"{C:inactive,s:0.8}\"I ate those card.\"",
				},
			},
			["j_minty_claw"] = {
				["name"] = "Fossilized Claw",
				["text"] = {
					"{C:green}#1# in #2#{} chance for",
					"played {C:minty_3s}3s{} to give",
					"{X:mult,C:white} X#3# {} Mult when scored",
				},
				["unlock"] = {
                    "Have at least {E:1,C:attention}#2#",
                    "{E:1,C:minty_3s}#1#{} in your deck"
				}
			},
			["j_minty_claw_flavor"] = {
				["name"] = "Fossilized Claw",
				["text"] = {
					"{C:green}#1# in #2#{} chance for",
					"played {C:minty_3s}3s{} to give",
					"{X:mult,C:white} X#3# {} Mult when scored",
					" ",
					"{C:inactive,s:0.8}It seems to belong",
					"{C:inactive,s:0.8}to an ancient",
					"{C:inactive,s:0.8}prehistoric slow tiger.{}",
				},
			},
			["j_minty_fatcat-l"] = {
				["name"] = "Fat Cat",
				["text"] = {
					"When blind is selected,",
					"if any Food Jokers are held",
					"eat a random one and gain",
					"{X:mult,C:white}X#2#{} Mult {C:inactive}(currently {X:mult,C:white}X#1#{}){}",
				},
			},
			["j_minty_fatcat-l_flavor"] = {
				["name"] = "Fat Cat",
				["text"] = {
					"When blind is selected,",
					"if any Food Jokers are held",
					"eat a random one and gain",
					"{X:mult,C:white}X#2#{} Mult {C:inactive}(currently {X:mult,C:white}X#1#{}){}",
					" ",
					"{C:inactive,s:0.8}leave Tubbs olone dot tumblr dot com{}",
				},
			},
			["j_minty_fatcat-m"] = {
				["name"] = "Fat Cat",
				["text"] = {
					"When blind is selected,",
					"spend {C:money}$#1#{} (if possible) to",
					"create a random Joker with",
					"{C:dark_edition}Negative{}, {C:rental}Rental{}, and {C:perishable}Perishable{}"
				},
			},
			["j_minty_fatcat-m_flavor"] = {
				["name"] = "Fat Cat",
				["text"] = {
					"When blind is selected,",
					"spend {C:money}$#1#{} (if possible) to",
					"create a random Joker with",
					"{C:dark_edition}Negative{}, {C:rental}Rental{}, and {C:perishable}Perishable{}",
					" ",
					"{C:inactive,s:0.8}Diversity win: local capitalist",
					"{C:inactive,s:0.8}pigdog is, in fact, a catgirl!",
				},
			},
			["j_minty_chisel"] = {
				["name"] = "Chisel",
				["text"] = {
					"Scored {C:attention}#1#{} lose",
					"their enhancement and",
					"gain a {C:cement}Cement Seal{}",
				},
			},
			["j_minty_chisel_flavor"] = {
				["name"] = "Chisel",
				["text"] = {
					"Scored {C:attention}#1#{} lose",
					"their enhancement and",
					"gain a {C:cement}Cement Seal{}",
					" ",
					"{C:inactive,s:0.8}An artist knows they",
					"{C:inactive,s:0.8}have found perfection",
					"{C:inactive,s:0.8}when there is nothing",
					"{C:inactive,s:0.8}left to take away.{}",
				},
			},
			["j_minty_bucket"] = {
				["name"] = "Bucket of Cement",
				["text"] = {
					"Scored unenhanced cards",
					"become random {C:attention}#1#{}"
				},
			},
			["j_minty_bucket_flavor"] = {
				["name"] = "Bucket of Cement",
				["text"] = {
					"Scored unenhanced cards",
					"become random {C:attention}#1#{}",
					" ",
					"{C:inactive,s:0.8}Happy 6th birthday!",
				},
			},
			["j_minty_threecats"] = {
				["name"] = "Three Cats!",
				["text"] = {
					"Played {C:minty_3s}3s{} give {C:green}#1#{} of",
					"{C:chips}+#2#{} chips, {C:mult}+#3#{} Mult, and",
					"{X:mult,C:white}X#4#{} Mult when scored",
				},
			},
			["j_minty_threecats_flavor"] = {
				["name"] = "Three Cats!",
				["text"] = {
					"Played {C:minty_3s}3s{} give {C:green}#1#{} of",
					"{C:chips}+#2#{} chips, {C:mult}+#3#{} Mult, and",
					"{X:mult,C:white}X#4#{} Mult when scored",
					" ",
					"{C:mult,s:0.8}       Meow!      ",
					"{C:chips,s:0.8}Meow!             ",
					"            {X:mult,C:white,s:0.8}Meow!",
				},
			},
			["j_minty_wettiger"] = {
				["name"] = "Wet Tiger",
				["text"] = {
					"Every {C:attention}played card{}",
					"counts in scoring;",
					"{C:mult}+#2#{} Mult per round",
					"or {C:attention}extra scored card{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}",
				},
			},
			["j_minty_wettiger_flavor"] = {
				["name"] = "Wet Tiger",
				["text"] = {
					"Every {C:attention}played card{}",
					"counts in scoring;",
					"{C:mult}+#2#{} Mult per round",
					"or {C:attention}extra scored card{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}",
					" ",
					"{C:inactive,s:0.8}Poor little meow meow...{}"
				},
			},
			["j_minty_wildfire"] = {
				["name"] = "Wildfire",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult",
					"At {C:attention}end of shop{},",
					"{C:attention}spread left{} to",
					"gain {X:mult,C:white}X#2#{} Mult",
				},
			},
			["j_minty_wildfire_flavor"] = {
				["name"] = "Wildfire",
				["text"] = {
					"{X:mult,C:white}X#1#{}",
					"At {C:attention}end of shop{},",
					"{C:attention}spread left{} to",
					"gain {X:mult,C:white}X#2#{} Mult",
					" ",
					"{C:inactive,s:0.8}IT BURRRRRRNS!{}"
				},
			},
			["j_minty_shakegun"] = {
				["name"] = "Milkshake Gun",
				["text"] = {
					"Every {C:attention}played card{}",
					"counts in scoring;",
					"{C:attention}extra scored cards{}",
					"reduce {C:attention}Blind{} size by {C:mult}#1#%{}",
				},
			},
			["j_minty_shakegun_flavor"] = {
				["name"] = "Milkshake Gun",
				["text"] = {
					"Every {C:attention}played card{}",
					"counts in scoring;",
					"{C:attention}extra scored cards{}",
					"reduce {C:attention}Blind{} size by {C:mult}#1#%{}",
					" ",
					"{C:inactive,s:0.8}YES, shakes are just wet cakes!{}"
				},
			},
			["j_minty_parkour"] = {
				["name"] = "Parkour",
				["text"] = {
					"Applies {C:attention}Shortcut{}",
					"{C:chips}+#1#{} Chips, gains {C:chips}+#3#{} for every",
					"{C:attention}consecutive{} hand containing a {C:attention}Straight{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive}){}"
				},
			},
			["j_minty_parkour_flavor"] = {
				["name"] = "Parkour",
				["text"] = {
					"Applies {C:attention}Shortcut{}",
					"{C:chips}+#1#{} Chips, gains {C:chips}+#3#{} for every",
					"{C:attention}consecutive{} hand containing a {C:attention}Straight{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive}){}",
					" ",
					"{C:inactive,s:0.8}Their friends call them Peter.{}",
				},
			},
			["j_minty_slowtiger"] = {
				["name"] = "Slow Tiger",
				["text"] = {
					"{C:mult}+#2#{} Mult",
					"per round",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}",
				},
			},
			["j_minty_slowtiger_flavor"] = {
				["name"] = "Slow Tiger",
				["text"] = {
					"{C:mult}+#2#{} Mult",
					"per round",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}",
					" ",
					"{C:inactive,s:0.8}Turn it into a fast",
					"{C:inactive,s:0.8}tiger with this one trick!",
				},
			},
			["j_minty_theecho"] = {
				["name"] = "The Echo",
				["text"] = {
					"Prevents Death",
					"If triggered against {C:attention}second{} Boss Blind,",
					"{C:attention}-1 Ante{} and {C:attention}-1 charge{} {C:inactive}(#1# left){}.",
					"{C:red}Self-destructs{} when no charges remaining",
					"{C:inactive,s:0.8}(Or when challenge defeated){}",
				},
			},
			["j_minty_theecho_flavor"] = {
				["name"] = "The Echo",
				["text"] = {
					"Prevents Death",
					"If triggered against {C:attention}second{} Boss Blind,",
					"{C:attention}-1 Ante{} and {C:attention}-1 charge{} {C:inactive}(#1# left){}.",
					"{C:red}Self-destructs{} when no charges remaining",
					"{C:inactive,s:0.8}(Or when challenge defeated){}",
					" ",
					"{C:inactive,s:0.8}Burning for battle...{}",
					"{C:inactive,s:0.8}as long as the static's patience holds.{}",
				},
			},
			["j_minty_froyo"] = {
				["name"] = "Frozen Yogurt",
				["text"] = {
					"{C:chips}+#1#{} Chips, {C:chips}-#2#{} Chips",
					"for every hand played",
				},
			},
			["j_minty_froyo_flavor"] = {
				["name"] = "Frozen Yogurt",
				["text"] = {
					"{C:chips}+#1#{} Chips, {C:chips}-#2#{} Chips",
					"for every hand played",
					" ",
					"{C:inactive,s:0.8}(But it's so much cheaper!)",
				},
			},
			["j_minty_chocobar"] = {
				["name"] = "Choccy Bar",
				["text"] = {
					"{C:mult}+#1#{} Mult when card is",
					"scored, loses {C:mult}-#2#{} each trigger"
				},
			},
			["j_minty_chocobar_flavor"] = {
				["name"] = "Choccy Bar",
				["text"] = {
					"{C:mult}+#1#{} Mult when card is",
					"scored, loses {C:mult}-#2#{} each trigger",
					" ",
					"{C:inactive,s:0.8}Because your epic!"
				},
			},
			["j_minty_chocobar_flavor2"] = {
				["name"] = "Choccy Bar",
				["text"] = {
					"{C:mult}+#1#{} Mult when card is",
					"scored, loses {C:mult}-#2#{} each trigger",
					" ",
					"{C:inactive,s:0.8}Because your epic!",
					"{C:inactive,s:0.8}MISSPELLING IS PART OF THE REFRANCE",
					"{C:inactive,s:0.8}PLS DON'T FILE A TYPO REPORT KTHX",
				},
			},
			["j_minty_wrapper"] = {
				["name"] = "Crumpled Wrapper",
				["text"] = {
					"{C:inactive}...{}"
				},
			},
			["j_minty_wrapper_flavor"] = {
				["name"] = "Crumpled Wrapper",
				["text"] = {
					"{C:inactive}...{}",
					" ",
					"{C:inactive,s:0.8}(... why are you still carrying this?)"
				},
			},
			["j_minty_hedonist"] = {
				["name"] = "Hedonist Joker",
				["text"] = {
					"Played {C:minty_3s}3s{} give",
					"{C:mult}+#1#{} Mult when scored",
				},
			},
			["j_minty_hedonist_flavor"] = {
				["name"] = "Hedonist Joker",
				["text"] = {
					"Played {C:minty_3s}3s{} give",
					"{C:mult}+#1#{} Mult when scored",
					" ",
					"{C:inactive,s:0.8}I'm a hedonist.{}",
					"{C:inactive,s:0.8}Of course I have{}",
					"{C:inactive,s:0.8}flavor text. Mmm...{}",
				},
			},
			["j_minty_proso"] = {
				["name"] = "Prosopagnosia",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult if hand",
					"contains {C:attention}face{} cards,",
					"but {C:attention}no{} cards are",
					"considered face cards",
				},
			},
			["j_minty_proso_flavor"] = {
				["name"] = "Prosopagnosia",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult if hand",
					"contains {C:attention}face{} cards,",
					"but {C:attention}no{} cards are",
					"considered face cards",
					" ",
					"{C:inactive,s:0.8}You don't know what it's{}",
					"{C:inactive,s:0.8}like to spend every day{}",
					"{C:inactive,s:0.8}surrounded by monkeys.{}",
				},
			},
			["j_minty_ascetic"] = {
				["name"] = "Ascetic Joker",
				["text"] = {
					'Played {C:minty_3s}3s{} give',
					'{C:chips}+#1#{} Chips when scored',
				},
			},
			["j_minty_ascetic_flavor"] = {
				["name"] = "Ascetic Joker",
				["text"] = {
					"Played {C:minty_3s}3s{} give",
					"{C:chips}+#1#{} Chips when scored",
					" ",
					"{C:inactive,s:0.8}Flavor text?",
					"{C:inactive,s:0.8}A needless indulgence!",
				},
			},
			["j_minty_sabertooth"] = {
				["name"] = "Saber Tooth",
				["text"] = {
					'Held {C:minty_3s}#3#{} have',
					'a {C:green}#1# in #2#{} chance',
					'to not give {X:mult,C:white}X#4#{} Mult',
				},
			},
			["j_minty_sabertooth_flavor"] = {
				["name"] = "Saber Tooth",
				["text"] = {
					'Held {C:minty_3s}#3#{} have',
					'a {C:green}#1# in #2#{} chance',
					'to not give {X:mult,C:white}X#4#{} Mult',
					' ',
					'{C:inactive,s:0.8}Sharp enough to call it vorpal',
				},
			},
			["j_minty_ninethlion"] = {
				["name"] = "Nineth Lion",
				["text"] = {
					'TBA',
				},
			},
			["j_minty_ninethlion_flavor"] = {
				["name"] = "Nineth Lion",
				["text"] = {
					'TBA',
					' ',
					'{C:inactive,s:0.8}Yum delicis sun >:3',
					'{C:inactive,s:0.8}In definitely related news:',
					'{C:inactive,s:0.8}you\'re mortal!'
				},
			},
			["j_minty_eaten"] = {
				["name"] = "Eaten Joker",
				["text"] = {
					"Played cards with rank {C:attention}7{}",
					"give {C:chips}+#2#{} Chips and {C:mult}+#1#{} Mult",
					"when scored. Destroy {C:green}#4# in #3#{}",
					"scored cards of other ranks",
				},
			},
			["j_minty_eaten_flavor"] = {
				["name"] = "Eaten Joker",
				["text"] = {
					"Played cards with rank {C:attention}7{}",
					"give {C:chips}+#2#{} Chips and {C:mult}+#1#{} Mult",
					"when scored. Destroy {C:green}#4# in #3#{}",
					"scored cards of other ranks",
					" ",
					"{C:inactive,s:0.8}All shall be well and all shall be well{}",
					"{C:inactive,s:0.8}and all manner of thing shall be well.{}",
					"{C:inactive,s:0.8}That was the promise.{}"
				},
			},
			["j_minty_excited"] = {
				["name"] = "Overly Excited",
				["text"] = {
					"{C:chips}+#1#{} Chips, {C:mult}+#3#{} Mult",
					"Gain {C:chips}#2#{} Chips when",
					"anything happens, or",
					"{C:green}#6# in #5#{} chance to",
					"gain {C:mult}#4#{} Mult instead"
				},
			},
			["j_minty_excited_flavor"] = {
				["name"] = "Overly Excited",
				["text"] = {
					"{C:chips}+#1#{} Chips, {C:mult}+#3#{} Mult",
					"Gain {C:chips}#2#{} Chips when",
					"anything happens, or",
					"{C:green}#6# in #5#{} chance to",
					"gain {C:mult}#4#{} Mult instead",
					" ",
					"{C:inactive,s:0.8}Holy shit, it's a Joker!",
				},
			},
			["j_minty_gymbuddy"] = {
				["name"] = "Gym Buddies",
				["text"] = {
					"Scored {C:attention}enhanced{} cards grant",
					"{C:attention}permanent{} boosts to other",
					"scored cards without the",
					"same enhancement",
				},
			},
			["j_minty_gymbuddy_flavor"] = {
				["name"] = "Gym Buddies",
				["text"] = {
					"Scored {C:attention}enhanced{} cards grant",
					"{C:attention}permanent{} boosts to other",
					"scored cards without the",
					"same enhancement",
					" ",
					"{C:inactive,s:0.8}Feel the burn!{}"
				},
			},
			["j_minty_churutreat"] = {
				["name"] = "Churu Treat",
				["text"] = {
					"Scored {C:minty_3s}3s{} give {C:mult}+#1#{} Mult",
					"{C:green}#2# in #3#{} chance this card is",
					"eaten at end of round",
				},
			},
			["j_minty_churutreat_flavor"] = {
				["name"] = "Churu Treat",
				["text"] = {
					"Scored {C:minty_3s}3s{} give {C:mult}+#1#{} Mult",
					"{C:green}#2# in #3#{} chance this card is",
					"eaten at end of round",
					" ",
					"{C:inactive,s:0.8}Kity go nomnomnomnom :3",
				},
			},
			["j_minty_plastic_stick"] = {
				["name"] = "Plastic \"Stick\"",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult if you have",
					"another {C:attention}\"Stick\"{} Joker",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
				},
			},
			["j_minty_plastic_stick_flavor"] = {
				["name"] = "Plastic \"Stick\"",
				["text"] = {
					"{X:mult,C:white}X#1#{} Mult if you have",
					"another {C:attention}\"Stick\"{} Joker",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					" ",
					"{C:inactive,s:0.8}nooooo my treat is all gone",
				},
			},
			["j_minty_atheismcorner"] = {
				["name"] = "Atheism Corner",
				["text"] = {
					"{C:chips}+#1#{} Chips, gains {C:chips}+#2#{} ",
					"each round, resets if a",
					"{C:spectral}Spectral{} card is used",
				},
			},
			["j_minty_atheismcorner_flavor"] = {
				["name"] = "Atheism Corner",
				["text"] = {
					"{C:chips}+#1#{} Chips, gains {C:chips}+#2#{} ",
					"each round, resets if a",
					"{C:spectral}Spectral{} card is used",
					" ",
					"{C:inactive,s:0.8}And think about what you've done!"
				},
			},
			["j_minty_treatovision"] = {
				["name"] = "Treat-o-vision",
				["text"] = {
					"{V:1}#1#{} and {C:minty_3s}#2#{} suits",
					"count as the same suit",
					"{C:inactive}(First suit changes each round){}"
				},
			},
			["j_minty_treatovision_flavor"] = {
				["name"] = "Treat-o-vision",
				["text"] = {
					"{V:1}#1#{} and {C:minty_3s}#2#{} suits",
					"count as the same suit",
					"{C:inactive}(First suit changes each round){}",
					" ",
					"{C:inactive,s:0.8}Hey would you mind slathering yourself",
					"{C:inactive,s:0.8}in BBQ sauce real quick? No reason.{}",
				},
			},
			["j_minty_wildsupport"] = {
				["name"] = "Wild Support",
				["text"] = {
					"Played {C:attention}Wild Cards{} give {C:green}#1#{} of",
					"up to {C:mult}#2#{} Mult (+{C:mult}#7#{}),",
					"up to {X:mult,C:white}X#3#{} Mult (+{X:mult,C:white}X#8#{}),",
					"up to {C:chips}#4#{} Chips (+{C:chips}#9#{}),",
					"or up to {C:money}$#5#{} (+{C:money}$#10#{}),",
					"and {C:green}#1# in #6#{} chance to",
					"increase maximum value"
				},
			},
			["j_minty_wildsupport_flavor"] = {
				["name"] = "Wild Support",
				["text"] = {
					"Played {C:attention}Wild Cards{} give {C:green}#1#{} of",
					"up to {C:mult}#2#{} Mult (+{C:mult}#7#{}),",
					"up to {X:mult,C:white}X#3#{} Mult (+{X:mult,C:white}X#8#{}),",
					"up to {C:chips}#4#{} Chips (+{C:chips}#9#{}),",
					"or up to {C:money}$#5#{} (+{C:money}$#10#{}),",
					"and {C:green}#1# in #6#{} chance to",
					"increase maximum value",
					" ",
					"{C:inactive,s:0.8}This is definitely fine.{}",
				},
			},
			["j_minty_scoundrel"] = {
				["name"] = "The Scoundrel",
				["text"] = {
					"Whenever a {C:attention}#1#{}",
					"hits, retrigger it {C:attention}#2#{} time#3#",
					"and gain {C:attention}1{} retrigger",
					"{C:inactive}(Maximum of 7)",
				},
			},
			["j_minty_scoundrel_flavor"] = {
				["name"] = "The Scoundrel",
				["text"] = {
					"Whenever a {C:attention}#1#{}",
					"hits, retrigger it {C:attention}#2#{} time#3#",
					"and gain {C:attention}1{} retrigger",
					"{C:inactive}(Maximum of 7)",
					" ",
					"{C:inactive,s:0.8}*bites you cutely* ;3"
				},
			},
			["j_minty_manacompressor"] = {
				["name"] = "Mana Compressor",
				["text"] = {
					"Strips enhancement from",
					"the next played {C:attention}#1#{}",
					"All consumed enhancements",
					"count as each other",
				},
			},
			["j_minty_manacompressor_flavor"] = {
				["name"] = "Mana Compressor",
				["text"] = {
					"Strips enhancement from",
					"the next played {C:attention}#1#{}",
					"All consumed enhancements",
					"count as each other",
					" ",
					"{C:inactive,s:0.8}As long as it doesn't have Annihilator amirite?{}"
				},
			},
			["j_minty_bonkdice"] = {
				["name"] = "Bonkin' Dice",
				["text"] = {
					"{C:mult}+#1#-#2#{} Mult, {C:attention}twice{}",
					"{C:mult}+#3#{} to max value",
					"whenever it is rolled",
				},
			},
			["j_minty_bonkdice_flavor"] = {
				["name"] = "Bonkin' Dice",
				["text"] = {
					"{C:mult}+#1#-#2#{} Mult, {C:attention}twice{}",
					"{C:mult}+#3#{} to max value",
					"whenever it is rolled",
					" ",
					"{C:inactive,s:0.8}Maybe him skill issue?{}",
				},
			},
			["j_minty_contraption"] = {
				["name"] = "The Contraption",
				["text"] = {
					"{C:chips}+#1#{} Chips",
					"When a {C:attention}#2#{} is scored",
					"{C:green}N in #3#{} chance to add",
					"its extra Chips to this Joker's Chips",
					"where N is the number of",
					"scoring #2#s in the hand",
				},
			},
			["j_minty_contraption_flavor"] = {
				["name"] = "The Contraption",
				["text"] = {
					"{C:chips}+#1#{} Chips",
					"When a {C:attention}#2#{} is scored",
					"{C:green}N in #3#{} chance to add",
					"its extra Chips to this Joker's Chips",
					"where N is the number of",
					"scoring #2#s in the hand",
					" ",
					"{C:inactive,s:0.8}No, we're not throwing green people into it.{}",
				},
			},
			["j_minty_nucleation"] = {
				["name"] = "Nucleation",
				["text"] = {
					"{C:chips}+#1#{} Chips per {C:attention}Crystal Card",
					"in deck or shattered",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive})",
					"{C:green}#3# in #4#{} chance for {C:attention}unscored{}",
					"cards to become {C:attention}Crystal{}",
				},
			},
			["j_minty_nucleation_flavor"] = {
				["name"] = "Nucleation",
				["text"] = {
					"{C:chips}+#1#{} Chips per {C:attention}Crystal Card",
					"in deck or shattered",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive})",
					"{C:green}#3# in #4#{} chance for {C:attention}unscored{}",
					"cards to become {C:attention}Crystal{}",
					" ",
					"{C:inactive,s:0.8}This {C:attention,s:0.8}crystal{C:inactive,s:0.8} is the",
					"{C:purple,s:0.8}crystal{} {C:chips,s:0.8}crystal{} {C:gold,s:0.8}crystal{}",
					"{C:mult,s:0.8}crystal{} {C:minty_3s,s:0.8}crystal{} {C:dark_edition,s:0.8}crystal{}",
					"{C:inactive,s:0.5}what{}"
				},
			},
			["j_minty_altar"] = {
				["name"] = "The Altar",
				["text"] = {
					"Gains {C:mult}+#1#{} Mult for each",
					"scored {C:attention}#3#{} of {V:1}#4#{}",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive})",
                    "{s:0.8}Card changes every round",
				},
			},
			["j_minty_altar_flavor"] = {
				["name"] = "The Altar",
				["text"] = {
					"Gains {C:mult}+#1#{} Mult for each",
					"scored {C:attention}#3#{} of {V:1}#4#{}",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive})",
                    "{s:0.8}Card changes every round",
					" ",
					"{C:inactive,s:0.8}Seems like a good spot{}",
					"{C:inactive,s:0.8}to place an idol...{}",
				},
			},
			["j_minty_numberslop"] = {
				["name"] = "Ugh, more numberslop",
				["text"] = {
					"{C:mult}+#1#{} Mult, strictly",
					"better than Jimbo?!",
					"How dare they put",
					"this OP crap in Common!",
				},
			},
			["j_minty_numberslop_flavor"] = {
				["name"] = "Ugh, more numberslop",
				["text"] = {
					"{C:mult}+#1#{} Mult, strictly",
					"better than Jimbo?!",
					"How dare they put",
					"this OP crap in Common!",
					" ",
					"{C:inactive,s:0.8}These lazy Joker Forge mods{}",
					"{C:inactive,s:0.8}always do this kind of shit!{}",
				},
			},
			["j_minty_fate"] = {
				["name"] = "Fate",
				["text"] = {
					"{C:mult}Fixed {C:green}#1# in #2#{} chance of",
					"a {C:mult}fixed {C:green}#3# in #4#{} chance",
				},
			},
			["j_minty_fate_flavor"] = {
				["name"] = "Fate",
				["text"] = {
					"{C:mult}Fixed {C:green}#1# in #2#{} chance of",
					"a {C:mult}fixed {C:green}#3# in #4#{} chance",
					" ",
					"{C:inactive,s:0.8}The other half is luck.{}",
				},
			},
			["j_minty_optimist"] = {
				["name"] = "Optimist",
				["text"] = {
					"When any {C:green}chance{} succeeds,",
					"gains {X:black,C:white}#2#X{} the",
					"{C:green}numerator{} as {X:mult,C:white}xMult{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})",
				},
			},
			["j_minty_optimist_flavor"] = {
				["name"] = "Optimist",
				["text"] = {
					"When any {C:green}chance{} succeeds,",
					"gains {X:black,C:white}#2#X{} the",
					"{C:green}numerator{} as {X:mult,C:white}xMult{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})",
					" ",
					"{C:inactive,s:0.8}It'll all work out!{}",
				},
			},
			["j_minty_pessimist"] = {
				["name"] = "Pessimist",
				["text"] = {
					"When any {C:green}chance{} fails,",
					"gains {X:black,C:white}#2#X{} the",
					"{C:green}denominator{} as {C:chips}+Chips{}",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive})",
					"{C:inactive,s:0.8}({B:1,C:white,s:0.8}Falls off rapidly{C:inactive,s:0.8} once",
					"{C:inactive,s:0.8}denominator exceeds 7.5)",
				},
			},
			["j_minty_pessimist_flavor"] = {
				["name"] = "Pessimist",
				["text"] = {
					"When any {C:green}chance{} fails,",
					"gains {X:black,C:white}#2#X{} the",
					"{C:green}denominator{} as {C:chips}+Chips{}",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive})",
					"{C:inactive,s:0.8}({B:1,C:white,s:0.8}Falls off rapidly{C:inactive,s:0.8} once",
					"{C:inactive,s:0.8}denominator exceeds 7.5)",
					" ",
					"{C:inactive,s:0.8}You can't count on luck...{}",
				},
			},
			["j_minty_printer"] = {
				["name"] = "Printer",
				["text"] = {
					"At round start, print a",
					"{C:attention}playing card{} with a random",
					"{C:attention}enhancement{} and add it to hand"
				},
			},
			["j_minty_printer_flavor"] = {
				["name"] = "Printer",
				["text"] = {
					"At round start, print a",
					"{C:attention}playing card{} with a random",
					"{C:attention}enhancement{} and add it to hand",
					" ",
					"{C:inactive,s:0.8}And then I've got like, 55..."
				},
			},
			["j_minty_obsession"] = {
				["name"] = "Obsession",
				["text"] = {
					"Retriggers all cards",
					"of rank {C:attention}#1#{}, {C:blue}#2#{} time#3#",
					"{C:inactive}(Rank selected randomly on spawn)",
				},
			},
			["j_minty_obsession_flavor"] = {
				["name"] = "Obsession",
				["text"] = {
					"Retriggers all cards",
					"of rank {C:attention}#1#{}, {C:blue}#2#{} time#3#",
					"{C:inactive}(Rank selected randomly on spawn)",
					" ",
					"{C:inactive,s:0.8}I always feel like, somebody's watching me..."
				},
			},
			["j_minty_hamburger"] = {
				["name"] = "Delicious Hamburger",
				["text"] = {
					"{C:chips}+#1#{} hands",
					"{C:attention}-1{} per round"
				},
			},
			["j_minty_hamburger_flavor"] = {
				["name"] = "Delicious Hamburger",
				["text"] = {
					"{C:chips}+#1#{} hands",
					"{C:attention}-1{} per round",
					" ",
					"{C:inactive,s:0.8}Girls will literally eat it"
				},
			},
			j_minty_prism = {
				name = "//cat.exe -prism",
				text = {
					{
						"When setting blind,",
						"create a {C:attention}Backup Plan{}",
						"if you don't have one"
					},
					{
						"{X:mult,C:white}X#1#{} Mult per",
						"suit in hand: {X:mult,C:white}X#2#{}"
					}
				}
			},
			j_minty_prism_flavor = {
				name = "//cat.exe -prism",
				text = {
					{
						"When setting blind,",
						"create a {C:attention}Backup Plan{}",
						"if you don't have one"
					},
					{
						"{X:mult,C:white}X#1#{} Mult per",
						"suit in hand: {X:mult,C:white}X#2#{}",
						" ",
						"{C:inactive,s:0.8}The power of friendship!"
					}
				}
			},
			j_minty_lazarus = {
				name = "Lazarus Machine",
				text = {
					"{C:attention}Drain{} energy from up to #1#",
					"scored playing cards each hand",
					"{C:inactive}(Cards with {C:attention}editions{C:inactive} are worth extra)",
					"Upon siphoning {C:mult}#3#{C:inactive}(#2#){} total",
					"energy, {C:red}self-destruct{}",
					"and create {C:dark_edition}The Soul{}"
				}
			},
			j_minty_lazarus_flavor = {
				name = "Lazarus Machine",
				text = {
					"{C:attention}Drain{} energy from up to #1#",
					"scored playing cards each hand",
					"{C:inactive}(Cards with {C:attention}editions{C:inactive} are worth extra)",
					"Upon siphoning {C:mult}#3#{C:inactive}(#2#){} total",
					"energy, {C:red}self-destruct{}",
					"and create {C:dark_edition}The Soul{}",
					" ",
					"{C:inactive,s:0.8}All ghosts have unfinished business.",
					"{C:inactive,s:0.8}That's why they don't cross over."
				}
			},
			--HEY FUTURE MINTY, PUT NEW JOKERS ⬆️HERE⬆️ :P 
			j_minty_template = {
				name = "Joker Template",
				text = {
					"Does something",
				},
			},
			["j_minty_template_flavor"] = {
				["name"] = "Joker Template",
				["text"] = {
					"Does something",
					" ",
					"{C:inactive,s:0.8}And has flavor text!{}",
				},
			},
			["j_minty_catnipfields"] = {
				["name"] = "Catnip Fields",
				["text"] = {
					"{C:minty_3s}3s{} give {X:mult,C:white}X#1#{} Mult when scored",
					"Increases by {X:mult,C:white}X#2#{} Mult for each ",
					"consecutively scored {C:minty_3s}3{}",
					"{C:inactive}(Resets after each hand played)",
				},
			},
			["j_minty_catnipfields_flavor"] = {
				["name"] = "Catnip Fields",
				["text"] = {
					"{C:minty_3s}3s{} give {X:mult,C:white}X#1#{} Mult when scored",
					"Increases by {X:mult,C:white}X#2#{} Mult for each ",
					"consecutively scored {C:minty_3s}3{}",
					"{C:inactive}(Resets after each hand played)",
					" ",
					"{C:inactive,s:0.8}Cats come from across the land to frolic here.{}",
				},
			},
		},
		["Back"] = {
			["b_minty_treat"] = {
				["name"] = "Deck with a Treat",
				["text"] = {
					"Starts with a",
					"full set of 13 {C:minty_3s}3s{}",
				},
				["unlock"] = {
					"Discover {C:attention}#1#{} Jokers",
					"from {C:legendary}Menthol{}"
				}
			},
			["b_minty_suitfocus"] = {
				["name"] = "Suit Focus Deck",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:attention}#1#{}",
					"and {C:attention}#2#{} tarot",
				},
				["unlock"] = {
					"Discover #1# {V:1}sins{},",
					"#2# {V:2}minerals{}, and",
					"#3# {V:3}arcana{}."
				},
			},
			["b_minty_plasmaathome"] = {
				["name"] = "We Have Plasma Deck At Home",
				["text"] = {
					"Score by Chips {C:attention}plus{} Mult",
					"Blind size is {C:attention}square-root{}'d"
				},
				["unlock"] = {
					"Win a run with any deck",
					"on at least",
					"{C:stake_minty_sky}Sky Stake{} difficulty"
				}
			},
			["b_minty_hearts"] = {
				["name"] = "Deck of the Heart",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:hearts}Lusty Joker{}",
					"and {C:attention}The Sun{} tarot",
				},
				["unlock"] = {
					"Discover a {V:1}sin{},",
					"a {V:2}mineral{}, and",
					"an {V:3}arcanum{}."
				},
			},
			["b_minty_diamonds"] = {
				["name"] = "Deck of the Diamond",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:diamonds}Greedy Joker{}",
					"and {C:attention}The Star{} tarot",
				},
				["unlock"] = {
					"Discover a {V:1}sin{},",
					"a {V:2}mineral{}, and",
					"an {V:3}arcanum{}."
				},
			},
			["b_minty_clubs"] = {
				["name"] = "Deck of the Club",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:clubs}Gluttonous Joker{}",
					"and {C:attention}The Moon{} tarot",
				},
				["unlock"] = {
					"Discover a {V:1}sin{},",
					"a {V:2}mineral{}, and",
					"an {V:3}arcanum{}."
				},
			},
			["b_minty_spades"] = {
				["name"] = "Deck of the Spade",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:spades}Wrathful Joker{}",
					"and {C:attention}The World{} tarot",
				},
				["unlock"] = {
					"Discover a {V:1}sin{},",
					"a {V:2}mineral{}, and",
					"an {V:3}arcanum{}."
				},
			},
			["b_minty_3suit"] = {
				["name"] = "Deck of the 3",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:minty_3s}Hedonist Joker{}",
					"and {C:attention}The Cat{} tarot",
				},
				["unlock"] = {
					"Discover a {V:1}sin{},",
					"a {V:2}mineral{}, and",
					"an {V:3}arcanum{}."
				},
			},
			["b_minty_drippy"] = {
				["name"] = "Drippy Deck",
				["text"] = {
                    "Every {C:attention}played card{}",
                    "counts in scoring",
				},
			},
			["b_minty_sillylittledeck"] = {
				["name"] = "The Silliest, Littlest Deck",
				["text"] = {
					"{C:legendary}Menthol{C:attention} Jokers{} are {C:attention}3x",
					"more likely to appear",
				},
			},
		},
		["Blind"] = {
			["bl_minty_thenip"] = {
				["name"] = "The Nip",
				["text"] = {
					"All 3s are debuffed",
				},
			},
			["bl_minty_thenipdx"] = {
				["name"] = "The Nip DX",
				["text"] = {
					"All non-3 cards",
					"are debuffed",
				},
			},
			["bl_minty_thetree"] = {
				["name"] = "The Tree",
				["text"] = {
					"Hand must contain 3s",
				},
			},
			["bl_minty_calico_counter"] = {
				["name"] = "Calico on the Counter",
				["text"] = {
					"#1# in #2# cards are drawn face-down,",
					"#1# in #2# cards are debuffed when drawn",
				},
			},
			["bl_minty_claw"] = {
				["name"] = "A Claw",
				["text"] = {
					"Debuff first#1#",
					"card#2# drawn",
				},
			},
			["bl_minty_tooth"] = {
				["name"] = "A Tooth",
				["text"] = {
					"Flip first#1#",
					"card#2# drawn",
				},
			},
			["bl_minty_paw"] = {
				["name"] = "A Paw",
				["text"] = {
					"Play limit #1# for",
					"first hand unless",
					"an item is sold"
				},
			},
			["bl_minty_tail"] = {
				["name"] = "A Tail",
				["text"] = {
					"Discard limit #1#",
					"for first discard"
				},
			},
		},
		["Tarot"] = {
			["c_minty_cat"] = {
				["name"] = "The Cat",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:minty_3s}#4#{}",
				},
			},
			["c_minty_cat_flavor"] = {
				["name"] = "The Cat",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:minty_3s}#4#{}",
					" ",
					"{C:inactive,s:0.8}Meow! :3",
				},
			},
			["c_minty_focus"] = {
				["name"] = "The Focus",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to {V:1}#3#{}",
				},
			},
			["c_minty_focus_flavor"] = {
				["name"] = "The Focus",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to {V:1}#3#{}",
					" ",
					"{C:inactive,s:0.8}Target sighted..."
				},
			},
			["c_minty_grin"] = {
				["name"] = "The Grin",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to random {C:attention}face card#3#{}",
				},
			},
			["c_minty_grin_flavor"] = {
				["name"] = "The Grin",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to random {C:attention}face card#3#{}",
					" ",
					"{C:inactive,s:0.8}You smirk. Critical hit rate up!",
					"{C:inactive,s:0.8}... which does nothing in this game!"
				},
			},
			["c_minty_abacus"] = {
				["name"] = "The Abacus",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to random {C:attention}number card#3#{}",
				},
			},
			["c_minty_abacus_flavor"] = {
				["name"] = "The Abacus",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to random {C:attention}number card#3#{}",
					" ",
					"{C:inactive,s:0.8}32.33 (repeating, of course)!"
				},
			},
			["c_minty_boredkid"] = {
				["name"] = "The Bored Child",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Marble Card#2#{}",
				},
			},
			["c_minty_boredkid_flavor"] = {
				["name"] = "The Bored Child",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Marble Card#2#{}",
					" ",
					"{C:inactive,s:0.8}Well, what if I threw rocks at you?",
				},
			},
			["c_minty_dorf"] = {
				["name"] = "The Dwarf",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Microcline Card#2#{}",
				},
			},
			["c_minty_dorf_flavor"] = {
				["name"] = "The Dwarf",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Microcline Card#2#{}",
					" ",
					"{C:inactive,s:0.8}Strike the earth!",
				},
			},
			["c_minty_battery"] = {
				["name"] = "The Battery",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Static Card#2#{}",
				},
			},
			["c_minty_battery_flavor"] = {
				["name"] = "The Battery",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Static Card#2#{}",
					" ",
					"{C:inactive,s:0.8}Tales of the ancient",
					"{C:inactive,s:0.8}'nine-volt' remain unsubstantiated",
				},
			},
			["c_minty_gleam"] = {
				["name"] = "The Gleam",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Crystal Card#2#{}",
				},
			},
			["c_minty_gleam_flavor"] = {
				["name"] = "The Gleam",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Crystal Card#2#{}",
					" ",
					"{C:inactive,s:0.8}But consider: SHINY",
				},
			},
			["c_minty_magnet"] = {
				["name"] = "The Magnet",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Hematite Card#2#{}",
				},
			},
			["c_minty_magnet_flavor"] = {
				["name"] = "The Magnet",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to #3#{C:attention}Hematite Card#2#{}",
					" ",
					"{C:inactive,s:0.8}... but how does it work?"
				},
			},
			["c_minty_geologist"] = {
				["name"] = "The Geologist",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to random {C:attention}#4#{}",
				},
			},
			["c_minty_geologist_flavor"] = {
				["name"] = "The Geologist",
				["text"] = {
					"Converts up to",
					"{C:attention}#1#{} selected card#2#",
					"to random {C:attention}#4#{}",
					" ",
					"{C:inactive,s:0.8}Please look at these cool rocks{}"
				},
			},
			["c_minty_bitz"] = {
				["name"] = "The Bitz",
				["text"] = {
					"Summon a {C:legendary}normal{}",
					"{C:chips,E:1}Kity{} Joker",
					"{C:inactive}(Must have room){}",
				},
			},
			["c_minty_bitz_flavor"] = {
				["name"] = "The Bitz",
				["text"] = {
					"Summon a {C:legendary}normal{}",
					"{C:chips,E:1}Kity{} Joker",
					"{C:inactive}(Must have room){}",
					" ",
					'{C:inactive,s:0.8}"... now with a dash of bonito flakes{}',
					'{C:inactive,s:0.8}to fuel your cats\' active lifestyles!{}',
				},
			},
			["c_minty_headband"] = {
				["name"] = "The Headband",
				["text"] = {
					"Applies {C:spectral}Cat Ears{} to",
					"#2##1# selected Joker#3#"
				},
			},
			["c_minty_headband_flavor"] = {
				["name"] = "The Headband",
				["text"] = {
					"Applies {C:spectral}Cat Ears{} to",
					"#2##1# selected Joker#3#",
					" ",
					"{C:inactive,s:0.8}Add some striped socks and estrogen and",
					"{C:inactive,s:0.8}you'll be ready to make your own mod :3"
				},
			},
		},
		["Spectral"] = {
			["c_minty_6years"] = {
				["name"] = "6 years",
				["text"] = {
					"Add a {C:cement}Cement Seal{}",
					"to {C:attention}1{} selected",
					"card in your hand",
				},
			},
			["c_minty_6years_flavor"] = {
				["name"] = "6 years",
				["text"] = {
					"Add a {C:cement}Cement Seal{}",
					"to {C:attention}1{} selected",
					"card in your hand",
					" ",
					"{C:inactive,s:0.8}... in the joint made you",
					"{C:inactive,s:0.8}a - no? Wrong meme?",
				},
			},
			["c_minty_dekaja"] = {
				["name"] = "Dekaja",
				["text"] = {
					"Remove all {C:attention}modifiers{}",
					"from #2#{C:attention}#1#{} selected",
					"card#3# or Joker#3#",
				},
			},
			["c_minty_dekaja_flavor"] = {
				["name"] = "Dekaja",
				["text"] = {
					"Remove all {C:attention}modifiers{}",
					"from #2#{C:attention}#1#{} selected",
					"card#3# or Joker#3#",
					" ",
					"{C:inactive,s:0.8}Act now and we'll throw in",
					"{C:inactive,s:0.8}a bonus Dekunda for free!",
				},
			},
			["c_minty_reincarnate"] = {
				["name"] = "Reincarnate",
				["text"] = {
					"Destroy #2##1# {C:attention}Joker#3#{}",
					"and create #4#new cop#5# of #6#"
				},
			},
			["c_minty_reincarnate_flavor"] = {
				["name"] = "Reincarnate",
				["text"] = {
					"Destroy #2##1# {C:attention}Joker#3#{}",
					"and create #4#new cop#5# of #6#",
					" ",
					"{C:inactive,s:0.8}You feel like a new Joker!{}"
				},
			},
			["c_minty_piracy"] = {
				["name"] = "Piracy",
				["text"] = {
					"{C:attention}Illegally{} copy 1",
					"selected card from any",
					"booster pack or shop"
				},
			},
			["c_minty_piracy_flavor"] = {
				["name"] = "Piracy",
				["text"] = {
					"{C:attention}Illegally{} copy 1",
					"selected card from any",
					"booster pack or shop",
					" ",
					"{C:inactive,s:0.8}I would download a Blueprint, actually"
				},
			},
			["c_minty_delicacy"] = {
				["name"] = "Ultimate Delicacy",
				["text"] = {
					"Add {C:dark_edition}Negative{} to",
					"all held Jokers",
					"{C:mult}Never spawns again{}",
					"{C:mult}once used{}",
				},
			},
			["c_minty_delicacy_flavor"] = {
				["name"] = "Ultimate Delicacy",
				["text"] = {
					"Add {C:dark_edition}Negative{} to",
					"all held Jokers",
					"{C:mult}Never spawns again{}",
					"{C:mult}once used{}",
					" ",
					"{C:inactive,s:0.8}Unable to see anything but the{}",
					"{C:inactive,s:0.8}transcendent glow of perfection!{}",
				},
			},
			["c_minty_wand"] = {
				["name"] = "The Wand",
				["text"] = {
					"Summon a {C:legendary,E:1}Legendary",
					"{C:legendary,E:1}Kity{} Joker",
					"{C:inactive}(Must have room)",
				},
			},
			["c_minty_wand_flavor"] = {
				["name"] = "The Wand",
				["text"] = {
					"Summon a {C:legendary,E:1}Legendary",
					"{C:legendary,E:1}Kity{} Joker",
					"{C:inactive}(Must have room)",
					" ",
					"{C:inactive,s:0.8}RUN POUNCE CHASE HUNT"
				},
			},
		},
		["Planet"] = {
			["c_minty_rockplanet"] = {
				["name"] = "Rock Planets"
			},
			["c_minty_twinrockplanet"] = {
				["name"] = "Twin Rock Planets"
			},
			["c_minty_diffrockplanet"] = {
				["name"] = "Different Rock Planets"
			},
			["c_minty_rockdimension"] = { --can't use process_loc_text for this cause we load before Cryptid
				["name"] = "Rock Dimension",
				["text"] = {
					"({V:1}lvl.#4#{})({V:2}lvl.#5#{})({V:3}lvl.#6#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
				}
			},
		},
		["Tag"] = {
			["tag_minty_goading"] = {
				["name"] = "Goading Tag",
				["text"] = {
					"When {C:mult}Boss Blind{} defeated",
					"with at least {C:chips}1 hand{} left,",
					"{C:attention}revive it{} and create",
					"a {C:purple}Menu Tag{}"
				}
			},
			["tag_minty_menu"] = {
				["name"] = "Menu Tag",
				["text"] = {
					"Gives a free {C:purple}Treat Pack{}"
				}
			},
		},
		["minty_treat"] = {
			["c_minty_choccytreat"] = {
				["name"] = "Chocolate Cake",
				["text"] = {
					"Add {C:dark_edition}Negative{} to",
					"{C:attention}#1#{} selected Joker#2#"
				}
			},
			["c_minty_choccytreat_flavor"] = {
				["name"] = "Chocolate Cake",
				["text"] = {
					"Add {C:dark_edition}Negative{} to",
					"{C:attention}#1#{} selected Joker#2#",
					" ",
					"{C:inactive,s:0.8}CHOCOLAAAAAAATE???{}"
				}
			},
			["c_minty_ice_cream"] = {
				["name"] = "Mint Ice Cream",
				["text"] = {
					"Increase {C:green}play limit{}",
					"by {C:attention}#1# card#2#{}"
				}
			},
			["c_minty_ice_cream_flavor"] = {
				["name"] = "Mint Ice Cream",
				["text"] = {
					"Increase {C:green}play limit{}",
					"by {C:attention}#1# card#2#{}",
					" ",
					"{C:inactive,s:0.8}Yes, yes, insert obligatory joke here.{}"
				}
			},
			["c_minty_blueberry_pie"] = {
				["name"] = "Blueberry Pie",
				["text"] = {
					"Increase {C:chips}discard limit{}",
					"by {C:attention}#1# card#2#{}"
				}
			},
			["c_minty_blueberry_pie_flavor"] = {
				["name"] = "Blueberry Pie",
				["text"] = {
					"Increase {C:chips}discard limit{}",
					"by {C:attention}#1# card#2#{}",
					" ",
					"{C:inactive,s:0.8}Guaranteed not to cause{}",
					"{C:inactive,s:0.8}gratuitous inflation{}",

				}
			},
			["c_minty_funnel_cake"] = {
				["name"] = "Funnel Cake",
				["text"] = {
					"Gives {C:money}$#1#{}",
					"Increases by",
					"{C:money}$#2#{} each Ante",
				}
			},
			["c_minty_funnel_cake_flavor"] = {
				["name"] = "Funnel Cake",
				["text"] = {
					"Gives {C:money}$#1#{}",
					"Increases by",
					"{C:money}$#2#{} each Ante",
					" ",
					"{C:inactive,s:0.8}cronch cronch cronch{}"
				}
			},
		},
		minty_cobalt = {
			c_minty_backup_plan = {
				name = "Backup Plan",
				text = {
					"Draw 1 card of",
					"each suit from",
					"your deck"
				}
			}
		},
		["Sleeve"] = {
			["sleeve_minty_treatsleeve"] = {
				["name"] = "Sleeve with a Treat",
				["text"] = {
					"Starts with a",
					"full set of 13 {C:minty_3s}3s{}",
				},
			},
			["sleeve_minty_treatsleeve_alt"] = {
				["name"] = "Sleeve with a Treat",
				["text"] = {
					"Starts with a full set of 13 {C:minty_3s}3s{}",
					"All 3s become 3s of {C:minty_3s}3s{}",
					"{C:green}1 in 3{} other cards change rank to 3",
					"{C:green}1 in 3{} other cards change suit to {C:minty_3s}3s{}",
				},
			},
			["sleeve_minty_suitfocussleeve"] = {
				["name"] = "Suit Focus Sleeve",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:attention}#1#{}",
					"and {C:attention}#2#{} tarot",
				},
			},
			["sleeve_minty_suitfocussleeve_alt"] = {
				["name"] = "Suit Focus Sleeve",
				["text"] = {
					"Also start with",
					"an {C:attention}eternal{} {C:attention}#1#{}",
				},
			},
			["sleeve_minty_suitfocussleeve_fusionalt"] = {
				["name"] = "Suit Focus Sleeve",
				["text"] = {
					"Instead start with",
					"an {C:attention}eternal{} {C:attention}#1#{}",
				},
			},
			["sleeve_minty_heartsleeve"] = {
				["name"] = "Sleeve of the Heart",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:hearts}Lusty Joker{}",
					"and {C:attention}The Sun{} tarot",
				},
			},
			["sleeve_minty_heartsleeve_alt"] = {
				["name"] = "Sleeve of the Heart",
				["text"] = {
					"Also start with",
					"an {C:attention}eternal{} {C:hearts}Bloodstone{}",
				},
			},
			["sleeve_minty_heartsleeve_fusionalt"] = {
				["name"] = "Sleeve of the Heart",
				["text"] = {
					"Instead start with an",
					"{C:attention}eternal{} {C:hearts}Heart Paladin{}",
				},
			},
			["sleeve_minty_diamondsleeve"] = {
				["name"] = "Sleeve of the Diamond",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:diamonds}Greedy Joker{}",
					"and {C:attention}The Star{} tarot",
				},
			},
			["sleeve_minty_diamondsleeve_alt"] = {
				["name"] = "Sleeve of the Diamond",
				["text"] = {
					"Also start with",
					"an {C:attention}eternal{} {C:diamonds}Rough Gem{}",
				},
			},
			["sleeve_minty_diamondsleeve_fusionalt"] = {
				["name"] = "Sleeve of the Diamond",
				["text"] = {
					"Instead start with an",
					"{C:attention}eternal{} {C:diamonds}Diamond Bard{}",
				},
			},
			["sleeve_minty_clubssleeve"] = {
				["name"] = "Sleeve of the Club",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:clubs}Gluttonous Joker{}",
					"and {C:attention}The Moon{} tarot",
				},
			},
			["sleeve_minty_clubssleeve_alt"] = {
				["name"] = "Sleeve of the Club",
				["text"] = {
					"Also start with",
					"an {C:attention}eternal{} {C:clubs}Onyx Agate{}",
				},
			},
			["sleeve_minty_clubssleeve_fusionalt"] = {
				["name"] = "Sleeve of the Club",
				["text"] = {
					"Instead start with an",
					"{C:attention}eternal{} {C:clubs}Club Wizard{}",
				},
			},
			["sleeve_minty_spadessleeve"] = {
				["name"] = "Sleeve of the Spade",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:spades}Wrathful Joker{}",
					"and {C:attention}The World{} tarot",
				},
			},
			["sleeve_minty_spadessleeve_alt"] = {
				["name"] = "Sleeve of the Spade",
				["text"] = {
					"Also start with",
					"an {C:attention}eternal{} {C:spades}Arrowhead{}",
				},
			},
			["sleeve_minty_spadessleeve_fusionalt"] = {
				["name"] = "Sleeve of the Spade",
				["text"] = {
					"Instead start with an",
					"{C:attention}eternal{} {C:spades}Spade Archer{}",
				},
			},
			["sleeve_minty_3suitsleeve"] = {
				["name"] = "Sleeve of the 3",
				["text"] = {
					"Start with an",
					"{C:attention}eternal{} {C:minty_3s}Hedonist Joker{}",
					"and {C:attention}The Cat{} tarot",
				},
			},
			["sleeve_minty_3suitsleeve_alt"] = {
				["name"] = "Sleeve of the 3",
				["text"] = {
					"Also start with",
					"an {C:attention}eternal{} {C:minty_3s}Fossilized Claw{}",
				},
			},
			["sleeve_minty_3suitsleeve_fusionalt"] = {
				["name"] = "Sleeve of the 3",
				["text"] = {
					"Instead start with",
					"{C:minty_3s}Three{} {C:attention}eternal{} {C:minty_3s}Cats!{}",
				},
			},
			["sleeve_minty_sillylittlesleeve"] = {
				["name"] = "The Silliest, Littlest Sleeve",
				["text"] = {
					"{C:legendary}Menthol{C:attention} Jokers{} are {C:attention}3x",
					"more likely to appear",
				},
			},
			["sleeve_minty_sillylittlesleeve_alt"] = {
				["name"] = "The Silliest, Littlest Sleeve",
				["text"] = {
					"Other {C:legendary}Menthol{} items are {C:attention}2x",
					"more likely to appear",
				},
			},
			["sleeve_minty_drippysleeve"] = {
				["name"] = "Drippy Sleeve",
				["text"] = {
                    "Every {C:attention}played card{}",
                    "counts in scoring",
				},
			},
			["sleeve_minty_drippysleeve_alt"] = {
				["name"] = "Drippy Sleeve",
				["text"] = {
                    "{C:attention}Held cards{} also",
                    "count in scoring",
				},
			},
		},
		["Enhanced"] = {
			["m_stone_alt"] = {
				["name"] = "Slate Card"
			},
			["m_minty_marble"] = {
				["name"] = "Marble Card",
				["label"] = "Marble Card",
				["text"] = {
					"No rank, can be",
					"used as any suit",
					"{C:money}$#1#{}, {C:chips}+#2#{} Chips, and",
					"{C:mult}+#3#{} Mult when scored"
				}
			},
			["m_minty_garbled"] = {
				["name"] = "Garbled Card",
				["label"] = "Garbled Card",
				["text"] = {
				}
			},
			["m_minty_microcline"] = {
				["name"] = "Microcline Card",
				["label"] = "Microcline Card",
				["text"] = {
					"No rank, no suit",
					"{C:chips}+#1#{} Chips when held"
				}
			},
			["m_minty_spline"] = {
				["name"] = "Spline Card",
				["label"] = "Spline Card",
				["text"] = {
					"{C:green}#1# in #2#{} chance",
					"to gain {C:chips}+#3#{} permanent",
					"Chips when scored",
				}
			},
			["m_minty_hematite"] = {
				["name"] = "Hematite Card",
				["label"] = "Hematite Card",
				["text"] = {
					"No rank, no suit",
					"{C:chips}+#1#{} Chips when scored",
					"{X:mult,C:white}X#2#{} Mult when held"
				}
			},
			["m_minty_dynamite"] = {
				["name"] = "Dynamite Card",
				["label"] = "Dynamite Card",
				["text"] = {
					"Reduce Blind size by {C:mult}#1#%{}",
					"{C:mult}self-destructs{}"
				}
			},
			["m_minty_crystal"] = {
				["name"] = "Crystal Card",
				["label"] = "Crystal Card",
				["text"] = {
					"No rank, no suit",
					"{C:money}$#2#{} and {C:chips}+#1#{} Chips",
					"when scored, and {C:green}#3# in #4#{}",
					"chance to {C:attention}shatter{}"
				}
			},
			["m_minty_pistol"] = {
				["name"] = "Pistol Card",
				["label"] = "Pistol Card",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult, {C:green}#2# in #3#{}",
					"chance to play immediately",
					"upon highlighting"
				}
			},
			["m_minty_static"] = {
				["name"] = "Static Card",
				["label"] = "Static Card",
				["text"] = {
					"{C:purple}Balances{} #1#% of",
					"{C:chips}Chips{} and {C:mult}Mult{}",
					"when scored"
				}
			},
			m_minty_emphatic = {
				name = "Emphatic Card",
				label = "Emphatic Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult, {C:chips}+#2#{} Chips",
					"{C:red}self-destructs"
				},
			},
		},
		Edition = {
			e_minty_drained = {
				name = "Drained",
				text = {
					"Does not count",
					"as any suit"
				}
			}
		},
		["Voucher"] = {
			["v_minty_tabletopple"] = {
				["name"] = "Table Topple",
				["text"] = {
					"Discard up to {C:mult}#2#{} more",
					"cards at a time",
					"{C:inactive}({C:mult}#1# {C:inactive}total){}"
				}
			},
			["v_minty_catspaws"] = {
				["name"] = "Cat's Paws",
				["text"] = {
					"Discard up to {C:mult}all{}",
					"cards at a time;",
					"play up to {C:chips}#2#{} more",
					"cards at a time",
					"{C:inactive}({C:chips}#1# {C:inactive}total){}"
				},
				["unlock"] = {
					"Discard {C:attention}#1#{}{C:inactive}(#2#){} hands",
					"of {C:mult}6{} or more cards",
				}
			},
			v_minty_buoyancy = {
				name = "Buoyancy",
				text = {
					"When playing hand with",
					"discards remaining,",
					"played cards have a",
					"{C:green}#1# in #2#{} chance to",
					"return to deck"
				},
			},
			v_minty_treading = {
				name = "Treading Water",
				text = {
					"When playing hand with",
					"#1# discard#3# remaining,",
					"gain #2# discard#4#"
				}
			},
			["v_minty_treasure"] = {
				["name"] = "Treasure",
				["text"] = {
					"{C:mult}+#1#{} to",
					"{C:attention}#2#{}"
				},
				["unlock"] = {
					"Unlock the vouchers",
					"{V:1}#1#{},",
					"{V:2}#2#{},",
					"{V:3}#3#{},",
					"{V:4}#4#{},",
					"and {V:5}#5#{}.",
				}
			},
		},
		["Stake"] = {
			["stake_minty_scarlet"] = {
				["name"] = "Scarlet Stake",
				["text"] = {
					"Entering shop",
					"costs {C:gold}$1{}",
					"{s:0.8}Applies White Stake... {s:0.4}I guess..."
				}
			},
			["stake_minty_irrigo"] = {
				["name"] = "Irrigo Stake",
				["text"] = {
					"{C:blue}3rd{} hand of each",
					"round is leveled down",
                    "{s:0.8}Applies Scarlet Stake",
				}
			},
			["stake_minty_void"] = {
				["name"] = "Void Stake",
				["text"] = {
                    "Shop can have {C:attention}Counterfeit{} cards",
                    "{C:inactive,s:0.8}({C:attention,s:0.8}Costs{s:0.8} money to sell)",
                    "{s:0.8}Applies Irrigo Stake",
				}
			},
			["stake_minty_sky"] = {
				["name"] = "Sky Stake",
				["text"] = {
                    "{C:legendary}Showdown Blinds{}",
                    "appear {C:attention}twice{} as often",
                    "{s:0.8}Applies Void Stake",
				}
			},
			["stake_minty_mint"] = {
				["name"] = "Mint Stake",
				["text"] = {
					"{C:purple}Unbalance{} Chips and Mult",
					"by {C:attention}10%{} plus {C:attention}5%{} per Ante",
					"{s:0.8,C:inactive}(Maximum {s:0.8,C:attention}50%{s:0.8,C:inactive})",
                    "{s:0.8}Applies Sky Stake",
				}
			},
			["stake_minty_tungsten"] = {
				["name"] = "Tungsten Stake",
				["text"] = {
                    "Playing cards may become",
					"{C:attention}Hooked{} when modified",
                    "{C:inactive,s:0.8}(Will be {C:attention,s:0.8}discarded{C:inactive,s:0.8} if held)",
                    "{s:0.8}Applies Mint Stake",
				}
			},
			["stake_minty_catcat"] = {
				["name"] = "#CA7CA7 Stake",
				["text"] = {
					"{C:attention}+1{} Ante needed to win",
                    "{s:0.8}Applies Tungsten Stake",
				}
			},
			["stake_minty_rose_gold"] = {
				["name"] = "Rose Gold Stake",
				["text"] = {
					"Combines Gold Stake",
					"and <hash>CA7CA7 Stake",
					"{s:0.8}welcome to hell, welcome to hell{}"
				}
			},
		},
		["Colour"] = {
			["c_minty_emeowrald"] = {
				["name"] = "Emeowrald Green",
				["text"] = {
					"Converts a random card in",
					"hand to {C:minty_3s}3s{} for every",
					"{C:attention}#4#{} round this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",

				}
			},
			["c_minty_emeowrald_flavor"] = {
				["name"] = "Emeowrald Green",
				["text"] = {
					"Converts a random card in",
					"hand to {C:minty_3s}3s{} for every",
					"{C:attention}#4#{} round this has been held",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}, {}[{C:attention}#2#{C:inactive}#3#{}]{C:inactive})",
					" ",
					"{C:inactive,s:0.8}Green like a kitty's pretty eyes",
				}
			},
		},
		["Rotarot"] = {
			["c_minty_rot_cat"] = {
				["name"] = "The Cat!",
				["text"] = {
					"Add {C:attention}#1#{} random {C:attention}Enhanced",
					"{C:minty_3s}3s{} to your hand"
				},
			},
			["c_minty_rot_boredkid"] = {
				["name"] = "The Bored Child!",
				["text"] = {
					"Enhances {C:attention}#1#{} selected",
					"card into a",
					"{C:attention}#2#"
				},
			},
			["c_minty_rot_gleam"] = {
				["name"] = "The Gleam!",
				["text"] = {
					"Enhances {C:attention}#1#{} selected",
					"card into a",
					"{C:attention}#2#"
				},
			},
			["c_minty_rot_dorf"] = {
				["name"] = "The Dwarf!",
				["text"] = {
					"Reticulates up to",
					"{C:attention}#1#{} selected card#3#",
					"to #4#{C:attention}#2##3#{}",
				},
			},
			["c_minty_rot_magnet"] = {
				["name"] = "The Magnet!",
				["text"] = {
					"Enhances up to",
					"{C:attention}#1#{} selected card#3#",
					"to #4#{C:attention}#2##3#{}",
				},
			},
			c_minty_rot_battery = {
				name = "The Battery!",
				text = {
					"Enhances up to",
					"{C:attention}#1#{} selected card#3#",
					"to #4#{C:attention}#2##3#{}",
				}
			},
			["c_minty_rot_bitz"] = {
				["name"] = "The Bitz!",
				["text"] = {
					"Does something!",
					"I haven't decided what!",
				},
			},
		},
		["Packet"] = {
			["c_minty_littletreat"] = {
				["name"] = "A Little Treat",
				["text"] = {
					"{C:money}#1#{}",
					"{C:green}X#2#{} random {C:minty_3s}3s{}",
					"{C:inactive,s:0.8}(the suit)",
				}
			},
			["c_minty_smoltreat"] = {
				["name"] = "Illegally Smol Treat",
				["text"] = {
					"{C:money}#1#{}",
					"A single 3 of {C:minty_3s}3s{}",
				}
			},
		},
		["Parcel"] = {
			["c_minty_treatandmystery"] = {
				["name"] = "Treat and Mystery",
				["text"] = {
					"{C:green}X#2#{} {C:minty_3s}3s{}",
					"and {C:green}a full set{} {C:inactive,s:0.8}(probably #2#){}",
					"of another suit",
				}
			},
			["c_minty_lessthanthree"] = {
				["name"] = "<3",
				["text"] = {
					"{C:green}X#2#{} {C:minty_3s}3s{}",
					"and {C:green}X#3#{} {C:hearts}Hearts{}",
				}
			},
			["c_minty_forbiddencandy"] = {
				["name"] = "Forbidden Candy",
				["text"] = {
					"{C:green}X#2#{} {C:minty_3s}3s{}",
					"and {C:green}X#3#{} {C:diamonds}Diamonds{}",
				}
			},
			["c_minty_exclusivetreats"] = {
				["name"] = "Exclusive Treats",
				["text"] = {
					"{C:green}X#2#{} {C:minty_3s}3s{}",
					"and {C:green}X#3#{} {C:clubs}Clubs{}",
				}
			},
			["c_minty_diggingfortreats"] = {
				["name"] = "Digging for Treats",
				["text"] = {
					"{C:green}X#2#{} {C:minty_3s}3s{}",
					"and {C:green}X#3#{} {C:spades}Spades{}",
				}
			},
		},
		["Gemstone"] = {
			["c_minty_catseye"] = {
				["name"] = "Cat's Eye",
				["text"]  = {
                    "Attach a {C:minty_3s}Cat's Eye",
                    "{}Gemstone to {C:green}#1#{} selected {C:attention}card{}",
                    "{C:inactive}(Must have a Gem Slot){}",
				},
			},
			["c_minty_catseye_flavor"] = {
				["name"] = "Cat's Eye",
				["text"]  = {
                    "Attach a {C:minty_3s}Cat's Eye",
                    "{}Gemstone to {C:green}#1#{} selected {C:attention}card{}",
                    "{C:inactive}(Must have a Gem Slot){}",
					" ",
					"{C:inactive,s:0.8}It can see you...r treats.{}"
				},
			},
		},
		["Other"] = {
			["minty_cement_seal"] = {
				["label"] = "Cement Seal",
				["name"] = "Cement Seal",
				["text"] = {
					"{C:chips}+#1# Chips{}",
					"always scores",
					"resists debuffs",
				},
			},
			["p_minty_treat_normal_1"] = {
				["name"] = "Treat Pack",
				["label"] = "Treat Pack",
				["text"] = {
					"Order #1# of up to",
					"#2# delicious {C:purple}treats{}",
					"to be consumed immediately"
				}
			},
			["p_minty_everycard_normal"] = {
				["name"] = "Pack of Every Card",
				["label"] = "Pack of Every Card",
				["text"] = {
					"Select and take* #1# of up to",
					"#2# of {C:attention}every{}* card type",
					"{C:inactive}*Some exceptions apply,",
					"{C:inactive}see store for details"
				}
			},
			["p_minty_everycard_jumbo"] = {
				["name"] = "Jumbo Pack of Every Card",
				["label"] = "Jumbo Pack of Every Card",
				["text"] = {
					"Select and take* #1# of up to",
					"#2# of {C:attention}every{}* card type",
					"{C:inactive}*Some exceptions apply,",
					"{C:inactive}see store for details"
				}
			},
			["p_minty_everycard_mega"] = {
				["name"] = "Mega Pack of Every Card",
				["label"] = "Mega Pack of Every Card",
				["text"] = {
					"Select and take* #1# of up to",
					"#2# of {C:attention}every{}* card type",
					"{C:inactive}*Some exceptions apply,",
					"{C:inactive}see store for details"
				}
			},
			["p_minty_mod_normal"] = {
				["name"] = "#1# Pack",
				["label"] = "#1# Pack",
				["text"] = {
					"Select #3# of up to",
					"#4# Jokers from",
					"{V:1}#2#{}"
				}
			},
			["p_minty_mod_jumbo"] = {
				["name"] = "Jumbo #1# Pack",
				["label"] = "Jumbo #1# Pack",
				["text"] = {
					"Select #3# of up to",
					"#4# Jokers from",
					"{V:1}#2#{}"
				}
			},
			["p_minty_mod_mega"] = {
				["name"] = "Mega #1# Pack",
				["label"] = "Mega #1# Pack",
				["text"] = {
					"Select #3# of up to",
					"#4# Jokers from",
					"{V:1}#2#{}"
				}
			},
			["minty_flexweirdo_full_name"] = {
				["name"] = "His full name is...",
				["text"] = {
					"Joker Who Constantly Makes Cracks About",
					"How Good Someone Must Be In Bed If They",
					"Stretch A Slightly Unusual Distance",
					"(Like Come On Man,",
					"They're Not Even A Contortionist",
					"That's Just Normal Human Variation)",
				},
			},
			["minty_flexweirdo_full_name_flavor"] = {
				["name"] = "His full name is...",
				["text"] = {
					"Joker Who Constantly Makes Cracks About",
					"How Good Someone Must Be In Bed If They",
					"Stretch A Slightly Unusual Distance",
					"(Like Come On Man,",
					"They're Not Even A Contortionist",
					"That's Just Normal Human Variation)",
					" ",
					"{C:inactive,s:0.8}... Zippy Zappy Angel Eyes.{}"
				},
			},
			["undiscovered_minty_treat"] = {
				["name"] = "Undiscovered Treat",
				["text"] = {
					"Purchase or use",
					"this delicious treat in an",
					"unseeded run to",
					"learn what it tastes like",
				}
			},
			undiscovered_minty_cobalt = {
				name = "Undiscovered Cobalt Card",
				text = {
                    "Find this card in",
                    "an unseeded run to",
                    "learn what it does",
				}
			},
			["minty_counterfeit"] = {
				["name"] = "Counterfeit",
				["text"] = {
					"{C:attention}Costs{} money",
					"to sell"
				}
			},
			["minty_hooked"] = {
				["name"] = "Hooked",
				["text"] = {
					"Will be {C:attention}discarded{}",
					"if held",
				}
			},
			["minty_pirated"] = {
				["name"] = "Pirated",
				["text"] = {
					"Acquired {C:attention}illegally{}",
					"{C:mult}There may be consequences...{}"
				}
			},
			["minty_cat_ears"] = {
				["name"] = "Cat Ears",
				["text"] = {
					"Counts as a",
					"{C:spectral}Kity{} Joker"
				}
			},
			["gemslot_catseye"] = {
				["name"] = "Cat's Eye",
				["text"] = {
					"Attached card",
					"counts as a {C:minty_3s}3{} {C:attention}twice{}",
				},
			},
			["minty_joker_locked_kity"] = {
				["name"] = "Locked",
				["text"] = {
					"Find this Joker from",
					"the {C:spectral}Soul{} or {C:spectral}Wand{} cards",
				}
			},
			["minty_scarlet_sticker"] = {
				["name"] = "Scarlet Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_scarlet}Scarlet",
                    "{C:stake_minty_scarlet}Stake{} difficulty",
				}
			},
			["minty_irrigo_sticker"] = {
				["name"] = "Irrigo Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_irrigo}Irrigo",
                    "{C:stake_minty_irrigo}Stake{} difficulty",
				}
			},
			["minty_void_sticker"] = {
				["name"] = "Void Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_void}Void",
                    "{C:stake_minty_void}Stake{} difficulty",
				}
			},
			["minty_sky_sticker"] = {
				["name"] = "Sky Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_sky}Sky",
                    "{C:stake_minty_sky}Stake{} difficulty",
				}
			},
			["minty_mint_sticker"] = {
				["name"] = "Mint Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_mint}Mint",
                    "{C:stake_minty_mint}Stake{} difficulty",
				}
			},
			["minty_tungsten_sticker"] = {
				["name"] = "Tungsten Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_tungsten}Tungsten",
                    "{C:stake_minty_tungsten}Stake{} difficulty",
				}
			},
			["minty_catcat_sticker"] = {
				["name"] = "<hash>CA7CA7 Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_catcat}<hash>CA7CA7",
                    "{C:stake_minty_catcat}Stake{} difficulty",
				}
			},
			["minty_rose_gold_sticker"] = {
				["name"] = "Rose Gold Sticker",
				["text"] = {
                    "Used this Joker",
                    "to win on {C:stake_minty_rose_gold}Rose Gold",
                    "{C:stake_minty_rose_gold}Stake{} difficulty",
				}
			},
			["minty_joker_unavailable"] = {
				["name"] = "Unavailable",
				["label"] = "Unavailable",
				["text"] = {
					"Requires {C:attention}#1#{}:",
					"{C:mult}#2#{}"
				}
			},
			["normal_jokers"] = {
				["label"] = "Normal",
				["name"] = "Normal",
				["text"] = {
					"Capable of",
					"spawning naturally",
				},
			},
			["minty_mirror"] = {
				["label"] = "Mirror Pronouns",
				["name"] = "Mirror Pronouns",
				["text"] = {
					"{C:attention}#1#'s{} pronouns are",
					"the same as whoever",
					"is referring to it"
				}
			},
			["minty_mirror_flavor"] = {
				["label"] = "Mirror Pronouns",
				["name"] = "Mirror Pronouns",
				["text"] = {
					"{C:attention}#1#'s{} pronouns are",
					"the same as whoever",
					"is referring to it",
					" ",
					'{C:inactive,s:0.8}"Lore drop modder uses it/its?!?!?"{}',
					'{C:inactive,s:0.6}                      "Not new information!"{}',	--Is there a better way to do this? Surely.
					'{C:inactive,s:0.8}"Oh.{}"                            ',			--Do I know it? Hell no.
				}
			},
			["minty_disabled_object"] = {
				["label"] = "Object Disabled",
				["name"] = "Object Disabled",
				["text"] = {
					"Requires {C:attention}#1#{}:",
					"{C:mult}#2#{}",
					"{C:inactive,s:0.8}(This label is supposed to be deprecated; file a bug report!)"
				}
			},
			["minty_disabled_object_requirement"] = {
				["label"] = "Object Disabled",
				["name"] = "Object Disabled",
				["text"] = {
					"Requires {C:attention}#1#{}:",
					"{C:mult}#2#{}"
				}
			},
			minty_disabled_object_config = {
				label = "Card Disabled",
				name = "Card Disabled",
				text = {
					"Disabled per {C:attention}config{}:",
					"{C:chips}#1#{}"
				}
			},
			["minty_dev_warning"] = {
				["label"] = "WARNING",
				["name"] = "WARNING",
				["text"] = {
					"Known issue with {C:attention}#1#{}: {C:mult}#2#{}",
					"If issues persist, disable the",
					"{C:mult}Dev Mode{} of {C:minty_3s}Menthol{} to",
					"prevent this object from spawning",
					" ",
					"{C:inactive,s:0.8}It's Dev Mode, you knew there'd be jank.{}",
				}
			},
			["minty_stone_cards"] = {
				["label"] = "Rock Cards",
				["name"] = "Rock Cards",
				["text"] = {
					"Cards with a {C:attention}rock{}-",
					"themed enhancement"
				},
			},
			["minty_percent"] = {
				["label"] = "xkcd 985",
				["name"] = "xkcd 985",
				["text"] = {
					"That's percentage",
					"{C:attention}points{}."
				},
			},
			["minty_faceholder"] = {
				["label"] = "Faceholder",
				["name"] = "Faceholder",
				["text"] = {
					"Placeholder art,",
					"to be updated ~soon"
				},
			},
			["minty_faceholder_ex"] = {
				["label"] = "Faceholder",
				["name"] = "Faceholder",
				["text"] = {
					"Fallback art for",
					"unrecognized suit!",
					"Please play carefully."
				},
			},
			["minty_placeholder"] = {
				["label"] = "Placeholder",
				["name"] = "Placeholder",
				["text"] = {
					"Placeholder art,",
					"to be updated ~soon"
				},
			},
			["minty_placeholder_ex"] = {
				["label"] = "Placeholder",
				["name"] = "Placeholder",
				["text"] = {
					"Fallback art for",
					"unrecognized suit!",
					"Please play carefully."
				},
			},
			["minty_spread"] = {
				["label"] = "Spread",
				["name"] = "Spread",
				["text"] = {
					"Destroy another Joker to",
					"create a {C:perishable}perishable{}",
					"copy of self"
				}
			},
			["minty_spread2"] = {
				["label"] = "Spread",
				["name"] = "Spread",
				["text"] = {
					"Destroy another Joker to",
					"create a {C:perishable}perishable{}",
					"copy of self with",
					"{C:perishable}#1#{} round#2# left"
				}
			},
			["minty_3credit"] = {
				["label"] = "Credit",
				["name"] = "Credit",
				["text"] = {
					"Art by",
					"{C:attention}Pentzal{}."
				},
			},
			["minty_peywet_exp_1"] = {
				["label"] = "What?",
				["name"] = "What?",
				["text"] = {
					"... What?",
				},
			},
			["minty_peywet_exp_2"] = {
				["label"] = "What?",
				["name"] = "What?",
				["text"] = {
					"... It's a {C:green}green{} {C:attention}food{},",
					"that's all I've got."
				},
			},
			["minty_peywet_exp_3"] = {
				["label"] = "Smack Barm Pey Wet",
				["name"] = "Smack Barm Pey Wet",
				["text"] = {
					"Multiplies listed",
					"{C:green}odds{} by {C:green}#1#{};",
					"consumed in {C:attention}#2#{} rounds"
				},
			},
			["minty_peywet_exp_3_flavor"] = {
				["label"] = "Smack Barm Pey Wet",
				["name"] = "Smack Barm Pey Wet",
				["text"] = {
					"Multiplies listed",
					"{C:green}odds{} by {C:green}#1#{};",
					"consumed in {C:attention}#2#{} rounds",
					" ",
					"{C:inactive,s:0.8}... transitively, that implies{}",
					"{C:inactive,s:0.8}gravy is as good as pey wet.{}",
				},
			},
			["minty_compressed_enhancements"] = {
				["label"] = "Compressed Enhancements",
				["name"] = "Compressed Enhancements",
				["text"] = {
					"None yet"
				}
			},
			["minty_rock_enhancements"] = {
				["label"] = "Rock Cards",
				["name"] = "Rock Cards",
				["text"] = {
					"None yet"
				}
			},
		},
	},
}