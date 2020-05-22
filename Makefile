PROG=lights
TARGET="$(shell pwd)/${PROG}"
LINK="/usr/local/bin/${PROG}"

install:
	@ln -sf ${TARGET} ${LINK}
install/completion:
	@sh .scripts/generate-zsh-completion.sh
	@sh .scripts/install-zsh-completion.sh
