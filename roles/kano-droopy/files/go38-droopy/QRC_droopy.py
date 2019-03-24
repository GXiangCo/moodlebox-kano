#!/usr/bin/python
# coding: utf-8

import qrcode
import sys, os
import socket

""" 判斷是否為linux system """
if os.name != 'nt':
  import fcntl
  import struct
  """ 取得裝至上的訊息 """
  def get_interface_ip(ifname):
    get_s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(get_s.fileno(), 0x8915, struct.pack('256s', ifname[:15]))[20:24])

def get_lan_ip():
  ip = socket.gethostbyname(socket.gethostname())
  if ip.startswith('127.') and os.name != 'nt':
    interfaces = ["eth0", "eth1", "eth2", "wlan0", "wlan1", "wifi0", "ath0", "ath1", "ppp0",]
    for ifname in interfaces:
      try:
        ip = get_interface_ip(ifname)
        break
      except IOError:
        pass
  return ip

def getIP():
  myname = socket.getfqdn(socket.gethostname())
  get_s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  get_s.connect(('8.8.8.8', 0))
  ip2 = ('hostname: %s, localIP: %s') % (myname, get_s.getsockname()[0])  
  return ip2

#print(get_lan_ip())
#print(getIP())

def main():
  qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
  )

  droopyAddress = "http://"+get_lan_ip()+":8000"
 # droopyAddress = "http://www.gxiang.com.tw:8000"
 # droopyAddress = "http://go38.changeip.net:8000"
  qr.add_data(droopyAddress)
  qr.make(fit=True)

  img = qr.make_image(fill_color="black", back_color="white")
  img.save('/home/pi/go38-droopy/QRC_droopy.png')


if __name__ == "__main__":
  sys.exit(main())

