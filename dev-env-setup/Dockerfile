# dockerfile inspired by https://github.com/JanitorTechnology/dockerfiles/blob/master/ubuntu-dev/ubuntu-dev.dockerfile
# should be run in interactive mode.

FROM ubuntu:16.04

ARG email
ARG username

# Install HTTPS transport for Ubuntu package sources.
RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-transport-https ca-certificates software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# Add source for the latest Neovim packages.
RUN add-apt-repository ppa:neovim-ppa/stable

# Add source for the latest Git packages.
RUN add-apt-repository ppa:git-core/ppa

# Install basic development packages.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
  bash-completion \
  build-essential \
  curl \
  git \
  jq \
  less \
  locales \
  man \
  neovim \
  netbase \
  openssh-server \
  python-dev \
  python3-dev \
  python3-pip \
  python3-virtualenv \
  rubygems \
  silversearcher-ag \
  sudo \
  tmux \
  wget \
  xsel \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install --no-cache-dir --upgrade pip==9.0.3 \
 && pip3 install --no-cache-dir --upgrade virtualenv \
 && pip3 install --no-cache-dir --upgrade setuptools \
 && pip3 install --no-cache-dir --upgrade neovim \
 && echo "SHELL=/bin/bash\nTERM=xterm-256color" >> /etc/environment
ENV SHELL /bin/bash
ENV EDITOR vim

# Use a UTF-8 locale by default (instead of "POSIX").
RUN locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

# Add a user that can `sudo`.
RUN useradd --create-home --shell /bin/bash user \
 && echo "user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

# Don't be root.
USER user
ENV HOME /home/user
WORKDIR ${HOME}

# Configure bash prompt.
RUN echo "\n# Colored and git aware prompt." >> ${HOME}/.bashrc \
 && echo "PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 \" (%s)\") $ '" >> ${HOME}/.bashrc

# Configure bash variables.
RUN echo "\nTERM=xterm-256color\nEDITOR=vim" >> ${HOME}/.bashrc
ENV TERM="xterm-256color"

# Install the latest Node Version Manager.
RUN __NVM_VERSION__="0.33.10" \
 && wget -qO- "https://raw.githubusercontent.com/creationix/nvm/v${__NVM_VERSION__}/install.sh" | bash

# Install latest Node.js, npm and Yarn.
ENV NVM_DIR="${HOME}/.nvm"
RUN __NODE_VERSION__="9.9.0" \
 && . $NVM_DIR/nvm.sh \
 && nvm install v${__NODE_VERSION__}
ENV PATH="${PATH}:${NVM_DIR}/versions/node/v9.9.0/bin"

# Install Yarn.
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="${PATH}:${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin"

# Install Create Elm App.
RUN yarn global add create-elm-app \
 && echo "\nalias ea=\"elm-app\"" >> ${HOME}/.bashrc

# Install elm-vim dependencies.
run yarn global add elm elm-oracle elm-format

# Install vim-plug.
RUN curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Add init.vim
RUN curl -fLo ${HOME}/.config/nvim/init.vim --create-dirs \
 https://gitlab.com/Hatscat/dev-envs/raw/master/elm-projects/init.vim

# Install vim plugins and spell file.
RUN curl -fLo ${HOME}/.local/share/nvim/site/spell/en.utf-8.spl --create-dirs \
 http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl \
 && vim +'PlugInstall --sync' +qa

# Install tmuxinator.
RUN sudo gem install tmuxinator \
 && mkdir ${HOME}/.tmuxinator \
 && curl -fLo ${HOME}/.bin/tmuxinator.bash --create-dirs \
  https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash \
 && echo "\nsource ~/.bin/tmuxinator.bash" >> ${HOME}/.bashrc \
 && echo "\nalias mxs=\"mux start tmux\"" >> ${HOME}/.bashrc

# Add tmuxinator config
COPY tmux.yml ${HOME}/.tmuxinator/

# Add Tmux config
RUN curl -fLo ${HOME}/.tmux.conf https://gitlab.com/Hatscat/dev-envs/raw/master/common/.tmux.conf

# Add .gitconfig
RUN curl -fLo ${HOME}/.gitconfig https://gitlab.com/Hatscat/dev-envs/raw/master/common/.gitconfig

# Setup git config.
RUN git config --global user.name $username \
 && git config --global user.email $email

# Add ssh keys for gitlab auth.
COPY .ssh/id_rsa.pub ${HOME}/.ssh/
COPY .ssh/id_rsa ${HOME}/.ssh/
COPY .ssh/known_hosts ${HOME}/.ssh/
RUN sudo chown user:user ${HOME}/.ssh/id_rsa

# Clone repository.
RUN git clone git@gitlab.com:Hatscat/bytebeat-sequencer.git

ENV WORKSPACE ${HOME}/bytebeat-sequencer
WORKDIR ${WORKSPACE}

RUN git pull

# Install project dependencies.
RUN elm-app install -y && yarn install -y

EXPOSE 3000

CMD tmuxinator start tmux
