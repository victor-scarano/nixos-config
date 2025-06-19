{ pkgs, ... }: {
	programs.tmux = {
		enable = true;
		# TODO: tmuxinator? tmux sessionizer?
		# TODO: more sensible leader key?
		aggressiveResize = true;
		baseIndex = 1;
		disableConfirmationPrompt = true;
		mouse = true;
		focusEvents = true;
		escapeTime = 0;
		historyLimit = 50000;
		terminal = "screen-256color";
		extraConfig = ''
			# TODO: make empty window (no running process or no text in buffer) disappear after set time?
			bind -n M-1 run-shell "tmux new-window -t :1 || tmux select-window -t :1"
			bind -n M-2 run-shell "tmux new-window -t :2 || tmux select-window -t :2"
			bind -n M-3 run-shell "tmux new-window -t :3 || tmux select-window -t :3"
			bind -n M-4 run-shell "tmux new-window -t :4 || tmux select-window -t :4"
			bind -n M-5 run-shell "tmux new-window -t :5 || tmux select-window -t :5"
			bind -n M-6 run-shell "tmux new-window -t :6 || tmux select-window -t :6"
			bind -n M-7 run-shell "tmux new-window -t :7 || tmux select-window -t :7"
			bind -n M-8 run-shell "tmux new-window -t :8 || tmux select-window -t :8"
			bind -n M-9 run-shell "tmux new-window -t :9 || tmux select-window -t :9"
			bind -n M-0 run-shell "tmux new-window -t :10 || tmux select-window -t :10"

			# set -g status-interval
			set -g status-left ""
			set -g status-style "fg=default,bg=default"
			set -g window-status-separator ""

			set -g window-status-format "#[fg=#{@thm_fg},bg=#{@thm_surface_0}] #{window_index} "
			set -ag window-status-format "#[fg=#{@thm_fg},bg=default] #{window_name} "

			set -g window-status-current-format "#[fg=#{@thm_crust},bg=#{@thm_blue},bold] #{window_index} "
			# should i change the window name to be not bold?
			set -ag window-status-current-format "#[fg=#{@thm_fg},bg=default] #{window_name} "

			set -g status-right "#[fg=#{@thm_crust},bg=#{@thm_peach},bold] #{session_name} "
		'';
		plugins = with pkgs.tmuxPlugins; [ catppuccin ];
	};
}
