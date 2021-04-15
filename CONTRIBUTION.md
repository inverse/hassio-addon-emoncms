# Contributing

This guide outlines the steps required for contributing to this project.

## Submitting issues

Be sure to check existing issues first before submitting a new issue report.

Try to include as much information as possible, with screenshots if it helps explain the problem.

## Development

The easiest way to get your development environment setup is to use [Visual Studio Code][0] with the [Visual Studio Code Remote - Containers][1] extension. Follow the instructions on there on the pre-requisites to getting going.

First open this project within the container. It make take some time to pull the relevant base images and build the container.

Next, Open the task view and run "Start Home Assistant". This make take some time but after a few minutes you should be able to get a working instance of Home Assistant up on `http://localhost:8123`.

From here you'll be able to set things up like you would normally and install the MariaDB addon to provide the database for this extension.


[0]: https://code.visualstudio.com/
[1]: https://code.visualstudio.com/docs/remote/containers
