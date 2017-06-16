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
        help: Show this message
        mutt-aliases: Export as mutt aliases.
        rename-all: Rename all files to the correct name
```

## Database

Each contact is saved into a separate file in `~/.contacts`. You can save as many properties as you want. The only one that is required is `name`.

### Example:

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
