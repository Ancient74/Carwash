FROM node
RUN mkdir -p /home/frontend
WORKDIR /home/frontend
COPY . .

RUN npm install
RUN npm run build
CMD npm run start
