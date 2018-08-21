FROM alpine as runtime
COPY --from=networkservicemesh/release /go/bin/sidecar-dataplane /go/bin/sidecar-dataplane
ENTRYPOINT ["/go/bin/sidecar-dataplane"]
