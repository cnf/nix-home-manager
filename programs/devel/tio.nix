{ unstable, ... }: {
  home.packages = [unstable.tio-new];
  xdg.configFile."tio/config" = {
    text = ''
      [default]
      baudrate = 115200
      databits = 8
      parity = none
      stopbits = 1
      map = INLCRNL,ODELBS
      color = 45
      log-directory = ~/.cache/tio/

      [include local]

      [FSGW]
      device = /dev/tty-M5-5713049119
      local-echo = true
      map = INLCRNL,ODELBS
      script = write('\\n\\n\\n'); write('HELP\\n')
      #line-pulse-duration = DTR=200,RTS=150
      color = 202

      [M5-Basic]
      device = /dev/tty-M5-5713049119
      local-echo = true
      map = INLCRNL,ODELBS
      #line-pulse-duration = DTR=200,RTS=150
      color = 203

      #[svf2]
      #device = /dev/ttyUSB0
      #baudrate = 9600
      #script = expect("login: "); write("root\n"); expect("Password: "); write("root\n")
      #color = 12

      [esp32]
      #device = /dev/serial/by-id/usb-0403_6014-if00-port0
      #exclude-drivers = !("cp210x")
      pattern = ^esp-(.*)
      device = /dev/tty-%m1
      #script = set{DTR=high,RTS=low}; msleep(100); set{DTR=low,RTS=high}; msleep(100); set{RTS=low}
      #script-run = once
      map = INLCRNL,ODELBS
      color = 129

      [usb-devices]
      pattern = ^usb([0-9]*)
      device = /dev/ttyUSB%m1
      local-echo = true
      map = INLCRNL,ODELBS
      color = 165

      [usb-ports]
      pattern = ^tty-(lower|upper)-(left|right)
      device = /dev/tty-port-%m1-%m2
      local-echo = true
      map = INLCRNL,ODELBS
      color = 165
    '';
    };
}
