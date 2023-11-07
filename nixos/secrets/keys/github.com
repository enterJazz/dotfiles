{
	"data": "ENC[AES256_GCM,data:7GubDOVLr3HJjBM+o4ZFMn7sa9ZDSH8hzjyxxBbjAjkUU/aOSZl4xJrWV5VnmAI5qxQmfl1TULBott2bxDtkWgkcGlu1GBn9W6fBR4PLLjbTRJvGx6rMLSQ/eGYVrLkpHVaaoSaIx2vJiuF+ROMeBQD4tQCDD2fWHvS3Tfgs3tfh282EUOIkbGZTvfttA23jZ7tKwcoaKg0Hr8GbXiFiWJlT3TPZhzjUIby2rmB1O04fFdLy/a3msx3K9qmtA+ykofviO1rHn2zVDDQktEiwhMC2J6Kyr954Dg0WP2hbnumDmWyRTPm54pD2Qgb0QNn1v5e3hzYNFMC57E24p1GXWFik8OOxnMm9woc+DEX+jAHKVu3SwhCLwpfZrzJByBKxEloVnel5zS0XYvyKXJLxJefPOmQUDcDeK9k2Rz15Gv7Oq47FybCmZZpS+p7ihfn4z5N0G/I6KrzBMpRZygG2kzOdWLgPd3KI3nebDIM2l7dkSTsycCpc1T1Tv8pvxhJSnpXjFQ574t7lG5No73ckDw==,iv:pBnZuh4iImhIqqIC9FAhA/v+rLg8Y4lgBeP1iBufp18=,tag:bmUScDnjrnvjp5oCvDXzuQ==,type:str]",
	"sops": {
		"kms": null,
		"gcp_kms": null,
		"azure_kv": null,
		"hc_vault": null,
		"age": [
			{
				"recipient": "age1mgm93qpxh2hnntgd69zacj6lx3j2xdfwjsc8jamvxh86gc8dqqrq7gmv7m",
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSB2ejEzRGNyZGNNM29jbUFv\nbEc5ZVRrZ25TWUVVcHRWcFhJek80clpMdEVjCnBxbmlTUXkrK09nOWlBekNsS0ho\nbUlyczNiMUdCOEZGZFhJUm5DUFo3Z2MKLS0tIFFJYy9zUHBnbDZWbytsc0h4bEJV\nbU9qZjhvaGRiVWU3b0ZpYUtJbHlsZjAKfo9mWbBP71Ev1bsOfpxdRi+6axkg2Gkt\n0sd26YI3PONz67PoIXk10IoKH0QvJEBuooKx89G3dhqCnsPCXj3L2w==\n-----END AGE ENCRYPTED FILE-----\n"
			},
			{
				"recipient": "age1h72rxhnmvfp55rct4zj4frhuav0uf23sgre2e8qyrvqd3zu3x40swg0rhc",
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBiTVBvbDA0RWgvN3gyMHhv\nWm5NaUN4aC9jdU1EbEFweGVTVExia3N3K0dVCnNXMVJRekp6WWlHSFRYRGdLRXBt\nSW5rOE5paW04eXUveHh5UEsxRG5xaFkKLS0tIEY2RjlIVzZ1NVhMNlZ0Yk1Bck5C\naGwxWHFMazdYYVhOVU9LWnpZaHNrekUKlIdHxcfBpmFS0uog9yczhUEx1QnDx8MA\nih4PsjdK+J9jmp/MV9uM5+nW/h8CC9X0u2RcI+slN762XNJBltGh9g==\n-----END AGE ENCRYPTED FILE-----\n"
			}
		],
		"lastmodified": "2023-11-07T16:31:50Z",
		"mac": "ENC[AES256_GCM,data:+ODpGaWA70jLm4QAwv/Z7pGl8nfQ+C4qeQWXJtE3Fe5hhS94IBUwY0dqjKdzLYYcqfgd09Y8MGtFSK/IElWGu/IjZsvltlDcj32pU68+5AXkKqRk9ELZVZQ0xQJi7D4iUBKugz1cjxrSsApfSN7mtdsbKHE02xvswk8T1EuGvGE=,iv:yUrUgqQ/16MhvaJ2mdcpWu3WJootAagj0qBFL7n871I=,tag:OfVDdztGCXbIzj8CHdTgRQ==,type:str]",
		"pgp": null,
		"unencrypted_suffix": "_unencrypted",
		"version": "3.7.3"
	}
}