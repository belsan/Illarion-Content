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

-- UPDATE items SET itm_script='item.books' WHERE itm_id = 2622;

local lookat = require("base.lookat")
local common = require("base.common")
local id_266_bookshelf = require("item.id_266_bookshelf")
local granorsHut = require("content.granorsHut")

local M = {}

-- 2622 is the alchemy book. dont use it otherwise.

function M.UseItem(User, SourceItem)

    -- alchemy book; DO NOT CHANGE! STARTER PACK RELEVANT!
	if SourceItem.id == 2622 then
	    User:sendBook(101)
	end
	-- alchemy end
    
    if SourceItem:getData("granorsHut") ~= "" then
        granorsHut.readingBook(User)
    end

	if SourceItem:getData("bookId")~="" then
		local bookId =tonumber( SourceItem:getData("bookId"))
		if bookId == nil then
			return
		end
		if id_266_bookshelf.books[bookId] ~= nil then
			User:sendBook(bookId)
		end
	end

	-- old data!
	--[[	if (User:getSkill(bookLanguage[SourceItem.data]) >= bookMinimumLanguage) then
		User:sendBook(SourceItem.data);
	else
		common.InformNLS(User, Item,
			"Das Buch ist in einer Sprache geschrieben, von der du zu wenig Kenntnisse hast.",
			"The book is written in a language in what your knowledge is not advanced enough.");
	end]]
end

function M.LookAtItem(User,Item)
    if Item:getData("bookId")~="" then
		local bookId =tonumber( Item:getData("bookId"))
		if bookId ~= nil then
			if id_266_bookshelf.books[bookId] ~= nil then
				lookat.SetSpecialName(Item,id_266_bookshelf.books[bookId].german,id_266_bookshelf.books[bookId].english)
			end
		end
	end
	return lookat.GenerateLookAt(User, Item, 0)
end

return M
