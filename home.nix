{ config, pkgs, ... }: 
{
  home.username = "stefan";
  home.homeDirectory = "/home/stefan";
  programs.home-manager.enable = true;
  home.packages = with pkgs; 
  [
    # your desired nixpkgs here
    # cowsay
    pkgs.nvchad
    nixd
  ];
  programs.git = 
  {
    enable = true;
    settings.user = {
      name = "StefanRolink";
      email = "stefanrolink@protonmail.com";
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestions.enable = true;
    #syntaxHighlighting.enable = true;
    shellAliases = {
      l = "eza -l --icons";
    };
  };
  programs.tmux = 
  {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;
    escapeTime = 0;
    extraConfig = ''
	set-option -g focus-events on
	 
	# Split panes using | and -
	bind | split-window -h -c "#{pane_current_path}"
	bind - split-window -v -c "#{pane_current_path}"
	unbind '"'
	unbind %
	 
	# Split keys using g and C-g
	unbind g
	unbind C-g
	bind-key g split-window -h
	bind-key C-g split-window -h
	 
	# Split keys using h and C-h
	unbind h
	unbind C-h
	bind-key h split-window -v
	bind-key C-h split-window -v
	 
	# New session:
	# unbind n
	# unbind C-n
	# bind-key n new-session
	# bind-key C-n new-session
	 
	unbind Pagedown
	bind-key Pagedown next-window
	 
	unbind Pageup
	bind-key Pageup previous-window
	 
	# Start numbering at 1
	set -g base-index 1
	set -g pane-base-index 1
	 
	# reload config file (change file location to your the tmux.conf you want to use)
	bind r source-file ~/.config/tmux/tmux.conf \; display 'Reloaded tmux config.'
	 
	# switch panes using Alt-arrow without prefix
	bind -n M-Left  select-pane -L
	bind -n M-Right select-pane -R
	bind -n M-Up    select-pane -U
	bind -n M-Down  select-pane -D
	 
	bind-key h select-pane -L
	bind-key j select-pane -D
	bind-key k select-pane -U
	bind-key l select-pane -R
	 
	# Enable mouse mode (tmux 2.1 and above)
	set -g mouse on
	 
	bind P paste-buffer
	bind-key -T copy-mode-vi v send-keys -X begin-selection
	bind-key -T copy-mode-vi y send-keys -X copy-selection
	bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
	 
	# Highlight active window
	set-window-option -g window-status-current-style bg=brightred
	 
	setw -g monitor-activity on
	set -g visual-activity on
	 
	set -g set-titles on
	 
	# Copy from tmux to system clipboard
	#bind -t vi-copy y copy-pipe "xclip -sel clip -i"
	 
	set -g display-time 4000
    '';
  };
}

