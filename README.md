# hub_keys

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with hub_keys](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module provides function hub_keys() that will fetch user keys from a gitlab
or github server via the /<username>.keys endpoint.  This list is converted into
a hash suitable to be passed to create_resources() (puppet < 4) or in a loop (puppet >= 4)

## Module Description

Github and Gitlab provide an endpoint that publishes user's public keys as configured
for the user.  To ease key administration, this module will synchronize the keys on the
server with the authorized_keys of a local user.

## Setup

Users will most likely already have keys configured in gitlab or github.  That's all!

## Usage

Use in a module and pass to create_resources:

``` $keys = hub_keys('monkey', 'https://gitlab.server.for.monkey')

create_resources(ssh_authorized_key, $keys)
```
