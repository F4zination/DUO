package main

import (
	"fmt"

	"github.com/duo/util"
)

func main() {
	config, configErr := util.LoadConfig(".")
	if configErr != nil {
		fmt.Println(configErr)
		return
	}

	fmt.Println(config.Output)
}
