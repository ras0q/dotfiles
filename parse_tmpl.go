package main

import (
	"embed"
	"os"
	"path"
	"runtime"
	"strings"
	"text/template"
)

const (
	tmplDir = "common/templates"

	isDarwin  = runtime.GOOS == "darwin"
	isLinux   = runtime.GOOS == "linux"
	isWindows = runtime.GOOS == "windows"
)

//go:embed common/templates/*.tmpl
var templateFiles embed.FS

var commonTmplData = map[string]any{
	"IsDarwin":  isDarwin,
	"IsLinux":   isLinux,
	"IsWindows": isWindows,
}

func main() {
	// ls files
	files, err := templateFiles.ReadDir(tmplDir)
	panicOnError(err)

	outputDir := path.Join(osBaseDir(), "files", "generated")
	err = os.RemoveAll(outputDir)
	panicOnError(err)

	err = os.MkdirAll(outputDir, os.ModePerm)
	panicOnError(err)

	for _, f := range files {
		if f.IsDir() {
			continue
		}

		t, err := template.ParseFS(templateFiles, path.Join(tmplDir, f.Name()))
		panicOnError(err)

		outputFile, _ := strings.CutSuffix(f.Name(), ".tmpl")
		w, err := os.Create(path.Join(outputDir, outputFile))
		panicOnError(err)

		err = t.Execute(w, commonTmplData)
		panicOnError(err)
	}
}

func panicOnError(err error) {
	if err != nil {
		panic(err)
	}
}

func osBaseDir() string {
	switch {
	case isDarwin:
		return "mac"
	case isLinux:
		return "linux"
	case isWindows:
		return "windows"
	default:
		panic("unknown os")
	}
}
