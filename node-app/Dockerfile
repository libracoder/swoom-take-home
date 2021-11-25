#- Base Node Image----#
FROM node:17-alpine AS base
# install node
RUN apk add --no-cache nodejs tini
WORKDIR /app/src
# Set tini as entrypoint
ENTRYPOINT ["/sbin/tini","--"]
#copy project files
COPY package.json .

#--Dependencies --#
FROM base AS dependencies

# install node packages
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production

# copy production node_modules aside
RUN cp -R node_modules prod_node_modules
# install ALL node_modules, including 'devDependencies'
RUN npm install


# -- Test--
#run linters, setup and tests
FROM dependencies AS test
COPY . .

RUN npm run lint



#--- Release build---
FROM base AS release
# copy production node_modules
COPY --from=dependencies /app/src/prod_node_modules ./node_modules

# copy app sources
COPY . .

#expose port and define CMD
EXPOSE 3080
CMD npm run start
