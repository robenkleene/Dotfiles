function rg --wraps='rg_custom -g "!tags"' --wraps=rg_custom --description 'alias rg=rg_custom'
  rg_custom $argv; 
end
