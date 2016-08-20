package main

import (
    "fmt"
    "log"
    "strings"
    "github.com/gocraft/web"
    "net/http"
)

// This should be set during build time using -ldflags="-X main.PORT=$PORT"
var PORT string

type Context struct {
    HelloCount int
}

func (c *Context) SetHelloCount(rw web.ResponseWriter, req *web.Request, next web.NextMiddlewareFunc) {
    c.HelloCount = 3
    next(rw, req)
}

func (c *Context) SayHello(rw web.ResponseWriter, req *web.Request) {
    fmt.Fprint(rw, strings.Repeat("Hello ", c.HelloCount), "World!")
}

func main() {
    if PORT == "" {
        log.Fatal(fmt.Errorf("No valid port number specified."))
    }
    router := web.New(Context{}).
        Middleware(web.LoggerMiddleware).
        Middleware(web.ShowErrorsMiddleware).
        Middleware((*Context).SetHelloCount).
        Get("/", (*Context).SayHello)
    socket := strings.Join([]string{"0.0.0.0:", PORT}, "")
    fmt.Println("Serving @", socket)
    http.ListenAndServe(socket, router)
}
