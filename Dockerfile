FROM  fleek/next-js:node-16

WORKDIR /app

ENV NODE_ENV='production'

COPY package.json package-lock.json ./

RUN npm install

COPY . ./

RUN npm run build

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini


RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

USER nextjs

ENV NEXT_TELEMETRY_DISABLED 1

EXPOSE 3000

HEALTHCHECK --interval=15s --timeout=45s --start-period=60s \  
    CMD node healthcheck.js

ENTRYPOINT ["/bin/tini", "--"]
CMD ["next-boost"]
