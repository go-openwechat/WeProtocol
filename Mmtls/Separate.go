package Mmtls

import (
	"encoding/hex"
	"wechatdll/clientsdk/baseutils"
)

type Separatea struct {
	title  string
	length uint64
	val    []byte
}

// 分包
func Separate(Data []byte) []Separatea {
	var NewData []Separatea
	for {
			if len(Data) >= 5 {
			Len := Data[3:5]
			title := hex.EncodeToString(Data[:1])
				dataLen := int64(baseutils.Hex2int(&Len))
				if int64(len(Data)) < 5+dataLen {
					// Incomplete packet
					break
				}
			NewData = append(NewData, Separatea{
				title:  title,
					length: uint64(dataLen),
					val:    Data[5 : 5+dataLen],
			})
				Data = Data[5+dataLen:]
		} else {
			break
		}
	}
	return NewData
}
