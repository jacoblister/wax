FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH "$PATH:/workspaces/wax"
RUN apt update
RUN apt upgrade -y
RUN apt install -y g++ npm nodejs
RUN npm install -g typescript
