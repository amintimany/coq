**WARNING:** This document is a work in progress and intended as a RFC.
If you are not a Coq Developer, don't follow this instructions yet.

Introduction
============

The Coq Travis CI infrastructure is meant to provide lightweight
automatics testing of pull requests.
If you are on GitLab, their integrated CI is also set up.

More comprehensive testing is the responsability of Coq's [Jenkins CI
server](https://ci.inria.fr/coq/) see, [XXX: add document] for
instructions on how to add your development to Jenkins.

How to submit your development for Coq CI
=========================================

CI provides a convenient way to perform testing of Coq changes
versus a set of curated libraries.

Are you an author of a Coq library who would be interested in having
the latest Coq changes validated against your development?

If so, keep reading! Getting Coq changes tested against your library
is easy, all that you need to do is:

1. Put you development in a public repository tracking coq trunk.
2. Make sure that your development builds in less than 35 minutes.
3. Submit a PR adding your development.
4. ?
5. Profit! Your library is now part of Coq's continous integration!

Note that by partipating in this program, you assume a reasonable
compromise to discuss and eventually integrate compatibility changes
upstream.

Get in touch with us to discuss any special need your development may
have.

Maintaining your contribution manually [current method]
======================================

To add your contribution to the Coq CI set, add a script for building
your library to `dev/ci/`, update `.travis.yml`, `.gitlab-ci.yml` and
`Makefile.ci`. Then, submit a PR.

Maintaining your contribution as an OPAM package [work in progress] [to be implemented]
================================================

You can also provide an opam package for your contribution XXX at
https://github.com/coq/opam-coq-archive

Then, add a `ci-opam-XXX` target to the `.travis.yml` file, the
package XXX.dev will be tested against each Coq commit and pull
request.

- TODO: The main question here is what to do with `.opam` caching. We
  could disable it altogether, however this will have an impact. We
  could install a dummy Coq package, but `coq-*` dependencies will be
  botched too. Need to think more.

PR Overlays [work in progress] [to be implemented]
===========

It is common for PR to break some of the external tests. To this
purpose, we provide a method for particular PR to overlay the
repositories of some of the tests so they can provide fixed
developments.

The general idea is that the PR author will drop a file
`dev/ci/overlays/$branch.overlay` where branch name is taken from
`${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}`
that is to say, the name of the original branch for the PR.

The `.overlay` file will contain a set of variables that will be used
to do the corresponding `opam pin` or to overload the corresponding
git repositories, etc...

Since pull requests only happen on GitHub there is no need to test the
corresponding GitLab CI variables.

Travis specific information
===========================

Travis rebuilds all of Coq's executables and stdlib for each job. Coq
is built with `./configure -local`, then used for the job's test.

GitLab specific information
===========================

GitLab is set up to use the "build artifact" feature to avoid
rebuilding Coq. In one job, Coq is built with `./configure -prefix
install` and `make install` is run, then the `install` directory
persists to and is used by the next jobs.

Artifacts can also be downloaded from the GitLab repository.
Currently, available artifacts are:
- the Coq executables and stdlib, in three copies varying in
  architecture and Ocaml version used to build Coq.
- the Coq documentation, in two different copies varying in the OCaml
  version used to build Coq

As an exception to the above, jobs testing that compilation triggers
no Ocaml warnings build Coq in parallel with other tests.
