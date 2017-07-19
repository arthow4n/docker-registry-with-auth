# docker-registry-with-auth

Run docker registry with cesanta/docker_auth. (demo)

## How to use

```
bash ./init.sh
docker-compose up

# For Google Oauth SSO,
# Get generated password at https://example.com:5001/google_auth
# then `docker login` with it
```

## References

- https://github.com/cesanta/docker_auth
    - https://github.com/cesanta/docker_auth/blob/master/examples/reference.yml

- https://docs.docker.com/registry/

- Regex testing: http://regexr.com/
