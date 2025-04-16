{ unstable, ... }: {
  home.packages = [unstable.tio-new];
  xdg.configFile."tio/config" = {
    text = ''
      [default]
      baudrate = 115200
      databits = 8
      parity = none
      stopbits = 1
      color = 45
      log-directory = ~/.cache/tio/

      [FSGW]
      #device = /dev/serial/by-id/usb-1a86_USB_Single_Serial_5713049119-if00
      device = /dev/tty-M5-5713049119
      local-echo = true
      map = INLCRNL,ODELBS
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
      device = /dev/serial/by-id/usb-0403_6014-if00-port0
      script = set{DTR=high,RTS=low}; msleep(100); set{DTR=low,RTS=high}; msleep(100); set{RTS=low}
      script-run = once
      color = 13

      #[usb-devices]
      #pattern = ^usb([0-9]*)
      #device = /dev/ttyUSB%m1
      #color = 14

      [usb-ports]
      pattern = ^tty-(left|right)-(lower|upper)
      device = /dev/tty-port-%m1-%m2
      local-echo = true
      map = INLCRNL,ODELBS
      color = 165
    '';
    };
}
