#!/bin/bash

get_results() {
	for file in `find -name *_test_report.txt`
	do
		echo $file
		tail -3 $file
	done
}

get_results > report_for_all.txt