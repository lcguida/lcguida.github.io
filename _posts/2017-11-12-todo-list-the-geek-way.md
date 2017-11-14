---
layout: post
title: "td: Todo list the geek way"
---

Today I was looking for a todo list that was simple. I did find `todoist` but
since I don't use apple store at work and my home computer runs Ubuntu I kept
searching.

I ended up finding [`td`](https://github.com/Swatto/td).

`td` is a simple command line todo list with the some interesting functionalities.

You can either have a `.todos` file in a directory or have a global database configured.

## Installation

For Mac, you can find `td` on `brew`, so simply do:

```bash
$ brew install td
```

For linux, you can either install it from source with `go get github.com/Swatto/td` or download the [executable](https://github.com/Swatto/td/releases) and put in your system (`/usr/local/bin`, for example).

## Configuration

The thing I found interesting in `td` was the ability to have a "per project" to-do list.

Simply create a `.todos` file in a folder and a to-do list is created and accessible whenever you're in this folder or any sub-folders (Yes, it is recursive).

On top of it, you can define a global database using the `TODO_DB_PATH` environment variable.

Just add something like this to your `.bashrc` or `.zshrc`:

```bash
export TODO_DB_PATH=$HOME/.config/todo.json
```

If `td` finds a `.todos` local file it will start that list, otherwise it will use the global database.

For a multi-computer solution, you can point this global database to a Dropbox folder so you can have it synchronized:

```bash
export TODO_DB_PATH=$HOME/myDropboxFolder/todo.json
```

## Usage

`td` usage is very simple. Just take a look at its help:

```
COMMANDS:
   init, i  Initialize a collection of todos
   add, a   Add a new todo
   modify, m   Modify the text of an existing todo
   toggle, t   Toggle the status of a todo by giving his id
   clean Remove finished todos from the list
   reorder, r  Reset ids of todo or swap the position of two todo
   search, s   Search a string in all todos
   help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --done, -d     print done todos
   --all, -a      print all todos
   --help, -h     show help
   --version, -v  print the version
```
