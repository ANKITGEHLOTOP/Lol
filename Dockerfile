FROM python:3.9.7-slim-buster
WORKDIR .
COPY . .

RUN apt-get update
RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt -y install curl
RUN apt-get -y install git
RUN git clone https://github.com/axiomatic-systems/Bento4.git && \
cd Bento4 &&\
apt-get -y install cmake && \
mkdir cmakebuild && \ 
cd cmakebuild/ && \
cmake -DCMAKE_BUILD_TYPE=Release .. &&\
make &&\ 
make install
RUN apt-get install -y aria2
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev ffmpeg mediainfo
RUN apt install ffmpeg
RUN pip3 install -r requirements.txt
# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r requirements.txt \
    && python3 -m pip install -U yt-dlp

# Set the command to run the application
CMD ["sh", "-c", "gunicorn app:app & python main.py"]

#!git clone https://github.com/axiomatic-systems/Bento4.git && cd Bento4 && apt-get -y install cmake && mkdir cmakebuild && cd cmakebuild/ && cmake -DCMAKE_BUILD_TYPE=Release .. && make && make install
