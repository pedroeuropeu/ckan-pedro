FROM python:3.9

WORKDIR /ckan

COPY . /ckan

RUN . ckan_venv/bin/activate


WORKDIR ckan_venv

RUN pip install ckanext-geoview
RUN pip install ckanext-scheming

WORKDIR src/ckan    

CMD python ../ckanext-scheming/setup.py develop && pip install -r ../ckanext-spatial/pip-requirements.txt && python ../ckanext-spatial/setup.py develop && pip install -r ../ckanext-geoview/dev-requirements.txt && python ../ckanext-geoview/setup.py develop && python setup.py develop && pip install -r dev-requirements.txt && pip install -r requirements.txt && ckan -c ckan.ini db init && ckan -c ckan.ini run
