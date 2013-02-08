#!/bin/bash
func senddistress(){
}
func waitforecho(){
}
func waitfordistress(){
}
func makeecho(){
}
waitforecho can call for make distress, and then listen for an echo.
waitfordistress can start by listening with timeout and then diciding whether to respond.
Neither responds unless -r is set.
