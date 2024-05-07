
Instalação 

é obrigatorio ter um SOLR running

docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:2.9-solr8

Precisa-se criar um banco de dados postgres e alterar os seguintes arquivos com as variaveis e ip necessarios:

CREATE USER ckan WITH PASSWORD 'ckan';
CREATE DATABASE ckan OWNER ckan;


.env
    -  
        POSTGRES_USER=ckan
        POSTGRES_PASSWORD=ckan
        POSTGRES_DB=ckan
        POSTGRES_HOST=192.168.56.1:5432
        CKAN_DB_USER=ckan
        CKAN_DB_PASSWORD=ckan
        CKAN_DB=ckan
        DATASTORE_READONLY_USER=datastore_ro
        DATASTORE_READONLY_PASSWORD=datastore_pass
        DATASTORE_DB=datastore

ckan.ini em ckna_venv/src/ckan
    -
    sqlalchemy.url = postgresql://ckan:ckan@192.168.0.37:5435/ckan

Após isso criar um servidor remoto do solr e substituir as seguintes variaveis caso necessario:

.env
    - CKAN_SOLR_URL=http://192.168.0.37:8983/solr/ckan

ckan.ini
    - solr_url = http://192.168.0.37:8983/solr/ckan


Com isso já será possível fazer o build da imagem e rodar docker-compose.

docker build -t pedroeuropeu/ckan-latest .
docker run -d -p 5000:5000 pedroeuropeu/ckan-latest

OU

docker-compose up

Ckan estará rodando em http://192.168.56.1:5000/

depois, basta criar um usuario admin dentro do container.

ckan -c /ckan/ckan_venv/src/ckan/ckan.ini sysadmin add admin