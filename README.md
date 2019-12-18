# How to run
Environment configuration `env.file`
```
$ cat env.file
ENV_USER_LIST=user,user;test,test;
```

# Further Explanation

## Launch a new Docker container with the following command
```
docker run \
    --name l2tp-tunnel \
    --env-file ./env.file \
    -d --privileged \
    mkhole/l2tp-tunnel

    
```

## How to attach a living container
```
docker exec -it l2tp-tunnel ash
```

## Retrieve contianer details
```
docker logs l2tp-tunnel
```
