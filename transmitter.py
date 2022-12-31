from secrets import token_hex
from Crypto.Hash import CMAC
from Crypto.Cipher import AES
from random import randbytes

cmd = input("Enter your 1 byte command in hex: ")
seq = input("Enter 4 bytes counter value: ")
ser_num = "00000000"  
#MAC GENERATING
secret = b'Sixteen byte key'
cobj = CMAC.new(secret, ciphermod=AES)
cobj.update(bytes(ser_num + seq + cmd, 'utf-8'))
MAC = (cobj.hexdigest()[:8])

print("trsm_msg =", ser_num + seq + cmd + MAC,'\n'"message Length:",len(ser_num + seq + cmd + MAC))

print(MAC) 
