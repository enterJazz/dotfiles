{
	"data": "ENC[AES256_GCM,data:jh9lizgxA2DPNIrFNIv4zau0BEuGdeejuvIHDLsvVS365TnwTM3Z6cYfNiE60C37ooJaf2Fq33F7Xutm44fMUE9VeEg+RP3HZVrCG3Q5ZzrMX3/qrfzE1LvC7UzJKGBUCVlKfvch0bB2AcGWsjQUkg7nYZmmLydkvMLLYBcnwx0TEAT9UxJYraNdNO9S7GfNRsYicM7647nKJYJUiizgJ8Dsn1FJUcXL3X/oIii0R1ZPnhXM18FW1n1Hji9wrwKSFvuhJ+dVofbUXoAv/Kp7j72DbqIdxtI3fDrOT5mxWKkDn2nHycrRaSkV734rHvAb3MlI7thGA+yttsB2o/le+t8ADOZXwSyiEVnuWpJoPQe0SvdnFY+c1TODVO2WR9M3PcFpV+zJnuX7OaiOcd5Zl9BBT6Gcg0TCAoeD0L/ImbgAXpjodMXzoxwz/iFADG5MTcULLNi1NWCz38WKdpSb977b14g0qCMMUm+JYHcYMTyk8o7D68lFWXhryYJgHHrN2tBWmPP52MX+2KpdC4t2tgJGA7bWwyEIOwX8B9OdkdDQKmELbglmqhI14+psvx3n1+KnJGScJJ7ESctrwwvmrQnXH0YIobPLymPGbmeYea90QeI62LLuxSZYpBo=,iv:mY9shXnbAP3NMXEA3SD2KPlbYkYU3Cks9mI9uJfFysY=,tag:ctmZ8FDzghjuEnzqPVL2eQ==,type:str]",
	"sops": {
		"kms": null,
		"gcp_kms": null,
		"azure_kv": null,
		"hc_vault": null,
		"age": [
			{
				"recipient": "age1mgm93qpxh2hnntgd69zacj6lx3j2xdfwjsc8jamvxh86gc8dqqrq7gmv7m",
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBvb21Yb1g4VDhGOXRQSVVM\nZVZSNjVVc3FHS2FhVDVZVHJHSXZJaUdTeWxrClBCWm5aZVVIQUhTelNEZFZ4YS9K\nZWYwYW5qc1NweHc4LzJMSjMxcE5VRmMKLS0tIDNNZlhUK1pjNHoxajluM0l3WVZs\nMSt3NkZpLzZ6bUxoTVk5VmQzdlNjMkEKy2Vu+g99+R2jQ0FZBmrTL3lpdgLIp3Dw\nvc5mAFSoOBQQT7W+q3Jmsexsday/8RPKQR1xoKqmJPU/ClWFepV5OA==\n-----END AGE ENCRYPTED FILE-----\n"
			},
			{
				"recipient": "age1h72rxhnmvfp55rct4zj4frhuav0uf23sgre2e8qyrvqd3zu3x40swg0rhc",
				"enc": "-----BEGIN AGE ENCRYPTED FILE-----\nYWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBORzgybUpHQUZGRXZrQzdy\nK05qQ0JSWUdKVy9OYVlEaXpBVzdlVHl4dlJNCjdWa1NwQjUrMEF0TUVzd0ZqckE2\nYVpRTkZiMmJ1bWNPUFh4SnpaWHZlS3MKLS0tIDYxYW1obmtSU0ZucFZ0QXNwUEhL\neDFXYlh0U0l3VjZuT2dveFJOcXpHc3cKkwxfXfC5KF1wdwDFf87ye/TnYNjLdlo9\nqQjzZjBEbpfXSkBNKQjFeTeKvPEFfOvAhv8YMmiISfRyTgrrVRI0Pw==\n-----END AGE ENCRYPTED FILE-----\n"
			}
		],
		"lastmodified": "2024-05-07T13:14:42Z",
		"mac": "ENC[AES256_GCM,data:Ry+cPzO+Y0Bsfq5o5rr9aUdoM/oROdK9NWgFpqEFMH5XuItuZYdmd72T9mKZdfBcmpKEscm2tl3L6fFysMEfe/POL7M+IRYkzHEHKs7oWHiRoJOGGZyQUHMmBX19Vy6QU1qOYJPd/INbUepsbISAZIMaypIHK0rNJEn8xIexSh0=,iv:tCTwYhLBmNFxBk/919mBDIUPhnjQrWgU1cpiJyQyL+I=,tag:f3pqGv69vZ2IkPkb6Krt7Q==,type:str]",
		"pgp": null,
		"unencrypted_suffix": "_unencrypted",
		"version": "3.8.1"
	}
}