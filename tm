#!/bin/sh

#==================================================================================================
#title           :Task Manager
#description     :Minimal Task Manager
#author          :Wesley van Tilburg
#license         :MIT
#date            :10/09/2022
#version         :0.2
#==================================================================================================

TASKBASEDIR="$HOME/.tasks"
CMD="$1"
shift
PROJECT="$1"
shift
TASK="$*"

die(){
	echo "$1"
	exit 1

}

set_path(){

	echo $PROJECT | grep -q -E '[.]{1}'
	if [ "$?" -eq 0 ]; then
		SUBPROJECT="$(echo "$PROJECT" | cut -d. -f2)"
		PROJECT="$(echo "$PROJECT" | cut -d. -f1)"
	        TPATH="$TASKBASEDIR/$PROJECT/$SUBPROJECT"
		ISSUB=true
	else
		TPATH="$TASKBASEDIR/$PROJECT"
		ISSUB=false

	fi
}

mark(){
	FINISH="$1"
	set_path
	FILES="$(find $TPATH -name "tasks" -type f)"
	for file in $FILES 
	do
		if $FINISH; then
			sed -i "s/\[ ] $TASK/[X] $TASK/g" $file
		else
			sed -i "s/\[X] $TASK/[ ] $TASK/g" $file
		fi
	done
}

show(){
	set_path
	if [ ! -d "$TPATH" ]; then die "Non existing project given"; fi
	if [ -z "$PROJECT" ]; then die "No project given"; fi
	if  $ISSUB ; then
		cat "$TPATH/tasks"
	else
		FILES="$(find $TPATH -name "tasks" -type f)"
		for file in $FILES 
		do
			if [ ! -s "$file" ]; then continue; fi
			SUBPROJECT="$(echo $file | rev | cut -d/ -f2 | rev)"
			NAME=""
			echo +------------ $PROJECT $SUBPROJECT ----------+
			cat $file
		done
	fi

}

add(){
	set_path
	if [ ! -d "$TPATH" ]; then 
		mkdir -p "$TPATH"
		touch "$TPATH/tasks"
	fi
	if [ ! -z "$TASK" ]; then echo "[ ] $TASK" >> "$TPATH/tasks"; fi

}

delete(){
	set_path
	FILES="$(find $TPATH -name "tasks" -type f)"
	for file in $FILES 
	do
		if [ -z "$TASK" ]; then rm -rf $TPATH; continue; fi
		sed -i "/$TASK/d" $file
	done

}


main(){
	mkdir -p "$TASKBASEDIR"
	case "$CMD" in
		show*) show $PROJECT ;;
		add*) add $PROJECT ;;
		delete*) delete $PROJECT ;;
		finish*) mark true $PROJECT ;;
		unfinish*) mark false $PROJECT ;;
		*) echo "Command not found"
	esac
}

main
