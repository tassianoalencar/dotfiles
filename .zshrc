if [ ! -d ~/.antigen ]; then
  echo "Antigen não encontrado, criando diretório e instalando..."
  mkdir -p ~/.antigen
  curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle z
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/Code/opensource/lua-language-server/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export HELIX_RUNTIME="$HOME/Code/opensource/helix/runtime"

showroms() {
  local target="${1:-Roms}"
  local rows
  rows=$(for dir in "$target"/*; do
    if [ -d "$dir" ]; then
      count=$(find "$dir" -type f | wc -l)
      if [ "$count" -gt 0 ]; then
        name=$(basename "$dir")
        printf "%s\t%s\n" "$name" "$count"
      fi
    fi
  done | sort -k2 -nr)

  # largura mínima fixa
  local col1_width=20
  local col2_width=4

  local line
  line="+$(printf '%0.s-' $(seq 1 $col1_width))+$(printf '%0.s-' $(seq 1 $col2_width))+"

  # cores
  local BLUE="\033[1;34m"
  local GREEN="\033[1;32m"
  local RESET="\033[0m"

  echo "$line"
  printf "| ${BLUE}%-*s${RESET} | ${BLUE}%-*s${RESET} |\n" $col1_width "PASTA" $col2_width "ROMS"
  echo "$line"

  while IFS=$'\t' read -r name count; do
    printf "| %-*s | ${GREEN}%-*s${RESET} |\n" $col1_width "$name" $col2_width "$count"
  done <<< "$rows"

  echo "$line"
}

vdownload() {
    if [ "$#" -ne 2 ]; then
        echo "Uso: vdownload <nome-do-arquivo> <link-do-video>"
        return 1
    fi

    nome_arquivo="$1"
    link_video="$2"

    yt-dlp \
        -o "$nome_arquivo" \
        --add-headers "Referer:https://player.hotmart.com/" \
        "$link_video"
}
