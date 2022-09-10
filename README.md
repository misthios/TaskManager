# TaskManager

A simple shell and text file task manager

## Features
* add / remove tasks
* Show tasks
* projects & subprojects

## How to install TaskManager
Installation is simple:
	Download the script and place it in your path

## How to use TaskManager

### Add a task/project
Adding a task/ project can be done with the same command
```bash
tm add project.subproject task
```
this will create the following file :
~/.tasks/project/subproject/tasks
and populate it with the task.

### Removing a task
Removing a task can be done with the following command:
```bash
tm delete project.subproject taskname
```
### Removing a project/subproject
Removing a project can be done with the following command:
```bash
tm delete project.subproject 
```
warning: this command also deletes whole projects

### Finishing/Unfinishing a task
Finishing/unfinishing a task can be done with the following command:
```bash
tm finish project.subproject task
```
warning: this command finishes all the tasks with that name in the whole project when no subproject is given
Unfinishing a task is the same command but `unfinish` instead of `finish`

### Show all tasks in project
Showing tasks in a project can be done with the following command:
```bash
tm show project.subproject
```
This will list all tasks in a project or only in the specified subproject
