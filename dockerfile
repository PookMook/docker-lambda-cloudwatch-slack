FROM amazon/aws-lambda-nodejs:18

ARG UNENCRYPTED_HOOK_URL
copy ./src/ ./
RUN npm install
CMD [ "index.handler" ]