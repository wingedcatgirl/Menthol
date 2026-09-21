## Menthol - A Silly Little Minty-flavored Mod
### (This is the `next` branch, finally seeing use again after half a year. If you don't want to update SMODS, and/or want something stable, co look at [the main branch](https://github.com/wingedcatgirl/Menthol))

My silly little mod that adds some silly little jokers and decks and things. It's minty because it's not vanilla. (It's not vanilla because I think calling a mod a word which in this context means "not modded" is silly. ... Silly in the non-fun way. You know what I mean.)

[Mod main page on Modded Balatro Wiki](https://balatromods.miraheze.org/wiki/Menthol) (Beware of SPOILERS! If you even care about discovering things on your own, that is 😛)

Current features:
- Cats
- Cement
- Injokes
- Boosters
- Challenges
- Boss Blinds
- Several decks
- A bunch of jokers
- Cross-mod content
- A silly custom suit
- A little 3, as a treat
- An alternate stake path
- Pencil-tool doodles for art
- Far more ambition than sense

Planned features:
- Mostly just more of the things we've already added, tbqh

## Installation Instructions
1. Install [Lovely](https://github.com/ethangreen-dev/lovely-injector), if you haven't already.
2. Install [Steamodded](https://github.com/Steamodded/smods), if you haven't already. The required version for this branch is [26.829.0](https://github.com/Steamodded/smods/releases/tag/26.829.0)
3. Because this is the `next` branch, you most likely want [the latest commit](https://github.com/wingedcatgirl/Menthol/archive/refs/heads/next.zip).
4. Inside the zip file is the mod code in a folder, `Menthol`. Put that folder in your Mods folder. The file structure should look like `Mods/Menthol/Menthol.json`. In particular, there should _not_ be a second `Menthol` folder nested inside the first one. (You might prefer to remove the version number suffix from the folder name; it doesn't actually matter.)
5. Have a little 3 as a treat! :3

## To update to a newer version
1. Download the latest update.
2. Delete all files from your `Mods/Menthol` folder (or `Mods/MintysSillyMod` if you're a real OG). (There's no save data in there, so you won't lose any progress.)
3. Unzip all the new files into the now-empty folder. Check again to make sure it's not nested.

> [!IMPORTANT]  
> Always start a new run after updating any mod. Attempting to continue an in-progress run may result in crashes.

## Config Options
<!-- - Balance level: Doesn't do anything yet but take a wild guess what the plan is. Yes we're jumping on this train. Blame [AikoShen](https://github.com/Aikoyori/Balatro-Aikoyoris-Shenanigans) for doing it second. -->
- Flavor text: Default true. Enables funky MtG-style quotes at the bottom of Jokers, and also some other cards.
- Include crossover content: Default false. Includes cross-mod content which doesn't actually rely on the other mod's code to function. Not really the intended experience (it'll bias the Joker pool toward 3s a lot), but you might prefer maximum access to things.
- Rename Stone to Slate: Default true. This is really just for me; I'm persnickety, "stone" isn't a well-defined Thing, but slate is a real rock that [resembles your video game standard grey ahh chunk of generic](https://duckduckgo.com/?t=lm&q=slate+rock&ia=images&iax=images). Turn this off if you're persnickety in an incompatible way where seeing it have a different name than vanilla would bug you.
- Ticking cards: Certain cards tick. Click this button to turn that off if it annoys you. Inherits default value from your reduced motion option. Er, the opposite of it, I guess (reduced motion = no ticking cards)
- 3 lock: Whether the 3 suit and related content can appear in a run; "Unlocked" means it's available from the start, "Locked" means it requires using The Cat tarot or playing a Spectrum hand[^1], "Sealed" means it never appears unless a deck specifically enables it. Default "Locked".
- Disable bad jokes: Some items are just me being kind of salty, and they don't make much long-term game sense as a result. Click this when the joke gets old and you don't want to see it anymore. Default false.
- Dev Mode: Reveals some stuff that isn't 100%. Maybe you can fiddle with it and see how to fix whatever it was disabled for. Also forces crossover content on. Default false on release versions, true on dev commits.
   - Suppress trace messages: Default false; stops `TRACE`-level console messages even if Dev Mode is on.

## Recommended additional mods:
If you're trying out Menthol for the first time and want minimal other mods, go with [Amulet](https://github.com/frostice482/amulet) (unless you don't care about ^Mult as a concept), [Challenger Deep](https://github.com/OOkayOak/Challenger-Deep) (unless you don't care about challenges as a concept) and [Spectrum Framework](https://github.com/wingedcatgirl/SpectrumFramework) (unless you don't care about the Spectrum hand as a concept). The rest of the list is for after that.

### Technical
- [Challenger Deep](https://github.com/OOkayOak/Challenger-Deep) is required for some challenges in Menthol.
- [Spectrum Framework](https://github.com/wingedcatgirl/SpectrumFramework) enables five-suit poker hands, which are a fun little thing to play with.
- [Amulet](https://github.com/frostice482/amulet) enables scores above e308 and also ^mult, which is just fun imo.

### Cross-mod content
Menthol adds content for all of the following mods. Those with ⭐️ are also recommended for just, like, a basic default content mod set. in my imo.
- [Aikoyori's Shenanigans](https://github.com/Aikoyori/Balatro-Aikoyoris-Shenanigans)
- [CardPronouns](https://github.com/real-niacat/CardPronouns)
- [Card Sleeves](https://github.com/larswijn/CardSleeves) ⭐️
- [Cryptid](https://github.com/MathIsFun0/Cryptid)
- [Drafting](https://github.com/spire-winder/Balatro-Draft) ⭐️
- [Finity](https://github.com/frangnosquest/Finity)
- [Fusion Jokers](https://github.com/wingedcatgirl/Fusion-Jokers) ⭐️
- [Gemstones](https://github.com/0fficialHalo/Gemstones)
- [More Fluff](https://github.com/notmario/MoreFluff) ⭐️
<!-- - [Ortalab](https://github.com/Eremel/Ortalab) -->
- [Paperback](https://github.com/GitNether/paperback) ⭐️
- [TOGA's Stuff](https://github.com/TheOneGoofAli/TOGAPackBalatro)

The following mods add content for Menthol and we haven't returned the favor (yet):
- [Prism](https://github.com/blazingulag/Prism) ⭐️
- [Random's Partners](https://github.com/Random71777/Random-s-Partners) (requires [Partner](https://github.com/Icecanno/Partner-API/))

### Other content mods
Menthol doesn't add anything for these _yet_, but we might in future. Until then, we're just recommending them because we like them. Consider anything on this list ⭐️'d.
- [KCVanilla](https://github.com/kcgidw/kcvanilla) is just a couple of Jokers but I like them a lot. and it was the first mod I found that organized its files so I'm giving it a shoutout for that reason (I figured out how to organize my files by looking at its code)
- [Rift-Raft](https://github.com/vitellaryjr/RiftRaft) lets you send cards to the Void and then later you can get them back as negative from Void Packs, it's fun

### Quality of life
Technically you can do whatever you want here, but here's the mods I like for the purpose:
- [Glue for Modpacks](https://github.com/icyethics/Glue-For-Modpacks) lets you adjust the shop so having a lot of mods doesn't drown everything out.
- [Handy](https://github.com/SleepyG11/HandyBalatro) adds a whole lot of things but tbh the only one I care about is selecting multiple playing cards by dragging across them.
- [Item Remover](https://github.com/art-muncher/Item-Remover) lets you disable specific items from the Collection, if they're OP or bugged or you just don't like them. ([Banner](https://github.com/SylviBlossom/Banner) does the same thing and is newer, switch if one of them isn't doing what you want it to.)
- [re:Unlock All](https://github.com/wingedcatgirl/re-Unlock-All) lets you push the Unlock All button again if you switch mods and there's more to unlock.

## Adding cross-mod interactions
- 3 suit: If you want things to interact with the 3s mechanic, use `Card:is_3()` for proper detection. It returns the number of times the card counts as a 3, or `false` if it doesn't, because `0` is truthy in Lua...
- Face rank: If your modded suit includes Face art, give it `minty_facerank = true` to stop it from using the fallback art. Uh... I don't know how to properly implement cross-mod suit-rank combo art. I'll ask Kirbio UnStable, maybe. (Where by "ask" I mean "look in his published code".)
- Kitys, Legendary and otherwise: Give your kittycats the `kity` [attribute](https://docs.smods.dev/Game%20Objects/SMODS.Attributes/) (aliases `kitty` and `cat`) to enable them to interact with feline mechanics.
- Gym Buddy boosts: Give your enhancements a `config.extra.gymboost` of `"chips"`, `"xchips"`, `"mult"`, `"xmult"`, `"cash"`, `"hchips"`, `"hxchips"`, `"hmult"`, `"hxmult"`, `"hcash"` or `"none"` to have them grant the corresponding boost when scored with cards not of that enhancement. (If you don't, one will be chosen randomly each time. Which maybe you prefer!) 
- The Silliest, Littlest Deck: Add `pools = {["Menthol"] = true}` to have your cross-mod content appear with increased frequency when this deck is in play.
- Rocks: Add `minty_rock = true` to your enhancement definition to have it count as a rock. If this fails for priority reasons (which I don't _think_ should be possible, but you never know) there's a Lovely patch target in `lib/functions.lua`.

## Contributing
- Yes, feel free to contribute if you have a contribution!
- If you find a bug or plausibly-different-than-intended behavior, you can [file an issue](https://github.com/wingedcatgirl/Menthol/issues) (_please_ test thoroughly to confirm the exact conditions that do _and don't_ cause the problem - you may find [DebugPlus](https://github.com/WilsontheWolf/DebugPlus) to be helpful with this) 
- If you have a code contribution you can [do a pull request](https://github.com/wingedcatgirl/Menthol/pulls)
- If you have an art contribution... you can also do a pull request but if atlases make that too much a pain you can just send the art via one of the methods below:

## Contacting me (Minty wingedcatgirl)
- [Mod thread on the Balatro Discord](https://discord.com/channels/1116389027176787968/1308185262664450068) is the most obvious choice for mod-related communication.
- There's also [my Discord server](https://discord.gg/V5Kbh8Q) <small>or well, one of them, i start so many things and never follow through lol</small>
- Does GitHub have messaging? It has [Discussions](https://github.com/wingedcatgirl/Menthol/discussions), that'll have to do.
- Most reliable will be [Dreamwidth](https://wingedcatgirl.dreamwidth.org/). I'm not super _active_ there, but I can assure you it's not going away.
- I'm most active on [tumblr](https://www.tumblr.com/wingedcatgirl), though I don't trust the CEO of that site not to burn it all down without notice.

----
[^1]: Only if Spectrum Framework is active. Yes, there are other mods that add the Spectrum hand, but what's the point of having a framework if every mod has to account for every other mod. you know. If you're running those mods, add Spectrum Framework. Let _it_ account for every other mod.
