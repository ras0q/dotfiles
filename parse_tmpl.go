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
	"Home":      must(os.UserHomeDir()),
	"IsDarwin":  isDarwin,
	"IsLinux":   isLinux,
	"IsWindows": isWindows,
}

var tmpfFuncs = template.FuncMap{
	"escapeBS": func(s string) string {
		return strings.ReplaceAll(s, "\\", "\\\\")
	},
}

func main() {
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

		t, err := template.
			New(f.Name()).
			Funcs(tmpfFuncs).
			ParseFiles(path.Join(tmplDir, f.Name()))
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

func must[T any](t T, err error) T {
	panicOnError(err)
	return t
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
