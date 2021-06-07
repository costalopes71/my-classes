#! /usr/bin/env bash

# resume.sh - Display my custom resumes about commands.
#
# Site: https://www.github.com/costalopes71
# Author: costalopes71
# Maintainer: costalopes71
#
# -----------------------------------------------------#
#
# This program is intended to facilitate the resumes of my most used commands.
# Usage example:
#   $ resume vi
#   $ resume top
#   $ resume tmux
#
# In the above examples, a resume of vi commands will be printed and a resume of top commands will be printed.
#
# -----------------------------------------------------#
# Changelog
#
#  v0.1 03/06/2021 - costalopes
#     - Add documentation
#     - Add vi, top and tmux commands
#
# -----------------------------------------------------#
# Tested with:
#   
#   - bash 5.0.17
# -----------------------------------------------------#

########################################################
# VARIABLES
########################################################

RED="\033[031;1m"
BLUE="\033[34;1m"
GREEN="\033[32;1m"
YELLOW="\033[33;1m"

HELP="Usage: resume [command] [index] 

This program is intended to facilitate the resumes of my most used commands.

Supported commands: vi, top, tmux

Usage example:
  $ resume vi
  $ resume vi 0
  $ resume top
  $ resume tmux
  $ resume tmux 3
"

CMD_VI_0="0. Index
1. Navegation
2. Insert text
3. Alter text
4. Cut text
5. Copy/Paste
6. Magic
"

CMD_VI_1="1. Navegacao:
j --> move o cursor uma linha para baixo
k --> move o cursor uma linha para cima
h --> move o cursor um caracter para tras
l --> move o cursor um caracter para frente
$ --> move o cursor para o final da linha
0 --> move o cursor para o comeco da linha
nG ou :n --> move o cursor para a linha n
G ou :$ --> move o cursor para a ultima linha do arquivo
g ou :0 --> move o cursor para a primeira linha do arquivo
w ou W --> move o cursor para a proxima palavra
b ou B --> move o cursor para a palavra anterior
e ou E --> move o cursor para o fim da palavra
M --> move o cursor para a linha do meio da tela
L --> move o cursor para a ultima linha da tela
H --> move o cursor para a primeira linha da tela"

CMD_VI_2="2. Insercao/Digitacao:
i --> insere texto antes do cursor
I --> insere texto no comeco da linha 
a --> insere texto depois do cursor
A --> insere texto no final da linha
o --> insere uma nova linha abaixo e adiciona texto
O --> insere uma nova linha acima e adiciona texto"

CMD_VI_3="3. Alteracao:
r --> altera um unico caracter onde esta o cursor
R --> altera caracteres comecando de onde esta o cursor ate terminar teclando esc
cw --> faz o replace da palavra onde o cursor esta por um novo texto
cNw --> faz o replace das palavras onde o cursor esta, sendo n o numero de palavras a fazer o replace
C --> faz o replace da linha toda pelo texto que irei escrever
cc --> nao entendi a diferenca do de cima
ncc --> faz o replace de N linhas comecando pela linha atual"

CMD_VI_4="4. Recortar:
x   --> recorta/deleta um caracter 
Nx  --> recorta/deleta N caracteres
dw  --> recorta/deleta a palavra toda
dNw --> recorta/deleta N palavras
D   --> recorta/deleta o restante da linha a comecar do cursor
dd  --> recorta/deleta a linha toda
Ndd --> recorta/deleta N linhas"

CMD_VI_5="5. Copiar/Colar:
yy --> copia a linha
Nyy --> copia N linhas
p --> cola"

CMD_VI_6="6. Bruxaria:
~ + barra_espaco --> altera o case de um caracter
~ + enter --> altera o case da linha toda
J --> junta as linhas (a do cursor com a debaixo)
>> --> shifta a linha para a direita
<< --> shifta a linha para a esquerda
"

CMD_VI_ALL="$CMD_VI_0\n\n$CMD_VI_1\n\n$CMD_VI_2\n\n$CMD_VI_3\n\n$CMD_VI_4\n\n$CMD_VI_5\n\n$CMD_VI_6"

CMD_TOP_ALL="m --> exibe o valor de memoria usada usando uma barra (apertar mais 1x exibe a barra com preenchimento e mais uma vez tira a linha de memoria)
t --> exibe o valor de cpu em uso usando uma barra (apertar mais 1x exibe a barra com preenchimento e mais uma vez tira a linha da cpu)
P --> ordena por CPU
M --> ordena por memoria
T --> ordena por Tempo
N --> ordena por PID
c --> mostra o comando todo executado
n --> quantidade de linhas a serem exibidas
k --> matar um PID
u --> permite escolher os processos de um determinado usuario
1 --> mostra os valores de cada CPU
"

