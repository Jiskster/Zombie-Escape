assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.inIntermission = false
juggy.inVote         = false
juggy.inGame         = false

addHook("ThinkFrame", function()
    if leveltime == 1 and juggy.inGame == false then
        juggy.inIntermission = false
        juggy.inVote         = false
        juggy.inGame         = true
    end
end)

addHook("IntermissionThinker", function()
    if juggy.inIntermission == false then
        juggy.inIntermission = true
        juggy.inVote         = false
        juggy.inGame         = false
    end
end)

if MODID == juggy.SRB2Kart then
    addHook("VoteThinker", function()
        if juggy.inVote == false then
            juggy.inIntermission = false
            juggy.inVote         = true
            juggy.inGame         = false
        end
    end)
end