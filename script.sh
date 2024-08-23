#============================== Elasticsearch ==============================

# membuat index
PUT http://localhost:9200/customers # or
curl -X PUT http://localhost:9200/customers -w "\n"

# melihat semua index *jangan menggunakan jq
GET http://localhost:9200/_cat/indices?v

# menghapus index
DELETE http://localhost:9200/purchases

# reset password
./bin/elasticsearch-reset-password --username elastic # result example: DI4hFgiOV8syFB-GKMR6

# melihat semua user
curl -u elastic -X GET "http://localhost:9200/_security/user?pretty" | jq
curl -k -u elastic -X GET "https://localhost:9200/_security/user?pretty" | jq

# copy file elasticsearch.yml di container ke dalam host
docker cp nama_kontainer:/path/to/container/elasticsearch.yml /path/to/host/elasticsearch.yml

# copy elasticsearch.yml di host ke dalam container
docker cp /path/to/host/elasticsearch.yml nama_kontainer:/path/to/container/elasticsearch.yml

# mebuat token kibana
bin/elasticsearch-create-enrollment-token --scope kibana --url https://prasorganic-elasticsearch:9200 

# mebuat cerificate authority *menghasilkan file .p12
bin/elasticsearch-certutil ca

# membuat sertifikat SSL
bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12

# menambahkan password baru ke keystore atau truststore
./bin/elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password
./bin/elasticsearch-keystore add xpack.security.http.ssl.truststore.secure_password

# memindahkan file certificate
mv elastic-stack-ca.p12  /usr/share/elasticsearch/config
mv elastic-certificates.p12 /usr/share/elasticsearch/config

#============================== Filebeat ==============================

# menambahkan ES_PASS ke filebeat *elastic password
filebeat keystore add ES_PASS -c /etc/filebeat/filebeat.yml

# test koneksi filebeat
filebeat test config -c /etc/filebeat/filebeat.yml
filebeat test output -c /etc/filebeat/filebeat.yml

# setup filebeat
filebeat setup -c /etc/filebeat/filebeat.yml

# menjalankan filebeat dan menampilkan log langsung ke stderr (standard error) 
filebeat -e