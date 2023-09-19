FROM ruby:3.2.2

# All variables here will be available by default for any container, the default
# values are set from the loaded ARGs in the build time. These environment vars
# can be overwritten by docker compose configs or in ECS task definition.
ENV WORK_DIR /application

RUN apt-get update -yqq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev

RUN mkdir -p ${WORK_DIR}

# `cd` to the `${WORK_DIR}` dir, all RUN commands from now will be from this path
WORKDIR ${WORK_DIR}

# Copy the Gemfile and Gemfile.lock into the image.
COPY Gemfile* ${WORK_DIR}/

# Install gems
RUN bundle install

# Copy all remaining app files to the image
COPY . ${WORK_DIR}

# Delete unnecessary files
RUN rm -rf /gems/cache/