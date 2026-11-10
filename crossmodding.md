### 3 suit
If you want things to interact with the 3s mechanic, use `Card:is_3()` for proper detection. It returns the number of times the card counts as a 3, or `false` if it doesn't, because `0` is truthy in Lua...  
Objects which care about 3s should get the `minty_3s` attribute.

### Face and number ranks
If your modded suit includes Face art, give it `minty_facerank = true` to stop it from using the fallback art, and `minty_numberrank = true` for the Number rank. Uh... I don't know how to properly implement cross-mod suit-rank combo art. I'll ask Kirbio UnStable, maybe. (Where by "ask" I mean "look in his published code".)  
Objects which care about these ranks should get the `minty_facerank` and `minty_numberrank` attributes, respectively.

### Gym Buddy boosts
Give your enhancements a `config.extra.gymboost` of `"chips"`, `"xchips"`, `"mult"`, `"xmult"`, `"cash"`, `"hchips"`, `"hxchips"`, `"hmult"`, `"hxmult"`, `"hcash"` or `"none"` to have them grant the corresponding boost when scored with cards not of that enhancement. (If you don't, one will be chosen randomly each time. Which maybe you prefer!) 

### Lazarus machine
Add `[your edition's key] = value` to `MINTY.edition_values` to change how much the Lazarus machine gets from draining it. For comparison, vanilla editions are 1 for foil and holo, 2 for poly, and 4 for negative.
> [!NOTE]
> If your mod loads before Menthol, the table won't exist yet. You'll need to find a way to delay this code until the table does exist.

### Tungsten stake
Add `[your custom set] = "Booster Type"` to `MINTY.set_to_booster` to encase your custom cards in appropriate booster packs on Tungsten stake and higher. Alternately, set the value to `false` to exempt your custom type from this mechanic. Sets that don't appear in this table will be encased in a Pack of Every Card.
> [!NOTE]
> Guess what you need to account for if your mod loads before Menthol.

### [Attributes](https://docs.smods.dev/Game%20Objects/SMODS.Attributes/) with mechanical baggage
See [attributes.lua](lib/attributes.lua) for complete details, but here are some worth noting.
> [!NOTE]
> Various pre-attribute methods of interacting with these mechanics are now deprecated and will be removed in Menthol 1.2, please update to attributes at your earliest convenience!

#### Kitys
Give your kittycats the `kity` attribute (aliases `kitty` and `cat`) to enable them to interact with feline mechanics.
#### The Silliest, Littlest Deck/Sleeve
Add the `Menthol` attribute (aliases `MintysSillyMod` and `minty`) to have your cross-mod content appear with increased frequency when this deck and/or sleeve is in play. Jokers get 3x if either is active, everything else gets 2x if both are.
#### Rocks
Give an enhancement the `minty_rock_card` attribute to flag it as a Rock Card, and check for this attribute if you want to care about rock cards. (Objects which care about rocks should get the `minty_rocks` attribute; `minty_rock_card` is for objects which ARE rocks.)