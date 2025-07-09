#!/bin/bash
source "$CONFIG_DIR/colors.sh"

update() {
  # current workspace space border color
  sketchybar --set space.$FOCUSED_WORKSPACE icon.highlight=true \
                         label.highlight=true \
                         background.border_color=$WHITE

  # prev workspace space border color
  sketchybar --set space.$PREV_WORKSPACE icon.highlight=false \
                         label.highlight=false \
                         background.color=$BACKGROUND_1 \
                         background.border_color=$BACKGROUND_2
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # yabai -m space --destroy $SID
    echo ''
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      #yabai -m space --focus $SID 2>/dev/null
      #echo space.sh BUTTON: $BUTTON, $'SELECTED': $SELECTED, MODIFIER: $MODIFIER, NAME: $NAME, SENDER: $SENDER, INFO: $INFO, TEST: ${NAME#*.}, ${NAME:6} >> ~/aaaa
      aerospace workspace ${NAME#*.}
    fi
  fi
}

# echo plugin_space.sh $SENDER >> ~/aaaa
case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "aerospace_workspace_change") update
  ;;
  *) update
  ;;
esac
