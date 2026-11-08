SMODS.Seal {
	object_type = "Seal",
	name = "cement_seal",
	key = "cement",
	badge_colour = HEX("545454"), --a cement-y grey, hopefully
  config = {extra = {chips = 50}},
  --discovered = true,
  always_scores = true,
  attributes = {
    "chips", "debuff_protection"
  },
  loc_vars = function(self, info_queue)
    return { vars = {self.config.extra.chips, } }
  end,
	atlas = "cementseal",
    pos = {x = 0, y = 0},
	calculate = function(self, card, context)
    if (context.cardarea == G.play and context.main_scoring) or context.forcetrigger then
      return {
        chips = self.config.extra.chips,
        card = card
      }
    end
	end
}