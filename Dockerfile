FROM ghcr.io/defenseunicorns/leapfrogai/python:3.11-dev-amd64 as builder

WORKDIR /leapfrogai

COPY requirements.txt .

RUN pip install -r requirements.txt --user
RUN pip install wget --user

USER root
RUN mkdir -p backend/.model/
COPY backend/*/.model/* backend/.model/
COPY backend/*/main.py backend/main.py

RUN mkdir -p api/
COPY api/*/utils/ api/utils/
COPY api/*/backends/ api/backends/
COPY api/*/main.py api/main.py
COPY main.sh .
RUN chmod +x main.sh

FROM ghcr.io/defenseunicorns/leapfrogai/python:3.11-amd64

WORKDIR /leapfrogai

COPY --from=builder /home/nonroot/.local/lib/python3.11/site-packages /home/nonroot/.local/lib/python3.11/site-packages
COPY --from=builder /leapfrogai/ /leapfrogai/

EXPOSE 8080
EXPOSE 50051

ENTRYPOINT ["/leapfrogai/main.sh"]
