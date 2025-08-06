local current_match_words = vim.b.match_words or ''
local new_pair = 'do:end'

if current_match_words == '' then
  vim.b.match_words = new_pair
else
  vim.b.match_words = current_match_words .. ',' .. new_pair
end
