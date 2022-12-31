from secrets import token_hex
from Crypto.Hash import CMAC
from Crypto.Cipher import AES
from random import randbytes

msg = input("13 byte Message: ")
mac = bytes(msg[19:26], 'utf-8')
cnt_val = 0
#VALIDATING CMAC FOR THE RECEIVED MESSAGE
secret = b'Sixteen byte key'
cobj = CMAC.new(secret, ciphermod=AES)
cobj.update(bytes(msg, 'utf-8'))
try:
  cobj.verify(mac)
  print ("The message is authentic")
except ValueError:
  print ("The message or the key is wrong")



