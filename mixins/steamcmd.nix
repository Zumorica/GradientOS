/*
*  Taken and modified from https://kevincox.ca/2022/12/09/valheim-server-nixos-v2/
*/
{ config, pkgs, ... }:
{
	users.users.steamcmd = {
		isSystemUser = true;
		group = config.users.groups.steamcmd.name;
		home = "/var/lib/steamcmd";
    homeMode = "775";
		createHome = true;
	};

	users.groups.steamcmd = {};

	systemd.services."steamcmd@" = {
		unitConfig = {
			StopWhenUnneeded = true;
		};
		serviceConfig = {
			Type = "oneshot";
			ExecStart = "${pkgs.resholve.writeScript "steam" {
				interpreter = "${pkgs.zsh}/bin/zsh";
				inputs = with pkgs; [
					patchelf
					steamcmd
				];
				execer = [
					"cannot:${pkgs.steamcmd}/bin/steamcmd"
				];
			} ''
				set -eux

				instance=''${1:?Instance Missing}
				eval 'args=(''${(@s:_:)instance})'
				app=''${args[1]:?App ID missing}
				beta=''${args[2]:-}
				betapass=''${args[3]:-}

				dir=/var/lib/steamcmd/apps/$instance

				cmds=(
					+force_install_dir $dir
					+login anonymous
					+app_update $app validate
				)

				if [[ $beta ]]; then
					cmds+=(-beta $beta)
					if [[ $betapass ]]; then
						cmds+=(-betapassword $betapass)
					fi
				fi

				cmds+=(+quit)

				steamcmd $cmds

				for f in $dir/*; do
					if ! [[ -f $f && -x $f ]]; then
						continue
					fi

					# Update the interpreter to the path on NixOS.
					patchelf --set-interpreter ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 $f || true
				done
			''} %i";
			PrivateTmp = true;
			Restart = "on-failure";
			StateDirectory = "steamcmd/apps/%i";
			TimeoutStartSec = 3600; # Allow time for updates.
			User = config.users.users.steamcmd.name;
			WorkingDirectory = "~";
		};
	};
}