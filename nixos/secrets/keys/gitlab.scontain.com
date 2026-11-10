{
	"data": "ENC[AES256_GCM,data:JDb4uE85StPj27rLllx11LRaCbwy8cf7dDEoFoN1K3fwr0vG+00/N7Mz751w4ONTL7bW9O3w9eU8BTA+Fs+vMuGVz1wSYzIckLXwgsiniwUOVDQlWky7H/SLv7g91V66jX/OlrNbLaLrbMoY5O6/X/K+EiN9P3LAhkhwoZYkTyr7We0wku2vFAKTC2MmXZJuLt6Ydm3WRSSh6XssD0EjWp8GkEPq0LRX2hoazz6jYHAigHg8+wrc6cbs9QfaxohyO/eqXxZzvrGyGVVI/CzGrG5NPzAUYZkHzSFmhu5J02hC271x6rvGw1o8zh3H1dxhRxtHM4IbfvnRR+GEfI/7kI898trl0kT5xYr0osRfIRmR0/9ng9fbmzArjW1u4+fhZQcftI/Pq33kYUnlZoH7+76GetUM6cXLo0xckZ7fmY7alUQWYSoPjWU6+ncbsFPSZuaRfPGLO5N5VUbB03T2ptxSUjqt8wZWLpsisklXdgIQ8mDlLCT297xnHtd7gmLW4Qhy3/eThDNXjIm/gqqBsNSJSf6hBkPnrzjKZrgA+Ny3U30=,iv:DxNNIrSf3jhmjS6Nfk0SfI6p/qHUxxX5b+wAD+bgl/4=,tag:SKWMlcuJJZj/oTeE0fU1+A==,type:str]",
	"sops": {
		"age": [
			{
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBEVWFYbW1Fb3ZLZTJreGtn\naTZMTXh3MkxIUEZpQTNCeVZVRTBrZHNmSWx3CnVtamtLYnFzL0dYTHlKT0Zrd0Nt\nNUgydUlpUUNsbFVtVVNDYmZEZGZ0WlUKLS0tIDB4dlA3bmdCSHJ0VFh2QXgwZDAw\nRFBWQWdxd2JGUTJ6R3NoYlh1RnM1cXcKTU1rhhUazVtQrVJT5dPtSnTdckylOUBi\nfesSJ6flJJPfxHHQQUX2XdqjG8LHszsa2dZFe9wCd/makzGFEKf0ag==\n-----END AGE ENCRYPTED FILE-----\n",
				"recipient": "age1h72rxhnmvfp55rct4zj4frhuav0uf23sgre2e8qyrvqd3zu3x40swg0rhc"
			},
			{
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBvTUcrSkNFNUhHMm9COWxJ\nb3diS2FCVVU3OGRQdFRHSGlNUVNsVkZrV0NJCmowZG55dlA5a3l6MVhOTGxmNnZR\nR2gvOVltdFU4S3FXcUJzMkswUmlWeWsKLS0tIEt1U3JMcVJvbFVLTzgxQWhLS2dM\nRy9KM2ZGYllsZ2Nrb2xnd1MrOUxJSTAKUcvGjst2rhs8abDCBQDP1mfszUnmPGy0\nGp+kVHM2VxA7FNob6pddgeuGz4C8VXJOi4wIkuRcUY/fXdCWZxuh7w==\n-----END AGE ENCRYPTED FILE-----\n",
				"recipient": "age19407phf8dyq8qm79pvxxnfvhn8chx4z4caz7w8yk89rlg6llucuqstpnpe"
			}
		],
		"lastmodified": "2026-11-09T10:28:03Z",
		"mac": "ENC[AES256_GCM,data:yLtXiTqQhYBb9GDo6RIDfTKBWlRnuGqoOizt5ZWAJ6X+g/o2rfORwdGZY70Z+2B1N3mGhNvFJFLLwX+QoFakMtCnIKIUkYKK6PBSLnL+tMylFqfit/lPx6XKfkYXCB1qRffvaTQs6H/R7dRQBUKfe7tPj+rucDTwhymTmKLLKa8=,iv:y3uoqhxmoiow7IGAov77uCTuXAjOwFLu5OrTa2oj0Bs=,tag:vPkNTIBpSrFDM1DhGh/msQ==,type:str]",
		"version": "3.13.3"
	}
}
