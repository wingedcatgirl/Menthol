### 3 suit
If you want things to interact with the 3s mechanic, use `Card:is_3()` for proper detection. It returns the number of times the card counts as a 3, or `false` if it doesn't, because `0` is truthy in Lua...

### Face and number ranks
If your modded suit includes Face art, give it `minty_facerank = true` to stop it from using the fallback art, and `minty_numberrank = true` for the Number rank. Uh... I don't know how to properly implement cross-mod suit-rank combo art. I'll ask Kirbio UnStable, maybe. (Where by "ask" I mean "look in his published code".)

### Kitys
Give your kittycats the `kity` [attribute](https://docs.smods.dev/Game%20Objects/SMODS.Attributes/) (aliases `kitty` and `cat`) to enable them to interact with feline mechanics.

### Gym Buddy boosts
Give your enhancements a `config.extra.gymboost` of `"chips"`, `"xchips"`, `"mult"`, `"xmult"`, `"cash"`, `"hchips"`, `"hxchips"`, `"hmult"`, `"hxmult"`, `"hcash"` or `"none"` to have them grant the corresponding boost when scored with cards not of that enhancement. (If you don't, one will be chosen randomly each time. Which maybe you prefer!) 

### The Silliest, Littlest Deck/Sleeve
Add the `Menthol` attribute to have your cross-mod content appear with increased frequency when this deck and/or sleeve is in play. (Jokers get 3x if either is active, everything else gets 2x if both are.)

### Rocks
Add `minty_rock = true` to your enhancement definition to have it count as a rock. If this fails for priority reasons (which I don't _think_ should be possible, but you never know) there's a Lovely patch target in `lib/functions.lua`.

### Lazarus machine
Add `[your edition's key] = value` to `MINTY.edition_values` to change how much the Lazarus machine gets from draining it. For comparison, vanilla editions are 1 for foil and holo, 2 for poly, and 4 for negative.