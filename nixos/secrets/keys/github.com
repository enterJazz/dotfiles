{
	"data": "ENC[AES256_GCM,data:7GubDOVLr3HJjBM+o4ZFMn7sa9ZDSH8hzjyxxBbjAjkUU/aOSZl4xJrWV5VnmAI5qxQmfl1TULBott2bxDtkWgkcGlu1GBn9W6fBR4PLLjbTRJvGx6rMLSQ/eGYVrLkpHVaaoSaIx2vJiuF+ROMeBQD4tQCDD2fWHvS3Tfgs3tfh282EUOIkbGZTvfttA23jZ7tKwcoaKg0Hr8GbXiFiWJlT3TPZhzjUIby2rmB1O04fFdLy/a3msx3K9qmtA+ykofviO1rHn2zVDDQktEiwhMC2J6Kyr954Dg0WP2hbnumDmWyRTPm54pD2Qgb0QNn1v5e3hzYNFMC57E24p1GXWFik8OOxnMm9woc+DEX+jAHKVu3SwhCLwpfZrzJByBKxEloVnel5zS0XYvyKXJLxJefPOmQUDcDeK9k2Rz15Gv7Oq47FybCmZZpS+p7ihfn4z5N0G/I6KrzBMpRZygG2kzOdWLgPd3KI3nebDIM2l7dkSTsycCpc1T1Tv8pvxhJSnpXjFQ574t7lG5No73ckDw==,iv:pBnZuh4iImhIqqIC9FAhA/v+rLg8Y4lgBeP1iBufp18=,tag:bmUScDnjrnvjp5oCvDXzuQ==,type:str]",
	"sops": {
		"kms": null,
		"gcp_kms": null,
		"azure_kv": null,
		"hc_vault": null,
		"age": [
			{
				"recipient": "age1h72rxhnmvfp55rct4zj4frhuav0uf23sgre2e8qyrvqd3zu3x40swg0rhc",
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBrYmVWOGd3WkNTOVo5dDJS\nc1lySGl3UXJSNmJESlVGdlBLRHBUd25udlhBCkhGVlZZc2RBdFFpVzcvK3pYdTRO\neW1VUUZZTWNNbCtML3NNazliampLWWMKLS0tIDkvTTFRV3AycnUwRjgvWlg4QUVN\ncHlxK0NwcW12cHpybzhiRkExc0lxSzgKJeSs6JmWEV3+wiK8e1L2GwQ83Vc7YaLG\nC624VbUifqUce5m/5IydqwjCLqQS1svjmgIyhf2SnonONHNZZBq06w==\n-----END AGE ENCRYPTED FILE-----\n"
			},
			{
				"recipient": "age19407phf8dyq8qm79pvxxnfvhn8chx4z4caz7w8yk89rlg6llucuqstpnpe",
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSB5NnFWMjN0QnQ1cXhKSnZw\nVmdBd0hGbzRnZmVQNWVCNEFLVkJsRU5TRFJFCkp0NEdYV2NqUURub1JsS2dPd0l0\nWExNcUJvck9sckRjWnArM0tpSkNjWUUKLS0tIE92Q05ndEFQYnExcjZhMW8xVGV4\nYWlNUnh6Z011M2U2YW5FWUE5N3kwZk0KDO1lqJ25gNg+GTY7nNkDeARcDQnC4V/x\nJkWEOZRKfQdemfcxa/fc3R3ljCq32Osq3FIDnGKT2ZZ4ujD2SVdMIw==\n-----END AGE ENCRYPTED FILE-----\n"
			}
		],
		"lastmodified": "2023-11-07T16:31:50Z",
		"mac": "ENC[AES256_GCM,data:+ODpGaWA70jLm4QAwv/Z7pGl8nfQ+C4qeQWXJtE3Fe5hhS94IBUwY0dqjKdzLYYcqfgd09Y8MGtFSK/IElWGu/IjZsvltlDcj32pU68+5AXkKqRk9ELZVZQ0xQJi7D4iUBKugz1cjxrSsApfSN7mtdsbKHE02xvswk8T1EuGvGE=,iv:yUrUgqQ/16MhvaJ2mdcpWu3WJootAagj0qBFL7n871I=,tag:OfVDdztGCXbIzj8CHdTgRQ==,type:str]",
		"pgp": null,
		"unencrypted_suffix": "_unencrypted",
		"version": "3.7.3"
	}
}