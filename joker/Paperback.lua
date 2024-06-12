--- STEAMODDED HEADER

--- MOD_NAME: Paperback
--- MOD_ID: Paperback
--- MOD_AUTHOR: [PaperMoon]
--- MOD_DESCRIPTION: Jokers and new consumables
--- PRIORITY: 0
--- BADGE_COLOR: 8b61ad
--- PREFIX: ppr
--- VERSION: 1.0.0
--- LOADER_VERSION_GEQ: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {  
    key = 'PaperBack1',
    px = 71,
    py = 95,
    path = 'PaperBack1.png'
}

SMODS.Joker {
    key = 'callingcard',
    loc_txt = {
        name = "Calling Card",                                --name used by the joker
        text = {
            "Whenever you defeat a {C:attention}Boss Blind{} or activate its {C:attention}effect{},",             --description text.	
            "this Joker gains {X:red,C:white}#1#X{}",
            "{C:inactive}(currently gives {}{X:red,C:white}#2#X{}{C:inactive} Mult){}"                       --more than 5 lines look odd
        }
    },
    config = { extra = { Xmult_mod = 0.25, x_mult = 1 } }, --variables used for abilities and effects.
    rarity = 2,                                         --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    pos = { x = 0, y = 0 },                             --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    atlas = 'PaperBack1',                                        --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    cost = 6,                                           --cost to buy the joker in shops
    unlocked = true,                                    --joker is unlocked by default
    discovered = true,                                  --joker is discovered by default
    blueprint_compat = true,                            --does joker work with blueprint
    eternal_compat = true,                              --can joker be eternal
    soul_pos = nil,                            --pos of a soul sprite.

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.x_mult = card.ability.extra.x_mult or 1
        card.ability.extra.Xmult_mod = 0.25
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.Xmult_mod, center.ability.extra.x_mult} }
    end,
    
    calculate = function(self, card, context)                 --define calculate functions here
        if context.joker_main and G.GAME.blind.triggered and not context.blueprint and not context.individual and not context.repetition then 
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.Xmult_mod
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss and not self.gone then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.Xmult_mod
        end
        if context.cardarea == G.jokers and (card.ability.extra.x_mult > 1) and not context.before and not context.after then
            return {
                Xmult_mod = card.ability.extra.x_mult,
                card = self,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end,
}