let
  agenix-public = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDG5ofaDmw5OdwlfItAod9EJs6vSjj1tn1sQnM2IKlXOtD0WgfJXBlMs5fMmI/NEEvQSaT4nBtHVBMsFLCS0BHEfmC+9lt5IOyr1zSk2LS4CIEKY+YUEy1JquojsADk8+nnb2smnMQcZuq2izW0xsF49fMDykfkFNco14pFCZ4NCOiO1i9qZsqzCTM7l1GvF4WxNluTDoVMo813hwGcPqossmo3CZzYD+4Fmxg55h+OVEXHK6oigpFbDJLaeQh1M1MKpihn90pvJDyhlYjNcStkVheEi72AINYoSrYt2ghr1oVAFkoW10kHtqelS+ga9yyMWgBPKxSWLoCpeNnHy0ed lylac@garden";
in {
  "lylac-pass.age".publicKeys = [agenix-public];
  "deluge-auth.age".publicKeys = [agenix-public];
  "nextcloud-auth.age".publicKeys = [agenix-public];
}
