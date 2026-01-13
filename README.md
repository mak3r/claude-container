# claude-container
claude code from a container intended to run on linux with wayland

## Build it
`make build`

## Run it
`make run`

### Basic info
* This container mounts the home directory of the user running the container and allows the user to run the chromium browser via claude code for authentication purposes. Warning: this setup/configuration may not be the most secure for running a kiosk browser. It is intended purely as a way to isolate claude code from the system it is running on.
* There are configuration parameters in the `Makefile` 
    * `IMAGE_NAME` this is the name you want for the docker image
    * `DEVELOPMENT` this is the name of the directory where code is stored - I use a shared directory for multiple user personas. For most individual developers who keep their code in their home directory, this is unnecessary but may need to be set or removed (including podman command arguments) for the run to work.
* Once you run the container, you will be at the command line at `/` in the container. `cd` into your code directory and run `claude` to get started.
* You can use an external text editory like vs code to work on it alongside clause. 

### Notes

* I use podman instead of docker. If you use docker, you will need to change the commands
* I may want to include vs code in the container at some point
