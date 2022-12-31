from secrets import token_hex
from Crypto.Hash import CMAC
from Crypto.Cipher import AES
from random import randbytes

msg = input("13 byte Message: ")
cnt_val = int(msg[8:16], 16)
#CALCULATING CMAC FOR RECEIVED MESSAGE
secret = b'Sixteen byte key'
cobj = CMAC.new(secret, ciphermod=AES)
cobj.update(bytes(msg[:18], 'utf-8'))
MAC = (cobj.hexdigest()[:8])
print(MAC,'\n',msg[18:26],'\n',msg[:18])
if (MAC == msg[18:26]):
    # print("hamed")
    # print((cnt_val < int(msg[8:16], 16)))
    # print((int(msg[8:16], 16) <= cnt_val+100))
    if ((cnt_val <= int(msg[8:16], 16)) and (int(msg[8:16], 16) <= cnt_val+100)):
        print("command=",msg[16:18])
        cnt_val = int(msg[8:16],16)
        cnt_val = cnt_val + 1      
    else:
        print("Invalid message")