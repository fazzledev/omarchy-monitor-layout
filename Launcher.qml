import QtQuick
import Quickshell

Item {
  id: root
  property var shell: null
  property bool closingFromHost: false

  function open(payloadJson) {
    Quickshell.execDetached([
      "bash", "-lc",
      "exec python3 \"$HOME/.config/omarchy/plugins/io.github.cjgarcia1229.monitor-layout/monitor_layout.py\""
    ])
    Qt.callLater(requestClose)
  }

  function close() {}

  function requestClose() {
    if (shell && typeof shell.hide === "function")
      shell.hide("io.github.cjgarcia1229.monitor-layout")
  }
}
