{ lib, jq, pkgs, writeShellScriptBin }:

{ launcher ? "rofi"
, cmdcolor ? "#ff6700"
, modkeyStyle ? "<b>$MOD$KEY</b> <i>$DESCRIPTION</i>"
, dispatch ? true
}:

let
  #launcher = "rofi";
  #modkeyStyle = "<b>$MOD$KEY</b> <i>$DESCRIPTION</i>";
  #dispatch = true;

  modmasks = {
    "0" = "";
    "1" = "⇧ +";
    "4" = "⌃ +";
    "5" = "⇧ + ⌃ +";
    "8" = "⎇ +";
    "12" = "^ + ⎇ +";
    "64" = "❖ +";
    "65" = "❖ + ⇧ +";
    "68" = "❖ + ⌃ +";
  };
  keycodes = {
    "59" = "Comma";
    "60" = "Dot";
  };

  launcherCommand =
    if launcher == "rofi"
    then "${lib.getExe pkgs.rofi} -dmenu -markup-rows -i -p 'Hypr binds'"
    else "${lib.getExe pkgs.wofi} --dmenu -m -i -p 'Hypr binds'";

  style =
    let
      modkey = builtins.replaceStrings
        [ "$MOD" "$KEY" "$DESCRIPTION" ]
        [ "\\(.mod)" "\\(if .key == \"\" then .code else .key end)" "\\(.desc)" ]
        modkeyStyle;
    in
    ''${modkey} <span color=\"${cmdcolor}\">\(.dp) \(.arg)</span>'';
in
writeShellScriptBin "hypr-binds" ''
  hyprctl binds -j |
    ${lib.getExe jq} -r '
      map({mod:.modmask|tostring,key:.key,code:.keycode|tostring,desc:.description,dp:.dispatcher,arg:.arg,sub:.submap}) |
      map(.mod |= ${builtins.toJSON modmasks} [.]) |
      map(.code |= ${builtins.toJSON keycodes} [.]) |
      sort_by(.mod) | .[] |
      select(.sub == "") |
      "${style}" ' | ${launcherCommand} |
    # extract the command (dispatcher + arg)
    sed -n 's/.*<span color=\"${cmdcolor}\">\(.*\)<\/span>.*/\1/p' |
    ${if dispatch then ''
      # add double quotes to the string so it can be piped to hyprctl dispatch
      sed -e 's/^/"/g' -e 's/$/"/g' |
      xargs -n1 hyprctl dispatch
      '' else "xargs"
    }
''

