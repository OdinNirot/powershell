# this script is designed to fix the habit playonline has of overwriting macro sets at random times

# it requires a good backup to restore from, and you need to update player_macro_folder with your macro folder name.
# This is probably the most recently modified folder in: C:\Program Files (x86)\PlayOnline\SquareEnix\FINAL FANTASY XI\USER

$pol_path = "C:\Program Files (x86)\PlayOnline\SquareEnix\FINAL FANTASY XI\USER"
$player_macro_folder = "c66dc5"

$restore_from = "$env:USERPROFILE\Desktop\c66dc5"

# this is a hash table of what jobs i have assigned to which macro book. It goes from the top down in-game. Update it to reflect yours
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
    "SAM" = 11;
    "NIN" = 12;
    "DRG" = 13;
    "SMN" = 14;
    "BLU" = 15;
    "PUP" = 17;
    "DNC" = 18;
    "BLM" = 19;
    "SMN2" = 20;
    "RNG" = 21
}


# fix macros for one job or all jobs?
$job = read-host -prompt 'Type job to fix macros for: '
if ($mybooks.contains($job)) {write-host -nonewline "I will fix the macro book for ";write-host -foregroundcolor yellow "$job".toupper()} else {write-host -foregroundcolor red "Invalid entry, quitting!";break}

# filesystem numbering begins count at 0. So MNK macros are actually 10-19
# which macro page number (or all)?
$user_page = read-host -prompt 'Type which macro page to restore (1-10): '
$user_actual_page = $mybooks[$job]*10+$user_page-1

$target = "mcr$user_actual_page.dat"
write-host "Preparing to replace file $target"
copy "$restore_from\$target" "$pol_path\$player_macro_folder\$target" -force; write-host -foregroundcolor yellow "$target replaced!"