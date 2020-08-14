FROM python:3.8-alpine

RUN mkdir -p /app
WORKDIR /app
ADD fetch.py /app/fetch.py
ADD gather-stats.lua /app/gather-stats.lua
ADD requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

CMD ["python3", "fetch.py"]
