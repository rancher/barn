# Rodeo Management

These are the sources for the Rodeo Hobbyfarm scenarios.

Each scenario consists of a `scenario.yml` with metadata about the scenario and a `content` directory with markdown files for the individual scenario steps.

A scenario step must start with a metadata data block that contains the `title` of the step and the `weight` for ordering. Example:

```markdown
+++
title = "Introduction"
weight = 1
+++
```

## Deployment to Hobbyfarm

The scenarios are automatically deployed to NA and EU Hobbyfarm on each push to the `main` branch with a Github Action, if any files in `/Rodeos/` changed.

If you want to deploy a scenario manually, e.g. for testing, you need a kubeconfig for the target Hobbyfarm cluster and [hfcli](https://github.com/hobbyfarm/hfcli) installed.

You can then run the corresponding `make` target, e.g.:

```bash
make apply-rodeo-rancher
```

## Linting

To ensure consistency, all markdown files are linted with Markdownlint. A lint check is executed on every push by a Github Action.

To run the lint check locally, you need Docker installed, e.g. with Rancher Desktop and then run:

```bash
make lint
```

Markdownlint also allows you to fix a lot of violations automatically. You can do this by running:

```bash
make fix
```

## Creating a new scenario

To create a new scenario

* Add a new subdirectory under `/Rodeos/` that contains a `scenario.yml` and a `content` directory with one markdown file per scenario step
* Add a `apply-rodeo-name` and `get-rodeo-name` target to the `Makefile` and add them as dependencies to `apply-rodeos` and `get-rodeos`

Example `scenario.yml`:

```yaml
description: Introducing Rancher and its Kubernetes cluster and workload management capabilities
id: git-maintained-rodeo-rancher
keepalive_duration: 90m
name: Rancher Rodeo
pause_duration: 4h
pauseable: false
steps: null
virtualmachines:
- cluster01: sles-15-sp2
  rancher01: sles-15-sp2
```
