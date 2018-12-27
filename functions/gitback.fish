
function gitback -d "Back to branch"
  echo "gitback to the future"
  command git checkout @{-$argv[1]}
end
