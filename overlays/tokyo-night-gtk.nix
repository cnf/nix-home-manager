final: prev: {
  tokyo-night-gtk-cnf =
    (prev.tokyo-night-gtk.overrideAttrs (
      old: new: {
        gtkrc = prev.writeText "gtkrc" ''
          make_gtkrc() {
          	local dest="''${1}"
          	local name="''${2}"
          	local theme="''${3}"
          	local color="''${4}"
          	local size="''${5}"
          	local ctype="''${6}"
          	local window="''${7}"

          	#SRC_DIR=src

          	[[ "''${color}" == '-Light' ]] && local ELSE_LIGHT="''${color}"
          	[[ "''${color}" == '-Dark' ]] && local ELSE_DARK="''${color}"

          	local GTKRC_DIR="''${SRC_DIR}/main/gtk-2.0"
          	local THEME_DIR="''${1}/''${2}''${3}''${4}''${5}''${6}"

          	theme_color='#ff6700'

          	background_light='#FFFFFF'
          	background_dark='#2C2C2C'
          	background_darker='#3C3C3C'
          	background_alt='#464646'
          	titlebar_light='#F2F2F2'
          	titlebar_dark='#242424'


          	mkdir -p "''${THEME_DIR}/gtk-2.0"

          	cp -r "''${GTKRC_DIR}/gtkrc''${ELSE_DARK:-}-default" "''${THEME_DIR}/gtk-2.0/gtkrc"
          	sed -i "s/#FFFFFF/''${background_light}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          	sed -i "s/#2C2C2C/''${background_dark}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          	sed -i "s/#464646/''${background_alt}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
						sed -i "s/#FF9E64/''${theme_color}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
						sed -i "s/#ff9e64/''${theme_color}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"

          	if [[ "''${color}" == '-Dark' ]]; then
          		sed -i "s/#5b9bf8/''${theme_color}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          		sed -i "s/#3C3C3C/''${background_darker}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          		sed -i "s/#242424/''${titlebar_dark}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          	else
          		sed -i "s/#3c84f7/''${theme_color}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          		sed -i "s/#F2F2F2/''${titlebar_light}/g" "''${THEME_DIR}/gtk-2.0/gtkrc"
          	fi
          }
        '';
        postPatch = ''
          				# echo "patching themes/gtkrc.sh"
          				# cp $gtkrc themes/gtkrc.sh
          				# cat themes/gtkrc.sh
          				patchShebangs themes/install.sh
									${prev.gnused}/bin/sed -i "s/#ff9e64/#ff6700/gi" themes/*
        '';
      }
    )).override
      {
        themeVariants = [
          "orange"
          "default"
        ];
      };

}
