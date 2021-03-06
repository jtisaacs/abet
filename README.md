# ABET Outcomes

[![Circle CI](https://circleci.com/gh/MIT-IR/abet.svg?style=svg)](https://circleci.com/gh/MIT-IR/abet)

Track ABET outcomes for various departments.

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script]. If the script ends with a message about not
having access to encrypted secrets see "Accessing Encrypted Secrets"

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using rails server:

    % rails server

To run the tests, you will need to have Chrome and chromedriver installed. On OS
X, you can install chromedriver with:

    % brew install chromedriver

## Using Browsersync for Faster Frontend Development

Browsersync is a tool for faster frontend development. It syncs scrolling and
livereloading between disparate devices, browsers, and windows. This means less
design time and more consistent designs.

You will use the browser sync along with your rails app. So you need to start
the rails app normally and, in another terminal instance, start the browser
sync.

The browser sync will proxy your running app and will handle the live reloading
and synchronization between multiple devices.

Run this rake task to start it:

    bundle exec rake browser_sync:start

## Accessing Encrypted Secrets

Private API keys are stored in Rails' [encrypted secret store]. To access these
values at runtime or to edit the encrypted secrets themselves, you will need
access to the private key. You will need access to these secrets to, for
example, import secrets or test storing attachments on S3.

Ask Jon Daries for the Rails master key. If Jon no longer has access to the key,
it can be retrieved from the Apache configuration for the production environment
(see `SetEnv` call for `RAILS_MASTER_KEY`). Once you have the key, add it as the
contents of `config/secrets.yml.key`.

[encrypted secret store]: http://guides.rubyonrails.org/5_1_release_notes.html#encrypted-secrets

## Importing Subjects

There is a rake task available to import the list of subjects. The task will
create new subjects that don't yet exist and update the name of subjects that
have changed since the last import. To run the import, run:

    rake subjects:import

This will import subjects for an approximation of the current term for the
departments that the ABET system currently tracks. You can override the default
term and the department to import for by specifying rake task arguments like so:

    rake subjects:import[2017FA,4]

This will import subjects in department 4 for 2017FA.

Running this rake task successfully requires access to the encrypted secrets.
See the "Accessing Encrypted Secrets" section above.

## Deployment

Deployment uses Capistrano and requires a couple pre-requisites. First, add the
following to `~/.ssh/config`:

    Host outcomes
      HostName outcomes.mit.edu
      User root
      GSSAPIAuthentication yes
      GSSAPIKeyExchange no
      GSSAPIDelegateCredentials yes
      GSSAPITrustDNS yes

Additionally, deployment requires an existing kerberos ticket:

    % kinit <username>@ATHENA.MIT.EDU

If the above fails with a message that the athena realm cannot be found, you may
need the following kerberos configuration in `etc/krb5.conf`:

    [libdefaults]
        default_realm = ATHENA.MIT.EDU

    [realms]
        ATHENA.MIT.EDU = {
            kdc = kerberos.mit.edu
            kdc = kerberos-1.mit.edu
            admin_server = kerberos.mit.edu
        }

Once you have a kerberos ticket, you can deploy with:

    % cap production deploy

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