CMD_TMUX_0="0. Index
1. Sessions
2. Windows
3. Panels
4. Copy Mode
5. Misc
6. Help
7. Custom"

CMD_TMUX_1="1. Sessions:

start new --> tmux [or] tmux new [or] tmux new-session [or] :new
start named --> tmux new -s mysession [or] :new -s mysession
kill named --> tmux kill-ses -t mysession [or] tmux kill-session -t mysession
kill all but current --> tmux kill-session -a
kill all but named --> tmux kill-session -a -t mysession
rename --> ctrl+b $
dettach --> ctrl+b d
attach --> :attach -d
show all --> tmux ls [or] tmux list-sessions [or] ctrl+b s
attach to last --> tmux a [or] tmux at [or] tmux attach
attach to named --> tmux a -t mysession [or] tmux at -t mysession [or] tmux attach -t mysession
move to previous --> ctrl+b (
move to next --> )"

CMD_TMUX_2="2. Windows

create --> ctrl+b c
rename current --> ctrl+b ,
close current --> ctrl+b &
previous --> ctrl+b p
next --> ctrl+b n
select by number --> ctrl+b 0..9
reorder window swaping (src/dest)  --> :snap-window -s 2 -t 1
move current to left by n position --> :snap-window -t -1
move between --> alt left/right"

CMD_TMUX_3="3. Panes

last active --> ctrl+b ;
split vertically --> ctrl+b %
split horizontally --> ctrl+b doublequotes
move left --> ctrl+b {
move right --> ctrl+b }
switch to pane --> ctrl+b up/down/left/right
synchronize all --> :setw synchronize-panes
toogle between layouts --: ctrl+b Spacebar
next --> ctrl+b o
zoom --> ctrl+b z
convert to window --> ctrl+b !
resize --> hold ctrl+b up/down/left/right
close --> ctrl+b x"

CMD_TMUX_4="4. Copy Mode

enter copy mode --> ctrl+b [
quit mode --> q
search forward --> /
search backward --> ?
next occurance --> n
previos occurance --> N
start selection --> spacebar
clear selection --> esc
copy selection --> enter
paste contents of buffer_0 --> ctrl+b ]
diplay buffer content --> :show-buffer
copy entire visible contents of pane to a buffer --> :capture-pane
list buffers --> :list-buffers
save buffer to file --> :save-buffer buf.txt"

CMD_TMUX_5="5. Misc

enter command mode --> ctrl+b :
set OPTION for all sessions --> :set -g OPTION
set OPTION for all windows  --> :setw -g OPTION"

CMD_TMUX_6="6. Help

show every session, window, pane, etc --> tmux info
show shortcuts --> ctrl+b ?"

CMD_TMUX_7="7. Custom:

prefix tmux key instead of ctrl+b --> ctrl+g
kill all sessions --> ctrl+b q"

CMD_TMUX_ALL="$CMD_TMUX_0\n\n$CMD_TMUX_1\n\n$CMD_TMUX_2\n\n$CMD_TMUX_3\n\n$CMD_TMUX_4\n\n$CMD_TMUX_5\n\n$CMD_TMUX_6\n\n$CMD_TMUX_7"

########################################################
# FUNCTIONS
########################################################

printViCommands() {
	case "$1" in
		0) echo "$CMD_VI_0" && exit 0         ;;
		1) echo "$CMD_VI_1" && exit 0         ;;
		2) echo "$CMD_VI_2" && exit 0         ;;
		3) echo "$CMD_VI_3" && exit 0         ;;
		4) echo "$CMD_VI_4" && exit 0         ;;
		5) echo "$CMD_VI_5" && exit 0         ;;
		6) echo "$CMD_VI_6" && exit 0         ;;
		*) echo -e "$CMD_VI_ALL" && exit 0    ;;
	esac
}

printTopCommands() {
	echo "$CMD_TOP_ALL"
}

printTmuxCommands()	{
	case "$1" in
		0) echo "$CMD_TMUX_0" && exit 0      ;;
		1) echo "$CMD_TMUX_1" && exit 0      ;;
		2) echo "$CMD_TMUX_2" && exit 0      ;;
		3) echo "$CMD_TMUX_3" && exit 0      ;;
		4) echo "$CMD_TMUX_4" && exit 0      ;;
		5) echo "$CMD_TMUX_5" && exit 0      ;;
		6) echo "$CMD_TMUX_6" && exit 0      ;;
		7) echo "$CMD_TMUX_7" && exit 0      ;;
		*) echo -e "$CMD_TMUX_ALL" && exit 0 ;;
	esac

}

########################################################
# EXECUTION
########################################################

case "$1" in
	vi) printViCommands $2 && exit 0       ;;
	top) printTopCommands && exit 0        ;;
	tmux) printTmuxCommands $2 && exit 0   ;;
	*) echo "$HELP" && exit 0              ;;
esac

