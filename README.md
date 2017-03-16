# Android SDK for Docker [![](https://images.microbadger.com/badges/image/thedrhax/android-sdk.svg)](https://hub.docker.com/r/thedrhax/android-sdk)

This image contains the latest versions of Android SDK and Gradle. Feel free to contribute ;)

## Examples

### Start a container and open the shell

```
docker run -it thedrhax/android-sdk bash
```

### Build the project in current directory

```
docker run -it -v $(pwd):/home/user/project -w /home/user/project -u $(id -u):$(id -g) thedrhax/android-sdk gradle build
```

### Persistent Android SDK and caches

* `-v android-sdk:/home/user/android-sdk-linux`
* `-v gradle-cache:/home/user/.gradle`
* `-v android-cache:/home/user/.android`
