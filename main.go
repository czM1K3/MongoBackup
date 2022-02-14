package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"
)

func makeBackupDir(directory string) {
	fmt.Println("Creating backup directory")
	cmd := exec.Command("mkdir", "-p", "backup/"+directory)
	cmd.Start()
}

func main() {
	mongouri := os.Getenv("MONGODB_URI")
	if mongouri == "" {
		log.Fatal("MONGODB_URI is not defined")
	}

	currentTime := time.Now().Format("2006-01-02-15-04-05")
	fmt.Println("Creating folder: " + currentTime + "\"")
	makeBackupDir(currentTime)

	fmt.Println("Starting backup")
	cmd := exec.Command("mongodump", "--uri", mongouri, "--out", "backup/"+currentTime)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	_ = cmd.Run()

	fmt.Println("Backup finished")
}
