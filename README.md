# Qore linenoise module

**The `develop` branch is retired.** Qore 3.0 and later ship the `linenoise` module as part of Qore
itself, so current development of it is in the [Qore repository](https://github.com/qoretechnologies/qore).
This branch has no code and builds nothing.

The repository itself is not retired: the release branches below are still maintained, because
Qore and Qorus releases on those release lines depend on the module.

## Release branches

Branches are named after the **Qore** release line they support, not the module version:

| Branch | Qore release line | linenoise module version |
| --- | --- | --- |
| `2.x` | Qore 2.x | 1.0.1 |
| `1.19.x` | Qore 1.19.x | 1.0.1 |
| `1.12.x` | Qore 1.12.x | 1.0.1 |
| `0.9.x`, `0.9.4`, `0.9.3`, `0.8.13`, `0.8.12`, `master`, … | earlier Qore releases | see the branch |

A fix for one of these release lines goes to its branch here, as a pull request against that
branch, and is built and released from there. Every other change goes to the Qore repository.

## Where the code is in Qore 3.0 and later

| What | Where it is in the Qore repository |
| --- | --- |
| `linenoise` binary module (line editing, history, completion and hints callbacks, `AbstractHistoryProvider`) | `modules/linenoise/` |
| Tests | `modules/linenoise/test/` and `examples/test/modules/linenoise/` |

## What this means for you

### On Qore 3.0 and later

- **Nothing to install.** `%requires linenoise` works out of the box. The module name and API are
  unchanged.
- **Remove the dependency.** Packages no longer need to require `qore-linenoise-module`; Qore
  installs the module itself.
- **Drop the conditionals.** `%try-module linenoise` guards are no longer needed, because linenoise
  is always present. Use a plain `%requires linenoise`.

### On earlier Qore releases

Nothing changes. Build and install the module from the branch for your Qore release line.

## History

The last code on `develop` is commit `ec790e398e49b63b28569618f1efb31513e8f179`
(linenoise module 1.2.0); the full history stays in this repository. The module moved into the Qore
build tree in Qore commit `d69995ecc3` ("add QoreHistory module, integrate linenoise into build
tree, update QoreRepl and qdp").

## Licensing

The module source is dual-licensed LGPL 2.1 / MIT and keeps that licensing in the Qore tree; the
license texts are on each release branch and in the Qore repository.
