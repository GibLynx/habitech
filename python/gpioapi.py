#! /usr/bin/env python


import CGIHTTPServer as c
import BaseHTTPServer as b
import json as j
import cgi
import RPi.GPIO

APP_ID1 = 1
APP_ID2 = 2

PIN1 = 18
PIN2 = 23

GPIO.setup(PIN1, GPIO.OUT)
GPIO.setup(PIN2, GPIO.OUT)

class MyHandler(c.CGIHTTPRequestHandler):

    def __init__(self, req, client_addr, server):
        c.CGIHTTPRequestHandler.__init__(self, req, client_addr, server)

    def do_POST(self):
        ctype, pdict = cgi.parse_header(self.headers.getheader('content-type'))
        if ctype == 'application/json':
            length = int(self.headers.getheader('content-length'))
            data = self.rfile.read(length)
            json = j.loads(data)
            if json["id"] == APP_ID1:
                if json["switch"] == 1:
                    self.send_response(200)
                    self.send_header('Content-Type', 'application/json')
                    self.end_headers()
                    GPIO.output(PIN1, True)
                    return
                elif json["switch"] == 0:
                    self.send_response(200)
                    self.send_header('Content-Type', 'application/json')
                    self.end_headers()
                    GPIO.output(PIN1, False)
                    return
            elif json["id"] == APP_ID2:
                if json["switch"] == 1:
                    self.send_response(200)
                    self.send_header('Content-Type', 'application/json')
                    self.end_headers()
                    GPIO.output(PIN2, True)
                    return
                elif json["switch"] == 0:
                    self.send_response(200)
                    self.send_header('Content-Type', 'application/json')
                    self.end_headers()
                    GPIO.output(PIN2, False)
                    return
        self.send_response(403)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()


if __name__ == "__main__":

    host = ('0.0.0.0', 7080)
    httpd = b.HTTPServer(host, MyHandler)
    httpd.serve_forever()
