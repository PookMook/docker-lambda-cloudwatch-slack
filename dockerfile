FROM amazon/aws-lambda-nodejs:18

ARG UNENCRYPTED_HOOK_URL
copy ./src/ ./
RUN npm install


# For Local testing enable the handler below and disable the one after it
CMD [ "index.autofire" ]
#CMD [ "index.handler" ]