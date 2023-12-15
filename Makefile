all:
	colmena build

toontown:
	colmena build --on toontown
mele:
	colmena build --on mele
apply-toontown:
	colmena apply-local --sudo --node toontown
apply-mele:
	colmena apply --on @paperless
