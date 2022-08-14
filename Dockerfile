FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev libjpeg-dev 
RUN git clone https://github.com/jinfeihan57/p7zip.git
WORKDIR /p7zip/CPP/7zip/CMAKE
RUN cmake -DCMAKE_C_COMPILER=afl-gcc -DCMAKE_CXX_COMPILER=afl-g++
RUN make
#7z
RUN mkdir /p7zipCorpus
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/go-fuzz/10.zip
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/go-fuzz/11.zip
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/go-fuzz/12.zip
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/go-fuzz/13.zip
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/go-fuzz/14.zip
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/romney.zip
RUN wget https://github.com/strongcourage/fuzzing-corpus/blob/master/zip/zziplib/test.zip
RUN cp *.zip /p7zipCorpus

ENTRYPOINT ["afl-fuzz", "-i", "/p7zipCorpus", "-o", "/p7zipOut"]
CMD ["/p7zip/CPP/7zip/CMAKE/bin/7z_", "e", "@@"]


