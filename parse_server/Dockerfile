FROM parseplatform/parse-server

RUN npm install nodemon &&\
    sed -i 's/"start": "node/"start": "nodemon/' package.json &&\
    apt update && apt install nano
