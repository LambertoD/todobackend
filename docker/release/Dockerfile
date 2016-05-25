FROM ldiwa/todobackend-base:latest
MAINTAINER Lamberto Diwa <lamberto.diwa@dimensiondata.com

# COpy application artifacts
COPY target /wheelhouse

# Install application todobackend by activating virtualenv first followed by
# installing with --no-index to tell pip not to download any packages
# but instead use the wheelhouse directory.  Finally cleanup /wheelhouse
RUN . /appenv/bin/activate && \
    pip install --no-index -f /wheelhouse todobackend && \
    rm -rf /wheelhouse
