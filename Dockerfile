FROM ruby:3.1

EXPOSE 4242

WORKDIR /workspace

# Install Stripe CLI for webhooks
RUN curl https://packages.stripe.dev/api/security/keypair/stripe-cli-gpg/public | apt-key add - &&\
  echo "deb https://packages.stripe.dev/stripe-cli-debian-local stable main" | tee -a /etc/apt/sources.list &&\
  apt update && apt install -y stripe nodejs npm

COPY Gemfile* /workspace/
RUN ["bundle", "install"]

RUN mkdir /workspace/client
COPY client/package.json /workspace/client/
RUN ["npm", "install", "--prefix", "/workspace/client"]

COPY . /workspace/

CMD ["ruby", "server.rb"]