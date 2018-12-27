function gitbacklist -d "Show list of previous branch" 
	set nb_line $argv[1]
    if test "$nb_line" = ""
        set nb_line 10
    end
    
    set -l list_branches (command git reflog | grep -m $nb_line 'checkout: moving' | cut -d ' ' -f 8)
	set -l uniq_branches
	set -l uniq_index

    for i in (seq (count $list_branches))
	
        if not contains $list_branches[$i] $uniq_branches
            set uniq_branches $uniq_branches $list_branches[$i]
            set uniq_index $uniq_index $i
        end
    end

	set -l branch_count (count $uniq_branches)

    for i in (seq $branch_count)
        set -l branch $uniq_branches[$i]
        set -l label_color normal
        set -q fish_color_cwd; and set label_color $fish_color_cwd
        set -l dir_color_reset (set_color normal)
        set -l dir_color

        printf '%s %2d) %s %s%s%s\n' (set_color $label_color)  \
            $i (set_color normal) $dir_color $branch $dir_color_reset
    end

	set -l msg (_ 'Select branch by number: ')
	read -l -p "echo '$msg'" choice

    if test "$choice" = ""
	    return 0
    
    end

    
    set -l msg (_ 'Error: expected a number between 1 and %d, got "%s"')
	   
	if test $choice -ge 1 -a $choice -le $branch_count
		set num (math $uniq_index[$choice] - 1)
		#echo $choice $uniq_branches[$choice] $uniq_index[$choice]
		git checkout "@{-$num}"		    
	
	    return
	else
	    printf "$msg\n" $branch_count $choice
	    return 1
	end
	    
end

