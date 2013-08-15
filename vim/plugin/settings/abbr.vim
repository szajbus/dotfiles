" Abbreviations, trigger by typing the abbreviation and pressing space

func Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

iabbr ri! raise .inspect<esc>Bi<C-R>=Eatchar('\s')<cr>
iabbr ry! raise .to_yaml<esc>Bi<C-R>=Eatchar('\s')<cr>
iabbr rld Rails.logger.debug
iabbr rli Rails.logger.info
iabbr cl! console.log()<esc>ha<C-R>=Eatchar('\s')<cr>
iabbr <%= <%= %><esc>3ha
iabbr 18 I18n.t('')<esc>2ha<C-R>=Eatchar('\s')<cr>
