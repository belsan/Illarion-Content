--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>. 
]]
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (703, 'quest.jakob_lindorn_703_cadomyr');

local common = require("base.common")
local factions = require("base.factions")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Willkommen in Cadomyr"
Title[ENGLISH] = "Welcome to Cadomyr"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Such Berri Firegold in der Werkstatt von Cadomyr und frag ihn nach einer Aufgabe. Solltest du weitere Aufgaben von Jakob erledigen wollen, kehr sp�ter zu ihm zur�ck. Die Werkstatt kannst du ganz leicht finden. Geh durch das Haupttor im Norden, dann bieg nach rechts ab, geh durch das Tor, nun erneut nach Norden, dann �ffnest du das Tor zu deiner linken und gehst nach Norden. Die Werkstatt befindet sich beim kleinen Garten mit den Werkzeugen darin. Du brauchst seine Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][1] = "Search for the dwarf, Berri Firegold, at the workshop in Cadomyr. Then return back to Jakob if you want more tasks from him. You can find the workshop really easily. Go through the main gate north from here, then turn right and follow the street, go through the gate, turn left and go through the next gate. From here you go north until you reach a building to your right with a little garden and some tools outside. You don't have to finish his tasks before you come back to me for another job."
Description[GERMAN][2] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][2] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][3] = "Such Grakamesh den Ork bei Sir Reginalds Gruft und frag ihn nach einer Aufgabe. Die Gruft ist gleich hinter Jakob bei dem kleinen Eingang. Du brauchst seine Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][3] = "Search for the orc, Grakamesh at Sir Reginald's Tomb and ask him for a task. The tomb is right behind Jakob at the little entrance. You don't have to finish his tasks before you come back to me for another job."
Description[GERMAN][4] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][4] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][5] = "Such die Zwergendame Mirarie Bragolin und frag sie, ob du ihr helfen kannst. Mirarie Bragolin ist beim Tor kurz vor dem Marktplatz. Du brauchst ihre Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][5] = "Search for the dwarfess, Mirarie Bragolin, and ask her if she needs your help. Mirarie Bragolin is at the inner gate, shortly before the marketplace. You don't have to finish her tasks before you come back to me for another job."
Description[GERMAN][6] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][6] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][7] = "Finde Hassan, den k�niglichen F�chelwedler und frag ihn, ob er eine Aufgabe f�r dich hat. Hassan h�lt sich oft in der Taverne von Cadomyr n�rdlich des Marktplatzes auf. Du brauchst seine Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][7] = "Find Hassan, the royal fan-waver, and ask him if he has a task for you. Hassan can be often found in the tavern, north of the marketplace in Cadomyr. You don't have to finish his tasks before you come back to me for another job."
Description[GERMAN][8] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][8] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][9] = "Die K�chin Linda Rabon hat eine Aufgabe f�r dich. Such sie bei der Taverne in Cadomyr. Du brauchst ihre Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][9] = "The cook, Linda Rabon, has a task for you, search for her in the tavern in Cadomyr. You don't have to finish her tasks before you come back to me for another job."
Description[GERMAN][10] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][10] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][11] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][11] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][12] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][12] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][13] = "Reret Odohir, die Notarin Cadomyrs hat eine Aufgabe f�r dich. Such sie. Du kannst sie in dem Haus nordwestlich von der Taverne finden. Es ist das Haus mit der bunten S�ule davor. Du brauchst ihre Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][13] = "Reret Odohir, the notary of Cadomyr, has a task for you if you search for her. You can find her in the building northwest of the tavern, it's the house with the colourful pillar. You don't have to finish her tasks before you come back to me for another job."
Description[GERMAN][14] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][14] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][15] = "Such Evera in das Tor und hilf ihr, wenn sie eine Aufgabe f�r dich hat. Du brauchst ihre Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][15] = "Search for Evera inside the gate and help her if she has a task for you. You don't have to finish her tasks before you come back to me for another job."
Description[GERMAN][16] = "Geh zu Jakob Lindorn beim Teleporter in Cadomyr, er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][16] = "Go to Jakob Lindorn at the teleporter of Cadomyr, he is sure to have another task for you."
Description[GERMAN][17] = "Finde Jeremiah Horanfeld, den Sch�dlingsw�chter und frag ihn, ob er eine Aufgabe f�r dich hat. Jeremiah h�lt sich oft in Cadomyr Marktplatzes auf. Du brauchst seine Aufgabe nicht zu erf�llen, wenn sie dir nicht behagt. Komm dann einfach hierher zur�ck, um eine weitere Aufgabe zu bekommen."
Description[ENGLISH][17] = "Find Jeremiah Horanfeld, the vermin monitor and ask him if he has a task for you. Jeremiah can be often found in the marketplace in Cadomyr. You don't have to finish his tasks before you come back to me for another job."
Description[GERMAN][18] = "Du hast alle Aufgaben von Jakob Lindorn erf�llt."
Description[ENGLISH][18] = "You have fulfilled all the tasks for Jakob Lindorn."

-- Insert the position of the quest start here (probably the position of an NPC or item)
Start = {124, 649, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(124, 649, 0), position(141, 582, 0)} -- Berri Firegold
QuestTarget[2] = {position(124, 649, 0)}
QuestTarget[3] = {position(124, 649, 0), position(133, 638, 0)} -- Grakamesh
QuestTarget[4] = {position(124, 649, 0)}
QuestTarget[5] = {position(124, 649, 0), position(128, 621, 0)} -- Mirarie Bragolin
QuestTarget[6] = {position(124, 649, 0)}
QuestTarget[7] = {position(124, 649, 0), position(110, 574, 0)} -- Hassan
QuestTarget[8] = {position(124, 649, 0)}
QuestTarget[9] = {position(124, 649, 0), position(116, 576, 0)} -- Linda Rabon
QuestTarget[10] = {position(124, 649, 0)}
QuestTarget[11] = {position(124, 649, 0)}  -- Zerarisa removed from npc b/c moved to new realm.
QuestTarget[12] = {position(124, 649, 0)}
QuestTarget[13] = {position(124, 649, 0), position(106, 553, 0)} -- Reret Odohir
QuestTarget[14] = {position(124, 649, 0)}
QuestTarget[15] = {position(124, 649, 0), position(139, 622, 0)} -- Evera
QuestTarget[16] = {position(124, 649, 0)}
QuestTarget[17] = {position(124, 649, 0), position(104, 600, 0)} -- Jeremiah Horanfeld
QuestTarget[18] = {position(124, 649, 0)}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 18


function M.QuestTitle(user)
    return common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function M.QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return common.GetNLS(user, german, english)
end

function M.QuestStart()
    return Start
end

function M.QuestTargets(user, status)
    return QuestTarget[status]
end

function M.QuestFinalStatus()
    return FINAL_QUEST_STATUS
end

function M.QuestAvailability(user, status)
    if factions.isCadomyrCitizen(user) and status == 0 then
        return Player.questAvailable
    else
        return Player.questNotAvailable
    end
end

return M
