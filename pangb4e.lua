-- TODO: HTML

local List = require 'pandoc.List'

----# Main OrderedList function #----
function OrderedList(element)
    if element.style == 'Example' then
        if FORMAT:match 'latex' then
            element = sublists(element) -- Inserts xlist tags.
            return ins_gb4e(element, 'exe') --top level so we want exe -- returns Div
        end
    end
end

-- Gets label and removes label Str
function get_label(li)
    if string.match(pandoc.utils.stringify(li), '^{#([%s%w%-:]+)}') then
        label = string.match(pandoc.utils.stringify(li), '^{#([%s%w%-:]+)}')
        li[1].content[1] = pandoc.Str('') --remove label
    else
        label = ''
    end
    return label, li
end

-- Handles sublists.
function sublists(element)
    return pandoc.walk_block(element, {
        OrderedList = function(ele)
            if ele.style ~= 'Example' then
                return ins_gb4e(ele, 'xlist')
            end
        end
    })
end

-- Inserts the relevant gb4e tags.
function ins_gb4e(element, type)
    local result = List:new(insert_ex(element))
    result:insert(1, pandoc.RawBlock('latex', '\\begin{'..type..'}'))
    result:insert(pandoc.RawBlock('latex', '\\end{'..type..'}'))
    return pandoc.Div(result)
end

-- Takes list items and inserts \ex\label{}.
-- I hate this function
-- TODO: Clean this mess up
function insert_ex(element)
    local result = {}
    for _, li in pairs(element.content) do
        local label, li = get_label(li)
        table.insert(result, pandoc.RawBlock('latex', '\n\\ex\\label{'..label..'} '))
        for _, block in pairs(li) do
            local inlines = List:new(pandoc.utils.blocks_to_inlines({block}))
            inlines = inlines:filter(function(x) return x~=pandoc.Str('¶') end)
            gll, i = inlines:find(pandoc.RawInline('tex', '\\gll '))
            if block.t ~= 'OrderedList' and gll then --Avoid double counting
                local prefix = pandoc.Null()
                if i ~= 1 then
                    prefix = pandoc.Para({table.unpack(inlines, 1, i-1)})
                    prefix = pandoc.walk_block(prefix, {
                        SoftBreak = function(ele)
                            return pandoc.RawInline('latex','\n')--Maybe should just return nothing here, dunno
                        end })
                end
                gloss = pandoc.Para({table.unpack(inlines, i, #inlines)})
                gloss = pandoc.walk_block(gloss, {
                    SoftBreak = function(ele)
                        return pandoc.RawInline('latex','\\\\\n')
                    end })
                table.insert(gloss.content, pandoc.RawInline('latex', '\n'))
                table.insert(result, prefix)
                table.insert(result, gloss)
            else
                table.insert(result, block)
            end
        end
    end
    return result -- Return list of blocks
end

----# Ref function #----
-- Replace <#labels>
function Str(element)
    if string.match(element.text, '<%#([%s%w%-:]+)>') and FORMAT:match 'latex' then
        local label, punc = string.match(element.text, '<%#([%s%w%-:]+)>(%p*)')
        if punc==nil then
            punc = ''
        end
        return pandoc.RawInline('latex', '(\\ref{'..label..'})'..punc)
    else
        return element
    end
end
