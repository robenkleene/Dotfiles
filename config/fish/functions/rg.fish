function rg --wraps=rg_custom --wraps='rg_custom -g "!tags"' --description 'alias rg=rg_custom'
  rg_custom $argv; 
end
