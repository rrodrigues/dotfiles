# [MIT](https://github.com/arzzen/calc.plugin.zsh/blob/master/LICENSE)
# bc - An arbitrary precision calculator language
function =
{
  echo "$@" | bc -l
}
 alias calc="="