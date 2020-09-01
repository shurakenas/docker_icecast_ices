# Icecast+ices in Docker

# Run
```
docker run --restart=always --name=radio -d \
 --publish=8000:8000 --publish=8077:8077 \
 --volume=/mnt/music:/mnt/stream/tracks shurakenas/radio:v1
```
