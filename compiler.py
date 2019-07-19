import re

f1 = open('text.txt')
lines = f1.readlines() # 1行毎にファイル終端まで全て読む(改行文字も含まれる)
f1.close() # lines2: リスト。要素は1行の文字列データ
binary = ''
lnum = 0

for line in lines:
    word = re.split(" |\n|\(|\)",line)


    mnemonic = [
            {
            "ADD": "0000",
            "SUB": "0001",
            "AND": "0010",
            "OR": "0011",
            "XOR": "0100",
            "CMP": "0101",
            "MOV": "0110",
            "SLL": "1000",
            "SLR": "1001",
            "SRL": "1010",
            "SRA": "1011",
            "IN": "1100",
            "OUT": "1101",
            "HLT": "1111"
            },
            {
            "LD": "00",
            "ST": "01"
            },
            {
            "LI": "000",
            "ADDI": "010",
            "JAL": "011",
            "B": "100",
            "CMPI": "101"
            },

            {
            "BE": "000",
            "BLT": "001",
            "BLE": "010",
            "BNE": "011"
            }
    ]

    reg = {
        "R0": "000",
        "R1": "001",
        "R2": "010",
        "R3": "011",
        "R4": "100",
        "R5": "101",
        "R6": "110",
        "R7": "111"
    }

    if word[0] in mnemonic[0]:
        op3 = mnemonic[0].get(word[0])
        Rs = "000"
        Rd = "000"
        d = "0000"
        if len(word) >= 3:
            if word[2] != "":
                Rd = reg.get(word[1])
                if word[2].isdigit():
                    d = format(int(word[2])&0xff, '04b')
                else:
                    Rs = reg.get(word[2])
                    d = "0000"
            else :
                if word[0]=='IN': Rd = reg.get(word[1])
                else:  Rs = reg.get(word[1])
        binary = binary  + format(lnum,'07b') + " : " +"11" + Rs + Rd + op3 + d +";"


    elif word[0] in mnemonic[1]:
        op1 =  mnemonic[1].get(word[0])
        Ra = reg.get(word[1])
        Rb = reg.get(word[3])
        d = format(int(word[2])&0xff, '08b')
        binary = binary + format(lnum,'07b') + " : " + op1 + Ra + Rb + d+";"

    elif word[0] in mnemonic[2] :
        op2 = mnemonic[2].get(word[0])
        if word[2] != "":
            Rb = reg.get(word[1])
            d = format(int(word[2])&0xff, '08b')
        else:
            Rb = "000"
            d = format(int(word[1])&0xff, '08b')
        binary = binary  + format(lnum,'07b') + " : " + "10" + op2 + Rb + d+";"

    elif word[0] in mnemonic[3] :
        cond = mnemonic[3].get(word[0])
        d = format(int(word[1])&0xff, '08b')
        binary = binary  + format(lnum,'07b') + " : " + "10" + "111" + cond + d+";"

    lnum = lnum + 1
    binary += "\n"

tmp = "-- Copyright (C) 1991-2005 Altera Corporation\n-- Your use of Altera Corporation's design tools, logic functions\n-- and other software and tools, and its AMPP partner logic \n-- functions, and any output files any of the foregoing \n-- (including device programming or simulation files), and any \n-- associated documentation or information are expressly subject \n-- to the terms and conditions of the Altera Program License \n-- Subscription Agreement, Altera MegaCore Function License \n-- Agreement, or other applicable license agreement, including, \n-- without limitation, that your use is for the sole purpose of \n-- programming logic devices manufactured by Altera and sold by \n-- Altera or its authorized distributors.  Please refer to the \n-- applicable agreement for further details.\n\n-- Quartus II generated Memory Initialization File (.mif)\n\n"

setting = "WIDTH=16;\nDEPTH=" + str(lnum) + ";\n\nADDRESS_RADIX=BIN;\nDATA_RADIX=BIN;\n\n"

print(tmp+setting+"CONTENT BEGIN")
print(binary)
print("END;")
f2 = open('sort.mif', mode = 'w')
f2.write(tmp+setting+"CONTENT BEGIN"+binary+"END;")
f2.close()
