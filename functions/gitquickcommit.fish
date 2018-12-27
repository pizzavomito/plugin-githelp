function gitquickcommit -d "Quick commit : add . + commit + push HEAD" 
    if test "$argv[1]" = ""
        echo 'Missing first argument : message commit'
        return 0
    end

    command git add . ; git commit -m "$argv[1]" ; git push origin HEAD
end