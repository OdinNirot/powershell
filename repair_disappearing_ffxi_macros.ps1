# this script is designed to fix the habit playonline has of overwriting my macro sets at random times


# optional, fill these in with your character names if you want
$char1name = "Larry"
$char2name = "Moe"
$char3name = "Curly"

# required, pol installed path containing macro folders. Your macros are in a randomly named folder within, fill those in.
# if you can't guess which folder is your main characters, you can make a macro in-game called "test123". Then in powershell (from the USER folder),
# you can search for that text string with: gci -recurse | select-string -pattern "test123" | group path | select name
# if you find a file containing the string, you know that's the right folder.
$pol_path = "C:\Program Files (x86)\PlayOnline\SquareEnix\FINAL FANTASY XI\USER"
$char1 = "c66dc5"
$char2 = "146168b"
$char3 = "1535ac8"

# required, point this variable to a known good source folder (I just COPIED my main character's macro folder somewhere else)
$replacement_file_loc = "$env:USERPROFILE\Desktop\c66dc5"

# required, this is a hash table of what jobs i have assigned to which macro book (on main). If copying from one character to another you should use the same order on both
# leave the numbers, replace the jobs with yours
$mybooks = @()
$mybooks = @{
    "WAR" = 0;
    "MNK" = 1;
    "WHM" = 2;
    "RUN" = 3;
    "RDM" = 4;
    "THF" = 5;
    "PLD" = 6;
    "COR" = 7;
    "BST" = 8;
    "BRD" = 9;
    "GEO" = 10;
    "SAM" = 11;
    "NIN" = 12;
    "DRG" = 13;
    "SMN" = 14;
    "BLU" = 15;
    "blank1" = 16;
    "PUP" = 17;
    "DNC" = 18;
    "BLM" = 19;
    # end of books 0-19 that you can see in-game at one time, press the right arrow to go to the next page
    "SMN2" = 20;
    "RNG" = 21;
    "blank2" = 22;
    "blank3" = 23;
    "SCH" = 24
}

# if you made all the updates per the comments above, you should be good to run the script.

function runfix ($1) {
  # fix macros for one job or all jobs?
  $job = read-host -prompt 'Type job to fix macros for, or type all'
  if ($mybooks.contains($job)) {write-host -nonewline "I will fix the macro book for ";write-host -foregroundcolor yellow "$job".toupper()} else {write-host -foregroundcolor red "Invalid entry, quitting!";break}

  # filesystem numbering begins count at 0. So MNK macros are actually 10-19
  # which macro page number (or all)?
  $user_page = read-host -prompt 'Type which macro page to restore (1-10), or all'
  if ($user_page -eq "all") {
    $user_actual_page=@(($mybooks[$job]*10),($mybooks[$job]*10+1),($mybooks[$job]*10+2),($mybooks[$job]*10+3),($mybooks[$job]*10+4),($mybooks[$job]*10+5),($mybooks[$job]*10+6),($mybooks[$job]*10+7),($mybooks[$job]*10+8),($mybooks[$job]*10+9))
    }
  else {
    $user_actual_page = $mybooks[$job]*10+$user_page-1
  }
  foreach ($page in $user_actual_page) {
    $target = "mcr$page.dat"
    write-host "I think your problem is in the file $target"
    copy "$replacement_file_loc\$target" "$pol_path\$1\$target" -force; write-host -foregroundcolor yellow "$target replaced!"
  }
}

$menu = {
Write-Host
Write-Host " ***********************************"
Write-Host " * Fix Macros for which character? *"
Write-Host " ***********************************"
Write-Host
Write-Host " 1.) $char1name"
Write-Host " 2.) $char2name"
Write-Host " 3.) $char3name"
Write-Host " 4.) Quit"
Write-Host
Write-Host " Select an option and press Enter: "  -nonewline
}

Do {
  Invoke-Command $menu
  $Select = Read-Host
  Switch ($Select)
    {
    1 {
        runfix $char1
       }
    2 {
        runfix $char2
       }
    3 {
        runfix $char3
       }
    }
}
While ($Select -ne 4)
