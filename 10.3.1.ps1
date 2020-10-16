# 10.3.1 Workflows

WorkFlow Test-Parallel {
    "First line executes"
    Parallel{
        sleep 2
	    1
	    2
        sleep 2
	    3
	    4
        sleep 2
	    5
	    6
        sleep 2
	    7
	    8
	    9
	    Sequence{
		    "A"
		    "B"
	    }
    }
}

Test-Parallel