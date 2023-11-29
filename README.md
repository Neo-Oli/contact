# Contact

This is a command line application for contact management with pipes in mind. It lets you choose a contact with FZF

```
Syntax:
    contact [COMMAND] [NAME] [PROPERTY]
    Commands:
    add: Add new contact
    edit: Edit existing contact
    delete: Delete contact
    get: Get property of contact (default)
    git: Interact with the git repositry directly
        Example: `contact git status`
        To enable the git repository features of contact you need to run:
            `contact git init`
        If you already have contacts you need to manually commit them:
            `contact git add --all;contact git commit -m "Commit all existing contacts"`
    help: Show this message
    mutt-aliases: Export as mutt aliases.
    rename-all: Rename all files to the correct name
```

## Database

Each contact is saved into a separate file in `~/.contacts`. You can save as many properties as you want. The only one that is required is `name`.

### Example

```
name=Max Muster
email=max@mail.tld
mobile=0000000000
phone=0000000000
address=Beispielweg 12
city=Atlantis
zip=9990
```

## Examples

```
contact get #this let's you choose a name and then the propery

contact get "Max Muster" "email" #get's you just the email address

contact add "Add a new contact. Opens an empty file with $EDITOR

contact mutt-aliases > ~/.mutt/aliases #export your contacts to the mutt alias file

# Usage in Pipes

mutt $(contact) #choose your email address

mutt $(contact "Max Muster" "email") #send email to Max Muster

termux-telephony-call $(contact) #call someone in you address book

termux-telephony-call $(contact "Max Muster" "mobile") #call Max Muster
```

## Installation

### Requirements

You need to install [fzf](https://github.com/junegunn/fzf) and git (for git integration)

### Installation
Copy the file `contact` to any directory in you `$PATH`. Make sure it's executable.
```
cp contact /bin/
chmod +x /bin/contact
```

### Enable git integration
To enable git integration go to the `~/.contacts` folder (create it if you've never run any `contact` command before and run `git init` all changes made with `contact` should now get added and commited automatically. If you have preexisting contacts you need to manually add them all to git and commit them. 

```
git add *
git commit -m "Initial commit"
```

### Environment variables

Certain advanced features can be set via environment variables:

- `CONTACT_SHORT_ALIASES=true` will cause mutt-aliases to just include the email and not the name

### Installation in Termux

Contact developed on Termux with Termux in mind, but running it on termux requires an additional step.

```
pkg install git fzf
cp contact $PREFIX/bin/ #or another directory in your $PATH
chmod +x $PREFIX/bin/contact
termux-fix-shebang $PREFIX/bin/contact
```

## Getting started

To create your first contact run `contact add`. This will open `$EDITOR` or `vi`. You can now add contact information. See the "Example" section for the syntax. `name` is required (as it gets used in the filename).

## Migrate from abook

```
mkdir -p ~/.contacts
cd ~/.contacts
awk '{print $0 "["> "file" NR}' RS='['  ../.abook/addressbook
sed 's/\[//g' -i *
sed 's/^.*\]$//g' -i *
rm file1 file2 #remove blank files
contact rename-all
```
